# CMP 모델 파라미터 분석 — Wafer Edge 1D 단면 시뮬레이터용

- 작성: analyst, 2026-10-08
- 입력: `research/sources/cmp.md`, 원문 `research/_tmp/cmp/*.txt`. 핵심 수치는 원문 텍스트와 대조했다(SPIE97, Lee 2001, SemiconWest 2001, Nitta).
- 엔진 확인: `webc_simulator_v3.html`은 읽기만 했다. 확인한 내용은 다음과 같다.
  - `MATERIALS` 키 12종
  - `CLN_DB` 형식
  - `cmp()`: 기준 영역은 `p.d` 4.5~5.5 mm(R145, `f>.99`)이고, 그 평균 LV에서 `amt`를 뺀 평면으로 절단한다. ERO는 깊이(µm)를 고정으로 더한다. pad 접촉 가중은 `smooth(.3,.8,p.f)`이며 `f<.3`인 베벨은 접촉하지 않는다.
  - `consume(i,bud,rates,opts)` 커널이 이미 있다. 패턴 영역(`isPat`)의 target 막은 `open` 비율만큼만 깎는다.
  - `PHOTO.zones`: `{a,b,k}`, k는 bare/barrier/pattern/broken, `p.d` 기준 mm.
  - 체크포인트 `snapState()`가 복사하는 상태는 rec, SX, SY, LV, PHOTO, layers다.
- 표기: **[실측]** 원문 수치 그대로 또는 단위 환산만 한 값. **[환산]** 원문 비율로 계산한 값. **[est]** 추정값.

---

## 0. 요약

| 항목 | 채택값 | 근거 | 신뢰도 |
|---|---|---|---|
| Oxide(silica) SiO2/MTTEOS RR | 225 nm/min | Ouma 1997 Process E 중심 die K = 225.5 nm/min (6 psi, 35 rpm) [실측] | 상(단일 조건) |
| Oxide slurry Poly RR | 334 nm/min | Samsung US7196010 SS25 무첨가 poly/oxide = 3972/2677 = 1.48 × 225 [환산] | 중 |
| Oxide slurry SiN RR | 56 nm/min | oxide:nitride ≈ 4 (silica 슬러리, 출처 미확보) [est] | 하 |
| W 고선택(H2O2/Fe·iodate계) | W 400, TEOS 40 nm/min | AMAT US6468136 "W RR ≥ 3000(청구항 4000) Å/min" [실측 하한], W:TEOS ≈ 10 [검색 발췌] | W 중, TEOS 하 |
| W 저선택(buff, PIA) | W 186, TEOS 172 nm/min | Air Products US8790521 예 10 [실측] | 상(단일 조건) |
| STI ceria | Oxide 487, SiN 12 nm/min (41:1) | US7091164 Table 1, 1% L-proline [실측] | 상(단일 조건) |
| Oxide, poly 정지 | PETEOS 125, Poly 21 nm/min | US7196010 1 wt% PVME 3번째 실시예 [실측] | 중 |
| Poly 선택 slurry | Poly 150, SiO2 3 nm/min | US7723234 청구 범위 (검색 발췌) [est] | 하 |
| Cu | Cu 600 nm/min | AMD US6332989, 2 psi / 150 rpm [실측] | 중 |
| 평탄화 길이 Lp | 기본 3 mm (범위 0.5~15) | Ouma Table 2·3: 2.66~3.30 mm (정사각 창 회귀) [실측]. stiff pad 7~10 mm, IC1000 solo 8.5 mm (SemiconWest 2001) [실측] | 상 |
| 접촉 높이 hc (지수 감소 τ = hc/K) | 0.1 µm | Lee 2001 hc = 1000 Å. 고정연마재 STI 조건 [실측, 조건 다름] | 중-하 |
| **패턴 밀도 모델** | up-area 속도 K/ρ_eff, ρ_eff = ρ(d)를 Lp 폭 정사각 창으로 평균 | Ouma/Stine 식 (3)(4), Lee 식 (4)(5) | 모델 상, 1D 적용 중 |
| Edge 영향 폭 eroW | 4 mm (stacked pad), 10 mm (solo pad) | Ebara Fukuda 2006 abstract | 중 |
| Edge 속도 변화 eroPct | +10 % (edge-fast), 범위 −80~+100 | Ouma edge die K/center = 1.02~1.14 [환산]. Ebara 23~30 %(방향 해석 주의) | 하-중 |
| 과연마 op | 20 % (범위 0~100) | Nitta 15/35 %, Air Products 15/30/60 % | 중 |
| W recess (지표) | H2O2+촉매: 80 nm(barrier clear 시점). iodic: 약 10 nm (OP 무관) | Nitta 2014, 1 µm plug 20 % array | 중(조건부) |

**제외한 자료**
- Rodel/Rayle 2002 CMPUG 슬라이드: 원문 7·20·36행에 "CONFIDENTIAL – RODEL, INC." 표기가 있다. 공개 사이트에 올라와 있지만 값을 쓰지 않았다(TEOS:Cu 1.3~1.4, ILD loss 100~300 Å, slurry 1~6 RR 전부).
- `_tmp/cmp/cuoverview.pdf.txt`: MIT 그룹 홈페이지 본문이며 수치가 없다.

---

## 1. SLURRY_DB 제안

### 1.1 막질 대응 규칙
| 원문 막질 | 시뮬레이터 키 | 이유 |
|---|---|---|
| PECVD TEOS (Ouma: 금속 배선 위 2000 nm TEOS, ≤400 ℃ BEOL), PETEOS, Air Products "TEOS" 블랭킷 | SiO2, MTTEOS | 비어닐 PECVD oxide. CLN_DB 규칙과 같다. |
| HDP-CVD oxide (STI fill, Lee 2001), 어닐 TEOS, 열산화막 | HTTEOS | 치밀한 막. CMP 속도의 공개 비교값이 없어 SiO2의 0.9배로 둔다 [est]. 같은 특허에서 BPSG 어닐/비어닐 = 5374/8786 = 0.61이지만, 도핑 유리라 그대로 쓰지 않았다. |
| LPCVD poly (unannealed) | Poly | annealed poly는 note에만 적는다(US7196010: 21 → 48 nm/min). |
| bare Si | Si | 문헌 없음. Poly와 같은 값을 쓴다 [est]. |
| SiON | SiON | 문헌 없음. SiO2와 SiN의 산술평균 [est]. |
| W (CVD) | W | |
| Ti/TiN, Ta/TaN barrier | **키 없음** | 공백. W:TiN 1:1.5~2와 W:Ti 10:1이 서로 충돌한다(둘 다 검색 발췌). |
| PR, SOH, ESOH, HTACL, MTACL | **er 미기재** | CMP 공개값이 없다. 엔진에서는 "데이터 없음 → 정지"로 처리한다. 경고 표시가 필요하다. |

