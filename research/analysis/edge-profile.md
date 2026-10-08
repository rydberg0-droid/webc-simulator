# Edge 막 끝단(film edge) 단면 프로파일 — 분석 (2026-10-08)

입력: `research/sources/edge-profile.md`(특허 발췌 위주, 신뢰도 중~하), 참고 `research/sources/cleaning-etch-rates.md`, `research/analysis/cmp.md`, `webc_simulator_v3.html`(읽기만 함).
표기: **[src]** 문헌 수치 그대로 · **[환산]** 문헌 수치를 정의에 맞춰 바꿈 · **[est]** 추정(근거 서술) · **[legacy]** 현행 엔진 값 유지.

---

## 0. 요약

| 공정 | 전이 폭 W 기본(두께 0→100 % 거리) | 형상 | 근거 | 신뢰도 |
|---|---|---|---|---|
| Plasma bevel: PES(strip), BVS, 베벨 plasma clean, 베벨 증착 | **0.5 mm** (범위 0.05~1 mm) | `exp` (포화형) | US 8,562,750 "of the order of 0.5 mm"(종래 confined plasma) | 중-하 |
| Gas(무플라즈마) 베벨 처리 | 0.5 mm | `exp` | plasma 값 준용 | est |
| Wet edge: EEW/BEW, wet clean edge mode, spin etch | **0.13 mm** (범위 0.05~0.2 mm) | `smooth` | US 9,685,353 taper "<200 µm", 실시예 "about 127 µm" | 중-하 (Cu EBR → 유전막 일반화는 est) |
| 베벨만(edgeClean, clean edge dd=0, depo edge 범위 없음) | 0.1 mm [legacy: LB±0.05] | `smooth` | 근거 없음 | est |
| Photo zone 경계(Ring/EBR/PSES), CMP 수동 패턴 경계, Etch 보호폭 | legacy `2·rampMm` = 0.04 mm | `smooth` | 근거 없음(변경 보류) | legacy |
| CMP edge roll-off | 변경 없음 (`eroW` 4 mm, Lp) | — | cmp.md §3.3 | 중 |

- **핵심 진단 2가지 (코드 확인)**
  1. **격자보다 좁은 컷.** 현행 컷은 `1−smooth(dd−r, dd+r, d)`, r = rampMm = 0.02 mm이다. 즉 두께 0→100 % 폭이 **40 µm**다. 그런데 엔진 격자 간격은 `d > 2 mm`(R < 148)에서 **0.04 mm**다(`buildProfile`: `s+=x<148?.04:.01`). PES 2.5 mm 컷은 실제로는 **격자 1칸짜리 수직 절벽**이다. 사용자가 본 "칼 같은 각도"는 표시 탓만이 아니고 엔진 결과다.
  2. **"부채꼴" 박막화.** `removal()`의 strip·bvs는 모든 막에 같은 비율을 곱한다(`ly.h[i]*=(1-w)`). 그래서 전이 구간에서 96층 Mold의 **모든 계면이 같은 비율로 얇아져 한 점으로 모인다**. 실제 플라즈마 식각은 위에서부터 깎는다. 식각 전선(경사면) 아래 막은 온전히 남고, 각 막은 경사면과 만나는 곳에서 끝난다. 이 비율 곱 방식이 "높은 층 mold 후 PES 시 부자연스러움"의 직접 원인이다.
- **권장:** strip·bvs를 위에서 깎는 budget 방식(기존 `consume()` 재사용)으로 바꾼다. 공정별 W(plasma 0.5 mm, wet 0.13 mm)를 적용하고, 컷 기준점은 **dd = bare 경계**(EE 의미와 같음)로 둔다. ⚙ `edgeModel: 'process'`(기본)/`'legacy'`(현행 재현) 스위치를 둔다. 끝단 근처 격자는 0.01 mm로 세분한다.

---

## 1. 현행 `rampMm` 사용처 전부 (webc_simulator_v3.html, 줄 번호는 조사 시점)