### 1.2 단위 환산
- nm/min = Å/min ÷ 10
- 엔진 상대율 `r[m] = er[m] / er[tgt]` (CLEAN과 같음). 시간 환산 `rate(nm/s) = er[tgt] / 60`
- 시간 → 제거량: `amt(µm) = time(s) × er[tgt] / 60 / 1000`
- 압력: psi × 6.895 = kPa
- Preston 스케일(조건 변경 시): `RR' = RR × (P'/P) × (V'/V)`
  - 검증(Ouma Table 1·2 중심 die K): K/(P·rpm) = A 0.995, B 0.976, C 1.027, D 1.258, E 1.074 (nm/min)/(psi·rpm)
  - 5개 조건에서 ±15 % 이내로 선형이다. Preston 선형 스케일을 써도 된다(신뢰도 중).

### 1.3 Sanity check
| 확인 항목 | 결과 |
|---|---|
| Ceria STI: oxide ≫ nitride | 487/12 = 41 ✓ |
| W 고선택: W ≫ oxide | 10 ✓. 다만 TEOS 값은 검색 발췌라 하 |
| W 저선택: W ≈ oxide | 1.08 ✓ |
| Silica oxide: oxide > nitride | 4 [est] ✓. 무첨가 ceria 7.4와 titania 1.6 사이라 범위가 그럴듯하다 |
| Silica oxide slurry: poly > oxide (1.48) | 의도한 결과다. oxide slurry로는 poly에서 정지하지 않는다. 정지가 필요하면 `ox_ps`를 쓴다 |
| Preston (P·V 5배 → K 4.9배, Ouma A→B) | ✓ |

---

## 2. 패턴 밀도 의존 CMP (핵심, 사용자 최우선 현상)

### 2.1 현상과 원문 모델
- 현상: pattern(hole) 영역은 up-area 접촉 면적이 작아 국부 압력이 높고 빨리 깎인다. 떡판(blanket, ρ=1)은 늦게 깎인다. 그래서 경계에서 단차가 남는다. Edge의 Ring barrier, PSES 떡판, partial shot, EE 경계에서 생긴다.
- 원문 모델 [실측 식]
  - Ouma/Stine 1997, 식 (3)(4):
    - up-area: z = z0 − K t / ρ0 (K t/ρ0 < z1일 때)
    - 이후: z = z0 − z1 − K t + ρ0 z1
    - K는 블랭킷 속도, ρ0는 유효 밀도, z1은 초기 단차
    - 원문: "Local pressure is inversely proportional to the pattern density"
- 밀도 창(원문 384~392, 520~536행)
  - 원래 구현은 "square window centered at the point of interest"이고, 밀도 = raised area / window area다.
  - 원문은 Gaussian 가중 창도 제시한다.
  - **Table 2·3의 PL(2.66~3.30 mm)은 regression method(정사각 창)로 뽑은 값이다** (원문 "the first method is used").
  - 따라서 1D 커널 기본값은 **폭 Lp의 평탄 창 [d−Lp/2, d+Lp/2]**로 한다. Gaussian은 옵션이고, 이때 σ ≈ Lp/√12 ≈ 0.29·Lp로 두면 정사각 창과 2차 모멘트가 같아진다.
- 1D 근사의 정당성: R = 145 mm에서 Lp = 3 mm 창 안의 원호 곡률은 무시할 수 있다(편차 약 Lp²/8R ≈ 8 µm). 동심 링 형태의 zone 경계는 직선 경계로 볼 수 있으므로, 2D 정사각 창 밀도가 1D 창 평균과 같다.
- 단차 소멸 이후 (Lee 2001, 식 4·5) [실측 식]
  - 단차 H ≤ hc가 되면 RRup = (K1−K2)H/hc + K2, RRdown = K2(1−H/hc), K1 = K/ρ, K2 = K
  - H가 exp(−t/τ), τ = hc/K로 줄어든다.
  - 0 < H 동안 down 영역은 Phase 1에서 RRdown = 0이다.
  - SemiconWest 2001: 단차가 크면 밀도 효과가 우세해 시간에 선형으로, 작으면 up/down 압력차로 지수적으로 줄어든다.

### 2.2 엔진 상태 추가 (체크포인트 대상)
| 배열 | 의미 | 초기값 | 갱신 |
|---|---|---|---|
| `DENS[i]` | up-area 면적비 ρ (1 = blanket) | 1 | etch(자동), CMP(소멸 시 1로 복귀) |
| `STEP[i]` | up/down 단차 H (µm) | 0 | etch +, 평탄화 증착 ×(1−plan), CMP − |

- `snapState`/`loadState`/`resetState`에 rec, LV와 같은 방식으로 복사·복원을 추가해야 한다. 이것이 체크포인트 결정성의 필수 조건이다.
- 1D 막 두께는 지금처럼 **면적 평균**으로 둔다. 현재 `consume`도 패턴 영역 target을 open 비율만큼만 깎아 면적 평균을 만든다.
  - up-area 표면 높이는 `zUp = LV + (1−ρ)·H`
  - 면적 평균 높이는 `LV`