| # | 줄 | 위치 | 용도 | 식 | 권장 프로파일 키 |
|---|---|---|---|---|---|
| 1 | 358 | ⚙ 입력 `#rampUm` "컷 경사폭 (µm)" 기본 20, `data-set="engine"` | 전역 설정 UI | — | 라벨 변경: "기타 경계 폭(Photo·CMP 패턴·Etch 보호)" |
| 2 | 641 | `let … rampMm=.02` | 전역 초기값(mm) | — | 유지 |
| 3 | 646 | ENG 주석 | rampUm 변경 → geoDirty(전부 재계산) | — | `edgeModel` 변경도 geoDirty |
| 4 | 923 | `SETTINGS.rampUm` | 범위 2~300 µm, def 20 | — | 유지 |
| 5 | 1346 | `depoWeight('edge', rng)` | 베벨 증착 범위(BVO 등) 안쪽 끝 | `max(1−smooth(d−r,d+r,p.d), 1−smooth(LB−.05,LB+.05,p.d))` | `plasmaBevel`(est, 증착 데이터 없음) |
| 6 | 1388–1390 | `removal()` strip·bvs·eew·bew | Edge 제거 컷 | `cut=1−smooth(dd−r,dd+r,p.d)` · bvs는 면별 d · eew/bew는 `smooth(±.3 f)·cut` | strip/bvs → `plasmaBevel` + top-down budget, eew/bew → `wetEdge` |
| 7 | 1425 | `etch()` prot | Etch Edge 보호폭 경계 | `.05+.95*smooth(prot−r,prot+r,p.d)` | legacy 유지 (보호 수단 미정 — §1.4) |
| 8 | 1507 | `advanceTo` geoDirty | `rampMm=readNum('rampUm')/1000` | — | `edgeModel`도 같이 읽음 |
| 9 | 1711 | `applyStep` clean `mode:'edge'`, dd>0 | 베벨 세정/가스 PES 폭 | `1−smooth(dd−r,dd+r,p.d)` (dd=0이면 `LB±.05`) | cat별: wet→`wetEdge`, plasma→`plasmaBevel`, gas→`gasEdge` |
| 10 | 2011 | `applyPhoto` `win()` | Ring/EBR/PSES zone 경계 PR | `smooth(q0−r,q0+r)·(1−smooth(q1−r,q1+r))` | legacy 유지 (§1.3) |
| 11 | 2084 | `cmpManualPattern` | 수동 패턴 영역 시작 patFrom | `smooth(patFrom−r,patFrom+r,d)` | legacy 유지 (밀도 경계일 뿐, 물리 폭은 Lp가 담당 — cmp.md §2.3) |

`rampMm`을 쓰지 않는 경계(참고, 변경 대상 아님): `removal` frontClean/backClean `smooth(.15,.6,±f)`, edgeClean `1−smooth(LB−.05,LB+.05,d)`, depo edge 범위 없음 `1−smooth(LB,LB+.6,d)`, PECVD `depoWeight` front/back(apexTaper/wrap), `coatWeight` `smooth(−.25,.6,f)`, CMP `E(d)`(eroW)·`wc=smooth(.3,.8,f)`.

참고: 엔진 `p.d = 150 − R`(mm, 반경 방향 Edge로부터의 거리)이다. 후면 점도 같은 d를 쓴다. smoothstep 0→1 구간 폭이 `2r`이므로, **현행 전이 폭 W_legacy = 2·rampMm = 40 µm(중심 = dd)**이고, 10–90 % 폭은 0.608·W = 24 µm다.

---

## 2. 공정별 끝단 프로파일 모델

### 2.1 정의 (공통)
- **W(mm)**: 막 두께 0 %(bare)에서 100 %(원래 두께)까지 반경 거리. US 8,562,750의 "transition (full thickness → complete removal) distance" 정의와 같다.
- **기준점(anchor)**: 사용자 입력 Edge→dd는 **bare 경계(막이 완전히 없어지는 가장 안쪽 위치)**로 본다. 전이 구간은 `[dd, dd+W]`(안쪽)다.
  - 근거: EE·edge exclusion은 광학 검사로 보이는 막 끝(SST 2005의 "0.7 mm edge exclusion", 광학현미경 12점 측정)으로 정의한다. 엔진 `metrics().exD`(막 < 1 nm 최대 d)와 EE 경고도 같은 의미다.
  - 현행은 중심 기준(50 % 지점 = dd)이다. legacy 모드에서만 유지한다.