### 2.3 밀도 맵 입력원 (우선순위: b → a → c)
| 모드 `patSrc` | 산출 방식 |
|---|---|
| (a) `auto` | 직전 Photo의 `PHOTO.zones`에서 pattern/broken은 패턴, barrier/bare는 blanket으로 본다. 이후 Etch(target 막이 있는 단계)가 `isPat` 점에서 실행되면 다음과 같이 갱신한다. ① `DENS[i] = min(DENS[i], 1 − open/100)` ② `STEP[i] += 실제 hole 깊이 = (면적평균 손실)/open` (consume의 pz 분기에서 `Math.min(h,bud*open*r)/open`). 증착에서는 `plan>0`이면 `STEP *= (1−plan)`, conformal(`plan=0`)이면 STEP을 유지한다 [est]. hole 폭을 1D에서 알 수 없어 fill 여부를 판단할 수 없기 때문이다. 이 경우 수동 `patStep`으로 덮어쓴다. |
| (b) `manual` | CMP 단계에서 직접 지정한다. `patFrom`(mm, 패턴 영역 시작 Edge→), `patTo`(mm, 기본 99 = 내측 끝), `patDens`(%, up-area 밀도), `patStep`(µm, 초기 단차). 이 단계에서만 DENS/STEP을 덮어쓴다. 경계는 기존 `rampMm`로 smooth 처리한다. |
| (c) `off` (기본값) | 자동 상태 배열에 패턴 정보가 없으면 ρ=1, H=0인 블랭킷 CMP다. `auto`인데 DENS가 전부 1이면 "패턴 밀도 정보 없음 — 수동 지정 필요" 안내를 띄운다. |

수동 기본값은 `patDens 50 %`, `patStep 0.5 µm`이다 [est]. Ouma Mask III 밀도 범위 4~100 %의 중간값이며, 사용자 회사 값이 아니라 데모용이다. 실제 밀도와 단차는 사용자가 입력한다.

### 2.4 계산 (서브스텝 결정적 적분)
블랭킷 환산 budget을 `dz`씩 고정 분할한다. 매 서브스텝마다 각 접촉점 i에 대해 다음을 계산한다.
```
ρeff_i = Σ_j∈창 ρ_j·ds_j / Σ_j∈창 ds_j        (창 = |d_j−d_i| ≤ Lp/2, 접촉점 f≥.3만 — 웨이퍼 밖·베벨은 창에서 제외 [est])
ρeff_i = max(ρeff_i, RHO_MIN=0.05)             (Ouma 검증 밀도 하한 4 % 근처 [est])
base_i = dz · E(d_i) · wc_i                    (E = edge 프로파일 §3, wc = smooth(.3,.8,f))
if H_i > hc:      up = base_i/ρeff_i ;  dn = 0                                     (Phase 1, Ouma/Stine)
elif H_i > 0:     up = base_i·((1/ρeff_i−1)·H_i/hc + 1) ;  dn = base_i·(1−H_i/hc)   (Phase 2, Lee)
else:             up = dn = base_i                                                 (블랭킷)
avg_i = ρ_i·up + (1−ρ_i)·dn          → consume(i, avg_i, S.r, opts)               (면적 평균 막 소비)
H_i   = max(0, H_i − (up − dn)·r_top)  (r_top = 현 최상단 막 상대율 — 선택비 반영 [est])
H_i = 0 이 되면 DENS_i = 1 (평탄화 완료)
```
- 질량 보존 확인: 밀도가 균일한 넓은 영역(ρeff = ρ)의 Phase 1에서는 avg = ρ·base/ρ = base다. 면적 평균 제거율이 블랭킷과 같으므로 Stine 모델(압력 총량 보존)과 맞는다.
- 경계 효과
  - 패턴 쪽(ρ < ρeff): 면적 평균 손실이 블랭킷보다 작다.
  - 블랭킷 쪽(ρ = 1 > ρeff): K/ρeff로 더 깎인다. 떡판 가장자리가 침식된다.
  - 그 결과 경계에서 Lp 폭으로 퍼진 단차가 생긴다.
- `dz = 0.02 µm` (= hc/5)로 고정한다. 서브스텝 수는 `ceil(budget/dz)`이고 상한은 `LIM.CMP_UM/dz = 1000`이다.
  - 창 평균은 prefix-sum으로 O(NP)에 계산한다.
  - 서브스텝 중에는 recalc()를 하지 않는다. LV만 증분 갱신하고 마지막에 recalc() 한 번이면 된다.
  - 난수는 없다. 같은 입력이면 같은 결과다.

### 2.5 해석해 기준 검증 (qa-tester 오라클)
넓은 패턴(폭 ≫ Lp), ρ = 0.5, H = 0.5 µm, blanket과 같은 막, hc → 0에서 다음 값이 나와야 한다.

| 블랭킷 환산 제거 A | 패턴 up-surface 하강 | 블랭킷 하강 | top 단차(패턴이 낮음) | 면적평균 LV 단차 |
|---|---|---|---|---|
| 0.1 µm | 0.2 | 0.1 | 0.10 µm = A(1/ρ−1) | (1−ρ)H = 0.25 µm 불변 |
| 0.25 µm (= ρH, Phase 1 종료) | 0.5 | 0.25 | 0.25 µm | 0.25 |
| 0.5 µm | 0.75 | 0.5 | 0.25 µm 유지 | 0.25 |

- top 단차의 최종값은 `(1−ρ)·H`이고, 이후 블랭킷 속도로 함께 내려간다. Ouma 식 (4)의 `−z1 + ρ0 z1` 항과 같다.
- 경계 전이폭(단차의 10~90 %)은 대략 Lp(정사각 창)이다.

### 2.6 결과 지표 (Impact 패널)
| 지표 | 정의 |
|---|---|
| `패턴↔떡판 단차` (nm, 부호) | 경계 위치 d_b(ρ가 0.5·(1+ρp)를 지나는 점)에서 양쪽으로 Lp 떨어진 점의 `zUp` 차이. 경계 위치(mm)도 표시한다. +이면 떡판이 높다. |
| `면적평균 단차` (nm) | 같은 두 점의 LV 차이 |
| `전이폭` (mm) | zUp 단차의 10~90 % 구간 |
| `잔여 패턴 단차` (nm) | 패턴 내부 H의 최댓값. 0보다 크면 "평탄화 미완(Phase 1/2)" |
| 경고 | 떡판 쪽이 높고 \|단차\| > 50 nm [est 임계]이면 "Edge 떡판 단차 — 접합/후속 Photo 영향" |