- **잔막 비율 F(u)**, `u=(d−dd)/W ∈ [0,1]`, F(0)=0, F(1)=1. d<dd에서는 F=0, d>dd+W에서는 F=1이다.

### 2.2 Plasma bevel (PES strip, BVS, 베벨 plasma clean, Gas PES)
- **W 기본 0.5 mm [src, 중-하]**: US 8,562,750(Lam, Chen & Kim)에 "conventional confined plasma bevel clean" transition이 "of the order of 0.5 mm"로 나온다.
  - 같은 특허의 다른 값: passivation 마스크 + 고선택 공정 "< 0.05 mm(계측 분해능 한계)", 다른 실시 "0.1 mm or less", 비교 실시 "on the order of 1 mm".
  - → **범위 0.05~1 mm**. 0.05~0.1 mm는 특수(마스크·고선택) 공정 값이므로, 일반 PES 기본값으로는 종래 confined plasma 값 0.5 mm를 채택한다. 사용자 체감("칼 같지 않은 slope")과도 맞는다.
  - US 8,083,890: 기준 공정의 zero-etch 경계가 Edge에서 "> 3 mm", gas 조절 시 2~2.5 mm다. 이 값은 **식각 영향이 미치는 범위**이고, 두께 0→100 % 폭이 아니다(목표 exclusion < 2/<1/<0.5 mm). 플라즈마 영향 꼬리가 수 mm까지 간다는 정성 근거로만 쓴다. W 값으로 쓰지 않는다.
  - US 8,398,778: apex 7000 Å/min, 상부 bevel(R 149.8 mm) 2000 Å/min이다. 0.2 mm 안에서 식각률이 3.5배 떨어진다 → 거리 감쇠가 지수형이라는 정성 근거다. [환산] 지수 감쇠로 보면 λ ≈ 0.2/ln 3.5 ≈ 0.16 mm다. W(95 %) = 3λ ≈ 0.48 mm로 0.5 mm와 맞는다. 다만 이 두 점은 베벨 경사면 위 값이고 막 두께 정보가 없으므로 **정성 일치로만** 기록한다.
- **형상 `exp` [est, 물리 근거]**: 좁은 gap(0.3~0.9 mm) 안으로 들어간 플라즈마 라디칼 밀도는 확산-재결합 균형으로 지수 감쇠한다(n ∝ e^(−x/λ)). 시간 t 뒤 식각 깊이 E(x) = R₀t·e^(−x/λ)이고, 막 끝 x₀에서 E = H이므로 잔막 = H·(1 − e^(−(x−x₀)/λ))가 된다.
  - **bare 경계에서 가장 가파르고 안쪽으로 점근 포화한다**("slightly rounded"·"steep" 서술과 모순 없음).
  - 유한 폭으로 자른 정규화형: `F(u) = (1 − e^(−3u)) / (1 − e^(−3))`. W = 3λ(95 % 지점)로 둔다.
  - 10–90 % 폭 ≈ 0.61·W(smoothstep 0.608·W와 거의 같음) → 지표 비교에 일관성이 있다.
  - 최대 기울기 = H·3/(W·0.95)이다. 예: Mold 7.2 µm, W 0.5 mm → 45 µm/mm ≈ **2.6°**. 현행은 7.2 µm가 40 µm smoothstep 안에서 떨어지므로 최대 1.5·7.2/40 → ~15°(격자 40 µm라 사실상 1칸 절벽)이고, 표시 과장 시 수직으로 보인다.
- **두께 의존성**: 지수 감쇠 모델에서 같은 과식각 비율(R₀t/H 일정)이면 형상이 H와 무관하다 → **기본 kH = 0**(§4).

### 2.3 Wet edge (EEW/BEW, wet clean edge mode, spin etch)
- **W 기본 0.13 mm [src→환산, 중-하]**: US 9,685,353(Novellus, Cu EBR, H₂SO₄/H₂O₂ spin) taper width(full thickness → no metal) "< about 200 µm", 실시형태 "< 100 µm", "< 50 µm", 실시예 "estimated to be about 127 µm".
  - 127 µm를 0.13 mm로 반올림했다. 범위 0.05~0.2 mm.
  - Cu EBR 값을 유전막 HF/BOE spin etch에 일반화하는 것은 **est**다. 메커니즘(액층 확산경로가 taper를 정함)은 약액에 무관하다는 원문 서술이 근거다.