### 2.7 한계 [est]
- feature 크기·모양을 모른다(1D). hole 폭이 Lp의 15 %보다 크면 Ouma 모델이 맞지 않는다(원문: 500 µm까지 유효).
- conformal 증착의 hole fill 여부, dishing 내부 형상, corner rounding은 표현하지 않는다.
- up/down의 막 구성이 다를 때의 선택비는 최상단 막 1개로 근사한다.
- 순수 역밀도(K/ρ)는 저밀도에서 과대예측한다. Lee 2001은 K/ρ의 RMS error 1800 Å/min을 수정식 860 Å/min으로 줄였고, SemiconWest 2001은 "Over-predicts down polish at low density"라고 적었다. 그래서 `RHO_MIN`으로 제한했다.

---

## 3. 그 밖의 모델 파라미터

### 3.1 평탄화 길이 Lp
- 기본 3 mm (stacked/soft pad)
- 범위 0.5~15 mm
- 프리셋 힌트: soft 3~4, stiff 7~10, IC1000 solo 8.5 mm (SemiconWest 2001, 원문 확인)
- Ouma Table 2: 하중이 클수록 PL이 짧다(A/C 4 psi 3.08/3.30 → B/D 8 psi 2.73/2.75). Table 3은 반대 경향이다. **원문 스스로 "contradiction"이라고 적었다.** 하중 의존성은 모델에 넣지 않는다.
- 범위 0.5 mm 하한의 근거: Cu 상호작용 거리 50~100 µm는 검색 발췌라 채택하지 않았다.

### 3.2 해상된 지형(mm 규모 단차: EEW로 생긴 edge 단차, PR barrier 등)
- 밀도 모델은 sub-resolution feature용이다. 1D에서 해상되는 mm 규모 지형은 접촉 계수 `g_i`를 곱해서 처리한다 [est, 옵션 `topo`].
```
m_i  = Lp 창 평균 SY          (긴 파장 성분 = pad가 따라감)
res_i = SY_i − m_i ;  U_i = Lp 창 max(res)
g_i  = clamp(1 − (U_i − res_i)/hc, 0, 1) ;  g_i /= Lp 창 평균(g)  ;  g_i ≤ F_MAX=5
```
- 평탄면이면 g=1이다. hc보다 깊은 오목부는 g=0으로 pad가 닿지 않는다. 돌출부는 하중이 모인다.
- 1차 구현에서는 생략해도 된다. 생략하면 `g=1`이다.

### 3.3 Edge roll-off E(d)
`E(d) = 1 + eroPct/100 · (1 − smooth(0, eroW, d))`
- Preston에 따라 제거량은 압력에 비례한다. 그래서 기존의 고정 깊이 `ero`(µm)를 비율 `eroPct`로 바꾼다.
- 기본값: eroW = 4 mm, eroPct = +10 %
  - 폭: Ebara stacked pad 4 mm, solo pad 10 mm
  - 크기: Ouma edge die K/center die K = A 1.053, B 1.143, C 1.024, D 1.099, E 1.112 [환산]. 원문은 "high down force … edge polishes faster than the center"이고 die 단위 값이라 mm 분해능은 없다.
- 범위: −80 ~ +100 %
- 하한 근거(Ebara): ROA 1.27 µm에서 edge 표면압 "약 30 %(stacked)/23 %(solo)". abstract만 봐서 **'중심 대비 비율'인지 '감소율'인지 불명확하다**. 비율로 해석하면 −70~−77 %이고, 그래서 하한을 −80으로 잡았다. 원문 대조가 필요하다.
- Xie/Boning: edge 수 mm 구간이 ring 압력, gap, pad 탄성률에 따라 fast도 slow도 될 수 있다. 부호를 사용자가 고르게 하는 근거다.

### 3.4 정지막 모드와 과연마
- `mode:'stop'`이면 서브스텝을 반복하다가 기준 영역(d 4.5~5.5, f > .99)의 **모든 점에서** stopMat 위의 막 합이 1 nm 이하가 되는 시점을 endpoint로 본다.
- 이후 `op% × endpoint까지 쓴 budget`만큼 계속 연마한다.
- 기준 영역이 패턴↔떡판 전이폭(Lp) 안에 들어가면 endpoint가 치우친다. 이 경우 안내를 띄운다.
- 실패 경로
  - 기준 영역에 stopMat이 없으면 입력 오류
  - LIM.CMP_UM 안에 endpoint에 도달하지 못하면 경고 후 중단
  - 데이터 없음 막에서 정지하면 noData 표시
- 정지막 손실: consume의 선택비가 그대로 결정한다. 예를 들어 STI ceria에서 op 20 %, 0.5 µm 산화막이면 SiN 손실은 0.1 × 12/487 ≈ 2.5 nm다.
- 패턴 영역의 추가 erosion은 §2 모델이 처리한다. 정지막이 노출되면 W나 trench oxide가 오목해지고, down-area가 생기며 ρ가 바뀐다. 이 과정은 1D에서 직접 표현할 수 없다.
  - 대신 수동 `stopDens`(%)를 쓴다 [est]. 과연마 구간에서만 패턴 영역의 ρ를 stopDens/100으로 두어 K/ρ로 정지막을 침식한다.
  - 예: W plug 20 % array면 stopDens 80 %이고 oxide erosion은 1.25배 빨라진다.
  - Air Products 예 13의 erosion(47/57/75, OP 15/30/60 %)은 **단위·조건이 불명이라 채택하지 않았다.** 경향(OP 증가에 따라 증가)만 확인했다.
- Dishing: 1D로 표현할 수 없고 공개 정량값도 없다. 공백이다. 참고로 AMD Cu 10 µm line 400 Å이 있지만 OP 조건이 없다.

### 3.5 W recess (지표만, 형상 반영 안 함)
Nitta 2014(EBARA EPO222, 4 psi, pH 2, silica 2.5 wt %, 1 µm plug 20 % array) [실측 텍스트]