- **형상 `smooth`**: 확산 지배 전선은 erfc형이고, smoothstep은 erf를 잘 근사한다(최대 오차 수 %). 현행 함수를 재사용할 수 있다.
- **쓰지 않는 값**: SST 2005(SEZ, 49 % HF)의 "0.7 ± 0.1~0.3 mm", 회전수 의존 0.35~1.2 mm는 **exclusion 위치와 그 산포**다. 전이 폭이 아니다. 위치 산포 ±0.1~0.3 mm는 원주 방향 변동이고, 1D 단면 W에 섞지 않는다. 회전수·N₂ 유량 의존성은 지시대로 파라미터화하지 않는다.
- ACM "bevel etch/cut accuracy 1–7 mm, ±0.1 mm"도 위치 설정 범위·정확도이고 W가 아니다.

### 2.4 Photo EBR / WEE / Ring, CMP 경계, Etch 보호, 베벨만 처리
- **Photo zone(applyPhoto)**: EBR resist 끝단 단면 수치는 공백이다(US 7,197,178은 계측 해상도 7 µm만 있음). WEE(노광)·Ring 노광 경계는 광학 경계라 µm급으로 날카롭다 [est]. EBR(용제 분사)은 wet 성격이라 0.1 mm급일 가능성이 있지만 근거가 없다.
  - → **legacy(2·rampMm) 유지**. 용제 EBR의 edge bead(hump)는 모델 밖이다.
- **CMP**: 경계 폭은 Lp(평탄화 길이)·eroW(roll-off)가 이미 결정한다(cmp.md). `patFrom`의 rampMm은 밀도 지정 경계일 뿐이다 → 유지. PES로 생긴 0.5 mm 경사 단차 위의 CMP는 cmp.md §3.2(해상된 지형)가 자연히 처리한다. 계단이 완만해지면 TOPO 판정이 바뀔 수 있으므로 qa 확인 항목으로 둔다.
- **Etch prot**: 보호 수단(PR barrier/shadow ring/PEZ)이 단계에 정의되어 있지 않다 → legacy 유지. 후속으로 `prot` 경계를 `plasmaBevel`로 바꾸는 선택지는 §6 공백으로 둔다.
- **베벨만(edgeClean, clean edge dd=0, depo edge 범위 없음)**: LB±0.05(=0.1 mm)는 근거가 없지만 베벨 기하(LB=0.30/0.38 mm) 안의 경계라 유지한다(`bevelOnly` W 0.1 [est/legacy]).

---

## 3. 다층막 계단(stair-step) / undercut 모델 (1D 단면)

### 3.1 수직 성분: 위에서 깎는 budget (권장, 핵심)
점 i에서 막 j(위→아래)를 모두 지우는 데 필요한 기준막 환산 budget은 `need_i = Σ_j h_ij / r_j`(r = 상대 식각률)다. 전이 구간 budget은 다음과 같이 둔다.

```
B_i = need_i · (1 − F(u_i))           (d ≥ dd)
B_i = need_i · (1 + OE)                (d < dd, bare 영역; OE 초과분은 Si 손실 — 기존 siLoss 경로 유지)
```

`consume(i, B_i, rates)`로 위에서부터 소모한다(기존 커널 재사용).

- **비선택 PES(기본 rates 전부 1)**: 총두께 프로파일 = H·F(u)로 정확히 W 형상을 따른다. 각 막 j의 끝단 T_j는 `F(u)=1 − cum_j/need`인 지점, 즉 **막 경계가 경사면과 만나는 점**이다. 부채꼴 대신 "경사면으로 잘린 적층"이 되며, 이것이 기하학적 계단이다.
- **선택비가 있는 경우**(gas PES = clean 경로, 또는 PES rate 옵션): 느린 막이 W 안에서 더 넓은 테라스를 차지한다(`cum_j`가 h/r로 가중됨). 막질 rate는 기존 `CLEAN[k].r`(CLN_DB er/tgt)와 `ETCH[k].r`를 그대로 쓴다.
- PES rate 옵션(선택, est): `pesRates:'uniform'`(기본, "비선택 strip"·[문헌 없음]) | `'cf4'`(CLN_DB.cf4 비율 사용: SiN/SiO₂ = 110/51 = 2.16, W03 실측).
- **clean edge mode**는 이미 `clean(rates, D, wf)`로 위에서 깎는다 → wf만 공정별 F로 교체한다(D = 입력 제거량, need 아님).

### 3.2 측면 성분: 노출 측벽의 차등 후퇴 (est, 기본 켬, 영향 작음)
문헌 정량값은 없다("stepped edge profile"·"staircase bevel" 검색 실패 — sources §못 찾은 것). 다음 식을 제안한다.

```
ΔT_j = κ_lat · (r_j / r̄ − 1) · L_ov          [µm, +면 안쪽으로 후퇴]
  r̄    = 전이 구간 스택의 두께 가중 평균 rate = Σh_j / Σ(h_j/r_j)
  L_ov = OE · need_ref                           (등방 식각에서 과식각 budget 1 µm ≈ 측면 1 µm)
  κ_lat: wet 1.0 (등방) · plasma bevel 0.3 (라디칼 주도 부분 등방, est) · 이방 Etch 0
  OE (과식각 비율) 기본 0.2 (est)
```

- 균일 rate면 ΔT_j = 0이다(공통 후퇴는 이미 dd/W에 포함). **차등만 계단을 만든다.**
- 예시 1(CF4/O₂ PES 옵션, Mold 48쌍 Ox 90/Nit 60 nm, 7.2 µm): r_SiN/r_SiO₂ = 2.16 → r̄ ≈ 1.27(SiO₂ 기준), need ≈ 5.65 µm, L_ov ≈ 1.13 µm, κ 0.3 → SiN 후퇴 +0.24 µm, SiO₂ −0.08 µm. **계단 ~0.3 µm**로 mm 단면에서는 보이지 않는다. 지표로만 의미가 있다.
- 예시 2(wet BOE edge mode로 ON 스택 과식각): r_SiN/r_SiO₂ = 8.2/490 → SiO₂ 후퇴가 L_ov만큼 생긴다(κ 1). 과식각 1 µm면 oxide 1 µm recess → **SiN 처마(overhang)**가 된다. 3D NAND wet 공정의 comb 형상과 정성적으로 맞는다.
- **1D 한계**: 막당 점별 두께 h(d)로는 overhang을 표현할 수 없다(아래 막이 0이면 윗막이 Si 위로 내려앉아 그려짐). 처리 규칙은 다음과 같다.
  - 형상: `T_j,geom = min(T_j + ΔT_j, T_{j+1},geom)`. 아랫막은 바로 윗막보다 안쪽으로 후퇴하지 않게 자른다.
  - 지표: `undercut = max_j(T_j + ΔT_j − T_{j+1},geom)`(> 0이면 overhang 깊이)를 보고하고, "⚠ undercut x µm — 1D 단면 표시 불가" 칩을 띄운다.
- **격자 분해능**: 끝단 세분 격자(§5.4) 0.01 mm보다 작은 계단은 형상에 나타나지 않는다. 지표는 격자 사이를 선형 보간한 T_j로 µm 단위까지 계산한다.

---

## 4. 두께 의존성
- 근거: SST 2005(wet spin, 750 rpm)에서 ILD edge step 0/0.5/1.0 µm 모두 exclusion 0.7 mm로 같았다(450 rpm에서는 step 영향이 커짐). 전이 폭 자체의 두께 의존 정량값은 없다.
- 모델 근거: 지수 감쇠 + 같은 과식각 비율이면 형상이 H에 무관하다(§2.2).
- → **`W_eff = W · (1 + kH · H_µm)`, kH 기본 0 [est]**, 범위 0~0.05 /µm(Mold 7 µm에서 최대 +35 %, 근거 없는 상한 — 민감도 확인용). UI에는 노출하지 않고 상수로만 둔다.

---

## 5. backend-dev용 JS 블록