| 슬러리 | W clear 시점 | barrier clear 시점 | over-polish |
|---|---|---|---|
| H2O2 + 촉매(+inhibitor) | iodic보다 100 nm 더 깊다 | **80 nm** | 감소 경향(그래프만 있음) |
| iodic A | 약 60 nm [환산: 10 + 50] | **약 10 nm** | 일정 |

"Nitta 80~100 nm"는 80 nm가 잔류값이고 100 nm는 두 슬러리의 **차이**다. SLURRY_DB `recessNm`에는 barrier clear 기준값을 넣고, 엔진에서는 패턴 영역 지표로만 표시한다.

---

## 4. Edge 특화 현상과 모델링

| 현상 | 모델 | 정량 근거 | 신뢰도 |
|---|---|---|---|
| Oxide edge-fast | eroPct > 0, eroW 4 | Ouma edge die +2~14 % | 중 |
| Edge-slow (roll-off, ring 압력 과다) | eroPct < 0 | Ebara 23~30 %(해석 주의), Xin: "ring 압력은 표면압보다 약간 높게" | 하 |
| Retaining ring | eroPct 부호·크기로 흡수 | Ebara: ring 압력 23 → 30 kPa로 stacked pad edge 효과 상쇄. 링 마모 시 edge RR 약 +6 %(검색 발췌). 2-zone(fast 약 4 mm, slow 3~20 mm, Lam 검색 발췌)은 공백 | 하 |
| 베벨/apex 미연마 → W 잔막 | `wc = smooth(.3,.8,f)` 유지. f < .3이면 CMP 0. CMP 후 `f<.8` 점에 W > 1 nm면 경고 "베벨 W 잔막 → peeling/오염 (US6121111)". 기존 BEVEL·APEX 잔류 표시와 arcRisk(W 노출)를 연동한다. | TSMC/AMAT 특허: 정성만 있음. AMAT: ring > 85 durometer, pad < 60 durometer이면 edge 잔막 감소. 폭은 공백 | 정성 |
| Edge 미제거 잔막 링 (edge-slow + stop 모드) | stop 모드 종료 후 d < eroW의 접촉점(f ≥ .8)에 stopMat 위 막이 1 nm를 넘으면 "Edge 잔막 링" 경고 | 모델 결과로 나오는 현상 | 중 |
| 패턴↔떡판 단차 (§2) | 밀도 모델 | Ouma/Stine | 모델 상 / 1D 중 |
| 정지막 과손실 at edge | E(d) × 선택비로 자동 반영 | — | 중 |

---

## 5. 출처 충돌과 신뢰도
| 항목 | 내용 | 판정 |
|---|---|---|
| Ouma Fig.6 라벨 vs 본문 | 라벨: edge range 4422 Å, center 3988 Å (edge가 10.9 % 큼). 본문: "center die … 10 % larger" | 라벨 순서가 뒤바뀐 것으로 보인다. 정량 채택하지 않았다. |
| Ouma PL vs 하중 | Table 2(하중↑ → PL↓)와 Table 3(하중↑ → PL↑)이 반대다. 원문이 직접 인정했다. | 하중 의존성 미반영. 범위 2.66~3.30만 채택 |
| W:Ti 10:1 vs W:TiN 1:1.5~2 | 특허 번호 미확인, 둘 다 검색 발췌 | 채택 안 함(barrier 키도 없음) |
| W:oxide | 고선택 약 10(발췌) vs "50~150이면 recess 과다"(발췌) | 10 채택(하). 50~150 고선택 슬러리 예는 note에만 기록 |
| Ebara 23/30 % 해석 | 비율인지 감소율인지 불명 | 범위 하한에만 반영 |
| Lee hc = 1000 Å | 고정연마재 ceria STI 조건 | 기본 hc로 쓰되 신뢰도 중-하 |

---

## 6. 남은 공백과 researcher 추가 검색어
1. Ebara 2006 본문: 23/30 %의 정의, edge 0~10 mm 압력 프로파일 수치.
   - 검색어: `Fukuda Hiyama "edge roll-off" CMP JSME 2006 pressure distribution full text`
2. Oxide CMP edge 두께 프로파일(nm, 0~5 mm).
   - 검색어: `"edge exclusion" oxide CMP thickness profile 2 mm retaining ring pressure nm`, `Xie Boning "wafer edge" CMP thesis MIT`
3. Silica oxide slurry의 SiN 동일 조건 RR. 현재 est 4:1.
   - 검색어: `fumed silica slurry PETEOS nitride removal rate selectivity Å/min SS-25 silicon nitride`
4. W 고선택 슬러리의 W/TEOS/TiN을 같은 조건에서 잰 peer-review 표.
   - 검색어: `tungsten CMP ferric nitrate H2O2 W TEOS TiN removal rate table selectivity JES`
5. 패턴 밀도·단차 감소 시간 곡선(일반 slurry, 일반 pad): hc, τ.
   - 검색어: `Grillaert CMP-MIC 1998 step height reduction`, `Smith Boning CMP-MIC 1999 integrated density step height contact height`
6. CMP 후 edge 쪽 떡판↔cell 경계 단차 공개 사례(3D NAND/DRAM periphery-cell step).
   - 검색어: `cell periphery step height CMP pattern density dummy fill edge die`
7. 베벨 W 잔막 폭/두께: `tungsten residue wafer edge bevel CMP mm thickness peeling`
8. Carbon(ACL/SOH)·PR의 CMP RR: `amorphous carbon CMP stop layer removal rate silica slurry`
9. Barrier(TiN, Ta/TaN) 키 추가 여부를 결정해야 한다(backend 판단).

---