### 5.1 상수
```js
// ---- 끝단(film edge) 단면 프로파일 (research/analysis/edge-profile.md) ----
// W(mm) = 막 두께 0 %(bare, Edge→dd) → 100 %(dd+W) 거리. F(u) = 잔막 비율, u=(d−dd)/W ∈ [0,1]
const EDGE_SHAPE={
  smooth:u=>u<=0?0:u>=1?1:u*u*(3-2*u),                                  // 확산형(wet), erf 근사
  exp:u=>u<=0?0:u>=1?1:(1-Math.exp(-3*u))/(1-Math.exp(-3)),             // 라디칼 거리 감쇠(plasma), W=3λ
  lin:u=>Math.min(1,Math.max(0,u))};
const EDGE_PROFILE={
 plasmaBevel:{W:.5,shape:'exp',kLat:.3,range:[.05,1],
   src:'Chen & Kim (Lam), US 8,562,750 B2 (2013): 종래 confined plasma bevel clean transition "of the order of 0.5 mm" (마스크·고선택 <0.05~0.1 mm, 비교예 ~1 mm)',
   est:['shape','kLat'],note:'exp 형상 = gap 내 라디칼 확산-재결합 감쇠 가정 · US 8,398,778 apex→R149.8 식각률 1/3.5와 정성 일치'},
 gasEdge:{W:.5,shape:'exp',kLat:.3,range:[.05,1],src:'plasmaBevel 준용',est:['*'],note:'무플라즈마 gas 베벨 처리 단면 데이터 없음'},
 wetEdge:{W:.13,shape:'smooth',kLat:1,range:[.05,.2],
   src:'Novellus, US 9,685,353 B2: wet EBR taper width <200/<100/<50 µm, 실시예 "about 127 µm" (Cu, H2SO4/H2O2 spin)',
   est:['shape','kLat','유전막 일반화'],note:'SST 2005 0.7±0.1~0.3 mm 는 exclusion 위치·산포 — W 아님'},
 bevelOnly:{W:.1,shape:'smooth',kLat:0,range:[.1,.1],src:'현행 엔진 LB±0.05',est:['*'],note:'베벨만 처리 경계 (legacy 값)'}};
// 공정 → 프로파일 키. 'legacy' = 2·rampMm 중심형(⚙ '기타 경계 폭')
const EDGE_PROC={strip:'plasmaBevel',bvs:'plasmaBevel',eew:'wetEdge',bew:'wetEdge',
  cleanWet:'wetEdge',cleanPlasma:'plasmaBevel',cleanGas:'gasEdge',depoEdge:'plasmaBevel',
  edgeClean:'bevelOnly',photo:'legacy',cmpPat:'legacy',etchProt:'legacy'};
const EDGE_DEF={OE:.2,kH:0,pesRates:'uniform',src:'est — 과식각 비율·두께 의존 문헌 없음'};
// 잔막 비율: process 모델(bare 기준) / legacy(중심 기준, 현행 재현)
function edgeRemain(d,dd,prof,Wum,Hum=0){
  if(ENG_EDGE_MODEL==='legacy'||prof==='legacy')return smooth(dd-rampMm,dd+rampMm,d);
  const P=EDGE_PROFILE[prof];if(!P)throw new Error(`알 수 없는 끝단 프로파일: ${prof}`);
  const W=(Wum!=null?Wum/1000:P.W)*(1+EDGE_DEF.kH*Hum);if(!(W>0))throw new Error('끝단 전이 폭은 0보다 커야 합니다');
  return EDGE_SHAPE[P.shape]((d-dd)/W);}
```
- strip/bvs 적용 예(요지): `F=edgeRemain(p.d, d_side, 'plasmaBevel', st.edgeW)` → `need=Σh/r` → `consume(i, F<=0? need*(1+OE) : need*(1-F), rates, opts)`. rates는 `pesRates==='cf4'? CLEAN.cf4.r : 전 막 1, Si:0`이다. Si 손실은 기존 `siLoss*(1−F)*(.5+.5|n.y|)`를 유지한다.
- eew/bew: 최상단 1막 비율 곱을 유지하되 `cut = 1−edgeRemain(p.d, dd, 'wetEdge', st.edgeW)`로 바꾼다(단일 막에서는 비율 곱 = top-down).
- clean edge(dd>0): `wf = p => 1−edgeRemain(p.d, dd, {wet:'wetEdge',plasma:'plasmaBevel',gas:'gasEdge'}[c.cat], st.edgeW)`.
- depoWeight edge rng: `edgeRemain(…,'depoEdge'→plasmaBevel)` [est — 베벨 증착 단면 데이터 없음].
- 측면 차등 후퇴(§3.2)는 strip/bvs/clean-edge 후처리 함수 하나로 분리한다(`lateralStep(rates, kLat)`, 막별 T_j 계산 → 형상 조정 → 지표 반환).