## 7. 변경 전/후
| 항목 | 기존 | 제안 | 근거 |
|---|---|---|---|
| 절단 방식 | 기준(R145) 평균 − amt의 이상 평면 | 블랭킷 환산 budget을 서브스텝으로 적분. 밀도·단차·edge 프로파일 반영 | Ouma/Stine, Lee |
| 막 선택비 | 없음(위에서부터 동일 두께) | SLURRY_DB 상대율로 consume | 문헌 RR |
| ERO | 깊이 µm 고정(ero 0.1, eroW 2) | eroPct % × 국부 제거량, eroW 기본 4 | Preston, Ebara |
| 종료 | 제거량만 | amt 또는 stop+op% | Nitta/Air Products OP 관행 |
| 패턴 밀도 | 없음 | DENS/STEP 상태 + auto/manual/off | 사용자 요구, Stine |
| 하위 호환 | — | 구 레시피 `ero`(µm)는 `eroPct = clamp(ero/amt×100, −80, 100)`로 바꾸고, slurry가 없으면 `'oxide'`, mode는 `'amt'`, patSrc는 `'off'`로 둔다. 프리셋 `{amt:1,ero:.05,eroW:1.5}`는 5 %, `{amt:6,ero:.15,eroW:2}`는 2.5 % | — |

---

## 8. backend-dev용 JS 블록