### 5.2 STEP_SCHEMA 선택 필드
```js
// LIM 추가
EDGE_W_UM:[10,1000],   // 끝단 전이 폭 (µm): 하한 = 세분 격자 10 µm, 상한 = US 8,562,750 비교예 ~1 mm
// remove: strip·bvs·eew·bew
fNum('edgeW','끝단 전이 폭 (비우면 공정 기본: Plasma 500 · Wet 130)','µm',LIM.EDGE_W_UM[0],LIM.EDGE_W_UM[1],
  {optional:true,visibleIf:isPesLike}),
// clean: 베벨 폭 지정 시만
fNum('edgeW','끝단 전이 폭 (비우면 구분별 기본)','µm',LIM.EDGE_W_UM[0],LIM.EDGE_W_UM[1],
  {optional:true,visibleIf:st=>st.mode==='edge'&&st.distMm>0}),
// depo/mold: region==='edge' && distMm 지정 시 (선택, 낮은 우선순위)
```
- 미지정(undefined) = 공정 기본(구 레시피 호환: 필드가 없어도 검증을 통과해야 함 → `optional:true`).
- STEP_POST.clean에서 `mode!=='edge'||!distMm`이면 `delete st.edgeW`(숨은 값 저장 금지 — 기존 distMm 처리와 같은 방식).

### 5.3 ⚙ 전역과 하위호환 (권장안)
| 항목 | 권장 |
|---|---|
| 새 설정 `edgeModel` | `'process'`(기본) / `'legacy'`. `data-set="engine"` → geoDirty |
| `legacy` | 현행 그대로 재현: 모든 경계 `smooth(dd±rampMm)`, strip/bvs 비율 곱. 회귀 테스트·비교용 |
| `process` | EDGE_PROFILE 적용 + strip/bvs top-down + 세분 격자. photo·cmpPat·etchProt는 여전히 rampMm |
| `rampUm`(⚙) | 유지. 라벨을 "기타 경계 폭 (Photo·CMP 패턴·Etch 보호, legacy 컷)"으로 바꾼다 |
| 구 레시피·저장 설정 | 설정 키가 없으면 `'process'`. 첫 실행 시 정보 칩 1회: "끝단 프로파일 모델 변경 — Plasma 0.5 mm / Wet 0.13 mm 전이 · ⚙에서 legacy 비교 가능" |

- 판단: 결과 변화 최소화(legacy 기본)보다 **현실성(process 기본)**을 택한다. 사용자가 현행 단면을 명시적으로 문제 삼았고, 현행 컷은 격자 1칸이라 물리적 의미가 없다.
- 변화가 생기는 지표: Edge 평균 두께 `e`(d<2 mm 창)는 PES 2.5 mm에서 거의 불변이다(전이 구간 2.5~3.0 mm는 창 밖). EE 노출 판정 `exD`는 bare 기준점이므로 불변이다. BVS 0.5 mm는 전이 0.5~1.0 mm가 `e` 창 안이라 증가한다. 베벨 증착(BVO) 끝단도 바뀐다. qa는 기본 레시피(L1168, L2490)를 legacy/process로 돌려 차이를 기록할 것.

### 5.4 격자 (필수 동반 변경)
- `buildProfile`의 간격 `x<148?.04:.01`을 `d ≤ D_FINE`에서 0.01로 바꾼다. 권장 `D_FINE = LIM.DIST_MM + 1 = 11 mm`(R ≥ 139). 점이 약 +675개(R<148 구간 ~3,700점 대비 약 +18 %)다.
- 대안(비용 우선): 사용 중인 dd 주변 ±(W+0.1) mm만 세분하는 방식. 그러면 격자가 레시피에 의존하게 되어 geo 캐시가 무효화되므로 비권장.