```js
// ---- CMP 슬러리 DB (nm/min, 공개 문헌) — research/analysis/cmp.md ----
// 막질 대응: SiO2·MTTEOS = PECVD TEOS/PETEOS(비어닐), HTTEOS = HDP·어닐 TEOS(SiO2×0.9 est), Poly = LPCVD poly(비어닐),
//   Si = Poly 값(est), SiON = (SiO2+SiN)/2(est). PR·SOH·ESOH·ACL·barrier(TiN/Ta)는 공개값 없음 → er 미기재(데이터 없음 = 정지)
// stop = 기본 정지막, recessNm = W plug recess 지표(barrier clear 시점, 형상 반영 안 함)
const AP521='Air Products, US 8,790,521 B2 (CMP of tungsten-containing substrate)';
const SLURRY_DB={
 oxide:{name:'Oxide (Silica, ILD/PMD)',ab:'SiO2-slurry',tgt:'SiO2',stop:'SiN',cond:'fumed silica (Cabot SS-25), 6 psi, 35 rpm, IC1000/Suba IV · IC1400',
   src:'Ouma, Stine, Boning et al., SPIE Microelectronic Manufacturing 1997 (MIT/TI) — Process E 중심 die K=225.5 nm/min; Poly = US 7,196,010 SS25 무첨가 poly/oxide 1.48 환산',
   er:{SiO2:225,MTTEOS:225,HTTEOS:200,SiN:56,SiON:140,Poly:334,Si:334,W:20},est:['HTTEOS','SiN','SiON','Si','W'],
   note:'Preston K/(P·rpm) ≈ 1.0~1.26 (nm/min)/(psi·rpm) · edge die K +2~14% · SiN 4:1, W(산화제 없음) 값은 추정'},
 ox_ps:{name:'Oxide, Poly stop (Silica + PVME)',ab:'Ox/Poly-stop',tgt:'SiO2',stop:'Poly',cond:'SS25 기반 silica + 1 wt% PVME, 2~5 psi, pH 7~11',
   src:'Y.-R. Park et al. (Samsung), US 7,196,010 — 3번째 실시예 PETEOS 1250, poly 210 Å/min',
   er:{SiO2:125,MTTEOS:125,HTTEOS:113,Poly:21,Si:21},est:['HTTEOS','Si'],
   note:'oxide:poly ≈ 6 · annealed poly 48 nm/min · 표 행(1% PVME): oxide 193 / poly 25'},
 w_hs:{name:'W 고선택 (H2O2/Fe·iodate 산화제)',ab:'W-HS',tgt:'W',stop:'SiO2',recessNm:80,cond:'산성 silica + 산화제, ~4 psi, IC1000',
   src:'AMAT US 6,468,136 (W RR ≥3000, 청구항 ≥4000 Å/min) · W:TEOS ≈ 10 은 특허 검색 발췌(6 psi, 7860/801 Å/min, 번호 미확인)',
   er:{W:400,SiO2:40,MTTEOS:40,HTTEOS:36,SiN:20},est:['SiO2','MTTEOS','HTTEOS','SiN'],
   note:'recess: H2O2+촉매 80nm / iodic 10nm (Nitta 2014, 1µm plug 20% array, barrier clear 시점) · Ti/TiN 키 없음'},
 w_ls:{name:'W 저선택 / Buff (Periodic acid)',ab:'W-LS',tgt:'W',stop:'SiO2',recessNm:10,cond:'colloidal silica 9 wt% + PIA 2 wt%, pH 3.07→1.63, 4.0 psi, 120 rpm, 150 cc/min',
   src:AP521+' — 예 10: W 1861, TEOS 1718 Å/min',
   er:{W:186,SiO2:172,MTTEOS:172,HTTEOS:155},est:['HTTEOS'],
   note:'W:TEOS 0.5~1.3 (PIA 0.5~2 wt%) · recessNm은 iodic계 유사 가정(est)'},
 sti:{name:'STI Ceria (고선택)',ab:'Ceria',tgt:'SiO2',stop:'SiN',cond:'ceria 5 wt% + 1% L-proline, pH 10, 5.6 psi, 30/30 rpm, 25℃, 240 cc/min',
   src:'Srinivasan, Babu et al., US 7,091,164 B2 Table 1',
   er:{SiO2:487,MTTEOS:487,HTTEOS:438,SiN:12},est:['HTTEOS'],
   note:'선택비 41 · 무첨가 489/66(<8) · 4% L-proline 430/2(230) · HDP fill → HTTEOS'},
 poly:{name:'Poly-Si 선택',ab:'Poly-slurry',tgt:'Poly',stop:'SiO2',cond:'poly 선택 slurry (조건 미확인)',
   src:'US 7,723,234 청구 범위(검색 발췌, 원문 미확인): poly ≥100(150~200 바람직) nm/min, poly:SiO2 ≥30(50)',
   er:{Poly:150,Si:150,SiO2:3,MTTEOS:3,HTTEOS:3},est:['*'],note:'원문 대조 전 — 전부 추정'},
 cu:{name:'Cu Bulk (Alumina + Oxalic)',ab:'Cu',tgt:'Cu',stop:'SiO2',cond:'Al2O3 0.2~0.7 wt% + oxalic acid, 2 psi, 150 rpm',
   src:'K. Yang et al. (AMD), US 6,332,989 B1',
   er:{Cu:600},est:[],note:'10µm line dishing ~40nm · oxide RR 미보고(데이터 없음 = 정지) · Rodel 2002 자료는 CONFIDENTIAL 표기로 제외'}};
// 엔진용: 상대율 r (tgt=1), CLEAN과 같은 규칙 (MATERIALS에 없는 키(Cu 추가 전)는 rt()가 버림)
const SLURRY=Object.fromEntries(Object.entries(SLURRY_DB).map(([k,d])=>{const t=d.er[d.tgt]||1;
  return[k,{...d,r:Object.fromEntries(Object.entries(d.er).map(([m,v])=>[m,v/t])),rate:+(t/60).toFixed(4)}];}));
// 주의: CLEAN과 달리 er에 없는 막은 undefined로 두어 consume이 '데이터 없음 → 정지'로 처리하게 할 것 (rt()로 0 채우면 noData 기록이 사라짐)

// ---- CMP 모델 기본값 ----
const CMP_DEF={
  Lp:3,           // mm, 평탄화 길이(정사각 창 폭) — Ouma 1997 2.66~3.30 (stacked), stiff 7~10, IC1000 solo 8.5
  hc:.1,          // µm, 접촉 높이 — Lee 2001 (τ = hc/K)
  dz:.02,         // µm, 서브스텝 블랭킷 budget (결정적)
  RHO_MIN:.05,    // 유효 밀도 하한 (K/ρ 과대예측 방지, est)
  F_MAX:5,        // 해상 지형 하중 집중 상한 (est, topo 옵션)
  eroW:4,eroPct:10,     // Ebara stacked 4mm · Ouma edge die +2~14% (est)
  op:20,stopDens:80,    // 과연마 %, 패턴 영역 정지막 면적비 % (est)
  patDens:50,patStep:.5,// 수동 패턴 기본 (데모용 est — 사용자 입력 권장)
  contact:[.3,.8],      // pad 접촉 가중 smooth(f) — 베벨(f<.3) 미연마
  ref:[4.5,5.5],        // endpoint 기준 영역 Edge→mm (R145)
  STEP_WARN_NM:50,RESID_NM:1};
// LIM 추가
//   CMP_LP_MM:[.5,15], CMP_HC_UM:[.01,1], CMP_ERO_PCT:[-80,100], CMP_OP_PCT:100, CMP_DENS_PCT:[5,100], CMP_STEP_UM:5

// ---- STEP_SCHEMA.remove 에 추가할 CMP 필드 (기존 'ero'는 하위 호환 마이그레이션 후 제거) ----
const isCmp=st=>st.action==='cmp',isStop=st=>isCmp(st)&&st.mode==='stop',isManPat=st=>isCmp(st)&&st.patSrc==='manual';
/*
  fSel('slurry','슬러리',()=>Object.entries(SLURRY_DB).map(([k,s])=>[k,s.name]),{def:'oxide',visibleIf:isCmp,
    onSet:(st,prev)=>{const a=SLURRY_DB[prev],b=SLURRY_DB[st.slurry];if(a&&b&&st.stopMat===a.stop)st.stopMat=b.stop;}}),
  fSel('mode','종료 방식',()=>[['amt','제거량 지정'],['stop','정지막 Endpoint + 과연마']],{def:'amt',visibleIf:isCmp}),
  fNum('amt','CMP 제거량 (target 막 블랭킷 기준)','µm',0,LIM.CMP_UM,{minEx:true,def:1,visibleIf:st=>isCmp(st)&&st.mode!=='stop'}),
  fSel('stopMat','정지막',()=>KEYS.map(k=>[k,MATERIALS[k].name]),{def:st=>SLURRY_DB[st.slurry]?.stop||'SiN',visibleIf:isStop}),
  fNum('op','과연마','%',0,LIM.CMP_OP_PCT,{def:CMP_DEF.op,visibleIf:isStop}),
  fNum('Lp','평탄화 길이 Lp','mm',LIM.CMP_LP_MM[0],LIM.CMP_LP_MM[1],{def:CMP_DEF.Lp,visibleIf:isCmp}),
  fNum('hc','접촉 높이 hc','µm',LIM.CMP_HC_UM[0],LIM.CMP_HC_UM[1],{def:CMP_DEF.hc,visibleIf:isCmp}),
  fNum('eroPct','Edge 속도 변화 (+fast / −slow)','%',LIM.CMP_ERO_PCT[0],LIM.CMP_ERO_PCT[1],{def:CMP_DEF.eroPct,visibleIf:isCmp}),
  fNum('eroW','Edge 영향 폭','mm',0,LIM.ERO_W_MM,{minEx:true,def:CMP_DEF.eroW,visibleIf:isCmp}),
  fSel('patSrc','패턴 밀도',()=>[['off','없음 (블랭킷)'],['auto','자동 (Photo zone + Etch open)'],['manual','수동 지정']],{def:'off',visibleIf:isCmp}),
  fNum('patFrom','패턴 영역 시작 Edge→','mm',0,LIM.DFULL_MM[1],{def:5,visibleIf:isManPat}),
  fNum('patDens','패턴 up-area 밀도','%',LIM.CMP_DENS_PCT[0],LIM.CMP_DENS_PCT[1],{def:CMP_DEF.patDens,visibleIf:isManPat}),
  fNum('patStep','패턴 초기 단차','µm',0,LIM.CMP_STEP_UM,{def:CMP_DEF.patStep,visibleIf:isManPat}),
  fNum('stopDens','패턴 영역 정지막 면적비 (과연마)','%',LIM.CMP_DENS_PCT[0],LIM.CMP_DENS_PCT[1],{def:CMP_DEF.stopDens,visibleIf:isStop}),
  fNum('time','또는 시간','s',0,LIM.TIME_S,{minEx:true,optional:true,visibleIf:st=>isCmp(st)&&st.mode!=='stop'})
  // STEP_POST.remove: time → amt = time*SLURRY[slurry].er[tgt]/60/1000 ; 구 'ero'(µm) → eroPct = clamp(ero/amt*100,-80,100), delete ero
  //   stop 모드: 기준 영역에 stopMat 없음 → 실행 시 오류 메시지 / slurry 키 검증은 values()로
*/

// ---- 엔진 상태 (checkpoint snap/load/reset 에 추가) ----
// let DENS=null, STEP=null;  resetState: DENS=new Float64Array(NP).fill(1); STEP=new Float64Array(NP);
// snapState: dens:DENS.slice(), step:STEP.slice() ; loadState: DENS=cp(s.dens); STEP=cp(s.step); bytes += 16*NP
// etch 자동 갱신 (consume pz 분기): loss=Math.min(h,bud*open*r); DENS[i]=Math.min(DENS[i],1-open); STEP[i]+=loss/Math.max(open,1e-6);
// deposit: if(M.plan>0) STEP[i]*=(1-M.plan);   (conformal은 유지 — est)

// ---- CMP 커널 의사코드 (결정적) ----
function cmpRun(st){
  const S=SLURRY[st.slurry];if(!S)throw new Error('알 수 없는 슬러리: '+st.slurry);
  const Lp=st.Lp??CMP_DEF.Lp,hc=st.hc??CMP_DEF.hc,dz=CMP_DEF.dz,half=Lp/2,opts={tg:null,open:0,noData:new Set()};
  const C=[];for(let i=0;i<NP;i++)if(pts[i].f>=CMP_DEF.contact[0])C.push(i);       // 접촉점(베벨 제외), p.d 오름/내림 순서 유지
  const E=i=>1+(st.eroPct??CMP_DEF.eroPct)/100*(1-smooth(0,st.eroW??CMP_DEF.eroW,pts[i].d));
  const wc=i=>smooth(CMP_DEF.contact[0],CMP_DEF.contact[1],pts[i].f);
  if(st.patSrc==='manual')for(const i of C){const w=smooth(st.patFrom-rampMm,st.patFrom+rampMm,pts[i].d);
    DENS[i]=1-w*(1-st.patDens/100);STEP[i]=w*st.patStep;}
  else if(st.patSrc==='off'){DENS.fill(1);STEP.fill(0);}
  // 창 평균: C 위에서 d 기준 two-pointer + prefix sum(ds 가중) → O(NP)
  const winMean=(arr)=>{/* out[i] = Σ arr[j]ds[j] / Σ ds[j], |d_j-d_i|<=half, j∈C */};
  const above=i=>{/* stopMat 최상단 층 위의 막 두께 합 (stopMat 없으면 NaN) */};
  const refPts=C.filter(i=>pts[i].f>.99&&pts[i].d>CMP_DEF.ref[0]&&pts[i].d<CMP_DEF.ref[1]);
  const stepOnce=(kOP)=>{const re=winMean(DENS);
    for(const i of C){const b=dz*E(i)*wc(i);if(b<=1e-12)continue;
      let rho=DENS[i];if(kOP&&isPat(pts[i]))rho=Math.min(rho,(st.stopDens??CMP_DEF.stopDens)/100);
      const pe=Math.max(CMP_DEF.RHO_MIN,kOP&&isPat(pts[i])?Math.min(re[i],rho):re[i]),H=STEP[i];
      let up,dn;if(H>hc){up=b/pe;dn=0;}else if(H>0){up=b*((1/pe-1)*H/hc+1);dn=b*(1-H/hc);}else{up=dn=b;}
      const avg=rho*up+(1-rho)*dn;consume(i,avg,S.r,opts);
      if(H>0){const L=topLayerAt(i),rt=L>=0?(S.r[layers[L].mat]??0):0;STEP[i]=Math.max(0,H-(up-dn)*rt);if(!STEP[i])DENS[i]=1;}
      /* LV[i] 증분 갱신(재계산 없이) */}};
  let used=0;const MAXN=Math.ceil(LIM.CMP_UM/dz);
  if(st.mode==='stop'){
    if(!refPts.some(i=>!isNaN(above(i))))return{err:`정지막 ${st.stopMat}이 기준 위치(R145)에 없습니다`};
    let n=0;while(n<MAXN&&!refPts.every(i=>!(above(i)>CMP_DEF.RESID_NM/1000))){stepOnce(false);n++;}
    if(n>=MAXN){recalc();return{warn:'Endpoint 미도달 — 제거량 상한 도달',noData:opts.noData};}
    used=n*dz;const nOP=Math.round(used*(st.op??CMP_DEF.op)/100/dz);for(let k=0;k<nOP;k++)stepOnce(true);
  }else{const n=Math.min(MAXN,Math.ceil(st.amt/dz));for(let k=0;k<n;k++)stepOnce(false);used=st.amt;}
  recalc();return{used,noData:opts.noData,metrics:cmpMetrics(st)};}
// cmpMetrics: §2.6 패턴↔떡판 단차(zUp=LV+(1-DENS)*STEP, 경계 ±Lp), 면적평균 단차, 전이폭, 잔여 패턴 단차,
//             베벨 W 잔막(f<.8, W>1nm), Edge 잔막 링(stop 모드, d<eroW, f≥.8, stopMat 위 >1nm), W recess 지표(S.recessNm, 패턴 영역)
```

참고 사항
- 성능: `NP × 서브스텝`이고 amt 20 µm면 최대 1000 서브스텝이다. 창 평균은 O(NP) prefix-sum으로 계산해야 한다. `winMean(DENS)`는 서브스텝마다 다시 계산한다. DENS가 바뀌는 시점은 H가 0이 될 때뿐이므로, 변경 플래그로 캐시해도 된다.
- 결정성: 고정 dz, 고정 순회 순서를 쓰고 Math.random을 쓰지 않는다. endpoint 판정이 정수 서브스텝 단위이므로 같은 입력이면 같은 결과다.
- 기존 `cmp(st)` 호출부(1365행 부근 `else if(st.action==='cmp')cmp(st)`)를 `cmpRun`으로 바꾸고, 반환된 err/warn/noData를 impact에 연결해야 한다.