### 5.5 결과 지표 (remove strip/bvs/eew/bew, clean edge)
| 키 | 정의 | 표시 |
|---|---|---|
| `edgeW10_90` (µm) | 전면(f>.9) 막 총두께가 스택 기준 두께(d=dd+W+0.2의 LV)의 10 %→90 %가 되는 반경 거리 | "끝단 전이 x µm" |
| `edgeSlopeDeg` | atan(0.8·H / edgeW10_90) — 실제 평균 경사 | 표시 과장과 무관한 실제 각도 |
| `stepMax` (µm) | 인접 막 끝단 T_j 간 반경 거리 최대값(계단 최대 단 폭). 수직 단차는 해당 막 두께 | "계단 최대 x µm" |
| `undercut` (µm) | §3.2 overhang 최대 깊이. > 0이면 lvl 1 경고 | "⚠ undercut x µm (1D 표시 불가)" |

---

## 6. 표시와의 관계 (frontend 메모)
- frontend가 과장 모드 표시를 Si 법선 기준 적층으로 바꾸는 중이다. 엔진이 top-down으로 바뀌면 층 계면이 수평을 유지하다 경사면에서 끝나므로 법선 적층 표시와 잘 맞는다(현행 부채꼴 수렴이 사라짐).
- 과장 배율 zScale에서 보이는 각도는 `atan(zScale·H/W)`다. 예: H 7.2 µm, W 0.5 mm, zScale 100 → 55°. 여전히 가파르게 보일 수 있으므로, 칩에 **실제 각도 `edgeSlopeDeg`**(예 ≈ 1~3°)를 함께 표시할 것을 권장한다.
- 엔진 결과(W·T_j)는 화면 설정에 불변이어야 한다(L633 원칙 유지). EDGE_PROFILE은 엔진 전용이다.

---

## 7. 신뢰도·공백·추가 검색어

| 값 | 신뢰도 | 이유 |
|---|---|---|
| Plasma W 0.5 mm | 중-하 | 특허 1건 "of the order of", AI 요약 발췌, 도면 미대조 |
| Wet W 0.13 mm | 중-하 | Cu EBR 실시예 1건("estimated") → 유전막 일반화 est |
| exp/smooth 형상 | 하(est) | 물리 논거만, 단면 측정 프로파일 없음 |
| 계단 수직 성분(top-down) | 중 | 식각 메커니즘상 당연, 정량 검증 없음 |
| 측면 차등 κ_lat, OE | 하(est) | 문헌 없음 |
| kH = 0 | 하 | SST 2005 정성(step 0~1 µm에서 exclusion 불변)만 |

공백: plasma bevel taper angle(°)·10–90 % 폭 실측, HF/SC1 spin etch 전이 폭, ON 스택 베벨 stair-step·undercut 정량, 막 두께 의존성, photo EBR resist 단면, bevel deposition(BVO) 끝단 프로파일, 장비사(Lam Coronus, AMAT, TEL, SCREEN, SEMES, ACM) app note 수치.

researcher 추가 검색어:
1. `"bevel etch" "transition region" film thickness profile SEM 3D NAND` / `Coronus bevel etch edge profile oxide nitride stack`
2. `"edge bevel removal" taper width HF dielectric spin etch "µm"` / `SEZ spin etch edge exclusion profile transition width`
3. `"ONON" OR "oxide nitride stack" wafer edge bevel "staircase" OR "stepped" profile wet etch recess`
4. `US 8562750 FIG. 7 thickness profile` (도면 원문 PDF 대조 — 0.5 mm 정의 확인)
5. `plasma exclusion zone ring bevel etch rate radial profile "mm" TEOS` (US 8,398,778 계열 식각률 반경 분포 추가 점)
6. `edge bead removal resist sidewall profile width EBR solvent "µm"`
7. `bevel deposition edge film thickness roll-off PECVD "wrap" profile`
8. `confined plasma narrow gap radical density decay length bevel` (λ 물리 근거)
