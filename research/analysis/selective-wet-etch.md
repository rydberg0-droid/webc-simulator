# Enlarge / 선택적 wet etch — Edge 측면 recess(void·처마) 모델 분석 (2026-10-08)

입력: `research/sources/selective-wet-etch.md`(주), `research/sources/cleaning-etch-rates.md`, `research/analysis/edge-profile.md`, `webc_simulator_v3.html`(읽기만 함. 줄 번호는 조사 시점 기준).
표기: **[src]** 문헌 수치 그대로 · **[환산]** 단위나 정의를 바꾼 값(식 병기) · **[est]** 추정값(근거 서술) · **[legacy]** 현행 값 유지.
회사 비공개 레시피 값은 쓰지 않았다. 'USN'이라는 명칭의 공개 수치는 없어서(sources §USN) 일반명 "고선택 인산"으로 다룬다.

---

## 0. 요약

| 항목 | 채택 | 근거 | 신뢰도 |
|---|---|---|---|
| `hotp` (무첨가 hot H3PO4 160 ℃) | **값은 그대로 둔다.** SiN 20 · SiO2/MTTEOS 0.21 · HTTEOS 0.18, est 목록에 SiO2·MTTEOS를 추가하고 note를 보강 | W03 Table III/IV [src]. SiO2 0.21은 LTO 값을 대신 쓴 것이다(PECVD oxide는 W03에서 '-'). YMTC 특허의 0.12~0.22 nm/min과 맞는다 | 상(SiN·HTTEOS), 중(SiO2 대용값) |
| `usn` (고선택 인산, 'HSP'도 같은 키) | **SiN 20 nm/min, SiN:SiO2 선택비 500**(범위 100~2000) → SiO2 0.04, HTTEOS 0.034, SiON 0.9 | SiN 기준값은 hotp와 같은 W03 PECVD 고RI [est: 첨가제가 SiN 식각률에 주는 영향 0으로 가정]. 선택비는 문헌 범위(YMTC 목표 >400, Chung-Ang 940, Entegris 실시형태 100~2000)의 중간값 [est] | 하~중 |
| `dsp` (희석 H2SO4/H2O2, W/TiN recess) | **W 6 · TiN 6 nm/min**(범위 1~40), oxide·SiN·Si 0 | Versum 10~400 Å/min = 1~40 nm/min [환산]의 로그 중앙값 [est]. W와 TiN을 같은 값으로 둔 근거는 Versum의 "equal thickness" 서술이다. oxide 0은 W03 Piranha·H2O2 실측(0)을 그대로 가져온 값이다 | 하 |
| **TiN 막질 추가** | **추가한다**(fam metal). 값은 boe 2.5 [src W03], spm 14 [환산 Intel], dsp 6 [est]만 넣고 나머지 약액은 데이터 없음으로 둔다 | W/TiN을 동시에 recess하는 공정을 표현하려면 필요하다 | — |
| `dhf`·`boe`·`lal` | 유지 (boe에만 TiN 2.5 추가) | W03 | 상 |
| 측면 식각 모델 | 노출된 끝단에서 안쪽으로 **L_j = κ·r_j·max(0, D·w − B_open)**. κ=1(wet·gas, 등방). B_open은 끝단 바깥 점에서 끝단을 덮던 막을 모두 지우는 데 드는 budget이다(보호막 소진 시간) | 등방 wet의 물리, 기존 `consume()`의 budget 단위를 그대로 씀 | 중(구조), 하(전달 제한·regrowth 무시) |
| void | 새 막질 `VOID`(표시 전용, 식각 비용 0, 증착은 그 위에 쌓임) | 사용자 제안 | — |
| 처마 판정 | 처마 AR = L / 처마 oxide 유효 두께. **lvl1 ≥ 3, lvl2 ≥ 10**, 처마 소실이나 막 이탈이면 lvl2 | 문헌 정량값 없음 [est] | 하 |

**핵심 발견 (모델 결과로 나오는 것)**
1. 끝단 위 SiN 테라스(그 SiN이 최상단인 구간)는 **수직으로** 금방 지워진다(두께 60 nm ÷ 식각률). 그 뒤 바로 위 oxide 끝 밑으로 측면 recess가 진행된다. 따라서 PES 경사가 완만해도(테라스 폭 수 µm) 처마는 생긴다. 처마 길이 L ≈ κ·r_SiN·(D − h_SiN/r_SiN)이다(target이 SiN이면 D − h_SiN).
2. 예시(Mold 기본값 Ox 90 / Nit 60 nm, PES 후 cap 없음): USN 20 min → L ≈ 0.34 µm, AR ≈ 3.8 (lvl1). H3PO4 30 min → L ≈ 0.54 µm, AR ≈ 6.4~6.9 (lvl1). H3PO4 60 min → L ≈ 1.14 µm, AR ≈ 15~18 (lvl2). (AR 범위 = 처마 oxide 윗면이 테라스로 노출됐는지에 따라)
3. 보호막: SiON 50 nm cap이 있으면 USN에서 소진에 약 56 min이 걸려 20 min 공정은 **보호된다**. 무첨가 H3PO4에서는 25 min이면 소진되므로 30 min 공정은 **소진 후 0.1 µm recess**가 생긴다(SiON 식각률은 est이므로 민감도가 크다). Oxide cap 50 nm는 두 약액 모두에서 보호된다.
4. recess L(0.1~1 µm)은 엔진 격자(끝단 0.01 mm = 10 µm)보다 훨씬 작다. 그래서 **void를 격자 형상으로 바꾸는 일은 L이 격자보다 클 때만 생기고, 판정은 해석 지표(칩)로 한다.** 형상 표시는 frontend 확대 도식으로 하기를 권장한다(§3.3).

---

## 1. CLN_DB 신규·갱신 (backend-dev 붙여넣기용)

### 1.1 막질 대응·환산
| 원문 | 원값 | 환산 | 시뮬레이터 키 |
|---|---|---|---|
| W03 PECVD Si Nit High RI, Phosphoric 160 ℃ | 20 nm/min | — | SiN (기존 대응 규칙 "PECVD 고RI") |
| W03 Unan./Ann. LTO Tylan, Phosphoric | 0.21 nm/min | — | SiO2·MTTEOS (PECVD oxide는 '-', LTO 값을 대신 씀 → est) |
| W03 Thermal oxide wet, Phosphoric | 0.18 | — | HTTEOS |
| YMTC US 10,913,893 무첨가 150~170 ℃: SiN | 35~65 Å/min | ÷10 → **3.5~6.5 nm/min** | (교차 확인용, 막 미상) |
| YMTC 같은 조건 Si oxide | 70~130 Å/h | ÷10 ÷60 → **0.117~0.217 nm/min** | SiO2 0.21과 맞음 |
| TEL US 10,886,290 baseline 150 ℃ | 62 Å/min | **6.2 nm/min** | (교차 확인용) |
| Intel US 9,472,456 TiN, 92.1 % H2SO4 + 7.9 % H2O2 (≈11.5:1), 100 ℃ | 2.1~2.6 Å/s (평균 2.3~2.4) | ×6 → **12.6~15.6 nm/min** (평균 ≈14) | TiN @ spm |
| Intel W, H2SO4:H2O2 = 7:1 | 0 Å/min | 0 | W @ spm 교차 확인(기존 spm W 50 est와 충돌 — §1.4) |
| Intel W, 1:4 / 2:3 | 12~20 / 25~40 Å/s | ×6 → 72~120 / 150~240 nm/min | H2O2 비율이 높을수록 W가 빠르다(경향) |
| Versum US 11,499,236 W 및/또는 TiN | 10~400 Å/min | ÷10 → **1~40 nm/min** | W·TiN @ dsp |
| Versum 모재(oxide·SiN·Si) 대비 선택비 | ≥10~20 | oxide ≤ W/20 | dsp 상한 확인용 |

### 1.2 선택비 문헌 판정 (usn)
| 출처 | SiN:SiO2 | 조건 | 비고 |
|---|---|---|---|
| Entegris (Background) | fresh hot phos ~40:1 | 145~180 ℃ | 무첨가 |
| YMTC (Background) | ~30 → 목표 ">400" | 150~170 ℃ | |
| Chang Chien JES 2018 | 60~100 | 144~154 ℃, 단매엽 | |
| TEL 특허·ECS 2015 | ">100:1" | silica 첨가 | |
| Chung-Ang ACS SCE 2021 [검색발췌] | "up to 940" | 미확인 | |
| Entegris 실시형태 / 청구 | 100~2000 / 10~7000 | 40~120 ℃ | 조성 청구 범위 |
| W03 (시뮬레이터 hotp) | 20/0.21 ≈ **95** | 160 ℃ | PECVD SiN 기준이라 LPCVD 기준 문헌값(25~40)보다 큼 |

- 충돌 판정: 무첨가 선택비가 30~40(LPCVD SiN 기준, 문헌)과 95(W03 PECVD SiN 기준) 두 가지로 나온다. **막질 차이**로 설명된다(W03에서도 PECVD 고RI 20 vs LPCVD 4.5). 시뮬레이터 SiN 키는 PECVD 고RI이므로 hotp ≈ 95를 유지한다.
- "초고선택(ultra)"은 무첨가보다 10배 이상 높아야 의미가 있다. 그래서 **기본 500**으로 정했다. YMTC 목표 >400보다 높고 Chung-Ang 940보다 낮으며 Entegris 100~2000 범위 안이다. 문헌 하나의 실측이 아니므로 **est**다. 범위는 100~2000이다. 100은 TEL ">100:1" 수준으로 hotp(95)와 거의 같다.
- **SiN 절대 식각률 충돌**: 3D NAND 특허 문맥(YMTC·TEL)은 3.5~6.5 nm/min이고 W03 PECVD 고RI는 20 nm/min이다. 막이 다르거나 온도 차(TEL 150 ℃)로 설명할 수 있다. **DB 내부 일관성**(SiN 키 = W03 PECVD 고RI, hotp와 같은 기준)을 우선해 20을 채택한다. 첨가제가 SiN 식각률을 바꾸는 효과(Yonsei 초록: Si계 첨가제는 감소, F계는 30 % 이상 증가)는 서로 반대 방향이고 정량값이 없어서 0으로 본다. 실제 3D NAND mold SiN에서는 recess가 약 1/3로 작을 수 있다(note에 표시).
- SiON(est): 산화막과 질화막 식각률의 기하평균 √(r_SiN·r_SiO2)으로 정했다. 이 규칙은 기존 hotp SiON 2(est)를 √(20·0.21)=2.05로 재현하므로 같은 규칙을 usn에 적용했다 → √(20·0.04)=0.89 ≈ 0.9.

### 1.3 JS 블록
```js
// ---- 선택적 wet etch (Enlarge) — research/analysis/selective-wet-etch.md ----
// 기본 조건(온도 파라미터 없음): hotp = 85% H3PO4 160℃ · usn = 첨가제 인산(실리카/실란계) 150~160℃ 상당 · dsp = 희석 H2SO4/H2O2 실온~60℃
const YMTC893='YMTC, US 10,913,893 B2 (Additive to phosphoric acid etchant)';
const HSP_SRC='선택비 문헌 범위: YMTC US 10,913,893 (무첨가 ~30 → 목표 >400) · TEL US 10,886,290 (>100:1) · Chung-Ang ACS SCE 2021 (up to 940, 검색발췌) · Entegris US 11,421,157/12,203,022 (실시형태 100~2000)';
const VER236='Versum Materials, US 11,499,236 B2 (Etching solution for tungsten word line recess)';
const INT456='Intel, US 9,472,456 B2 (selectively etching Ti/TiN)';

// 갱신: hotp — 값 유지, est·note·tag만 변경
 hotp:{name:'Hot H3PO4 160℃',cat:'wet',ab:'H3PO4',amt:100,tgt:'SiN',tag:'WET ETCH',cond:'85% H3PO4, 160℃ (무첨가)',src:W03+' · 교차: '+YMTC893+' oxide 70~130 Å/h(=0.12~0.22 nm/min)',
   er:{SiN:20,SiO2:.21,MTTEOS:.21,HTTEOS:.18,SiON:2,Si:.17,Poly:.1,PR:55,W:0},est:['SiO2','MTTEOS','SiON','Poly','W'],
   note:'SiN strip·Enlarge(무첨가) · SiN:SiO2 ≈ 95 (PECVD 고RI 기준) · SiO2 = LTO 값 대용(PECVD oxide 미측정) · LPCVD SiN은 4.5nm/min · 3D NAND 특허 문맥 SiN 3.5~6.5nm/min(YMTC) · PR은 박리'},

// 신규: usn — 고선택(초고선택) 인산. 입력 'USN'·'HSP'·'고선택 인산'·'ENLARGE'(약액 미지정)
 usn:{name:'고선택 인산 (USN/HSP)',cat:'wet',ab:'USN',amt:100,tgt:'SiN',tag:'WET ETCH',sel:500,selRange:[100,2000],
   cond:'H3PO4 + Si계 첨가제(실리카/실란), 150~160℃ 상당 — 온도 파라미터 없음',src:HSP_SRC+' · SiN 기준값 '+W03+' (hotp와 동일 기준)',
   er:{SiN:20,SiO2:.04,MTTEOS:.04,HTTEOS:.034,SiON:.9,Si:.17,Poly:.1,PR:55,W:0},est:['*'],
   note:'SiN:SiO2 = 500 (est, 문헌 100~2000) · SiO2 = 20/500, HTTEOS = SiO2×0.857(hotp 비율), SiON = √(SiN·SiO2) · 첨가제의 SiN 식각률 영향 0 가정 — 3D NAND mold SiN은 ~1/3일 수 있음 · oxide regrowth(silica 재침적) 미반영'},

// 신규: dsp — 희석 황산·과수 (W/TiN recess). 입력 'DSP'·'DSP+'(HF 첨가 — 수치 없음, DSP로 근사)
 dsp:{name:'DSP (희석 H2SO4/H2O2, W·TiN recess)',cat:'wet',ab:'DSP',amt:30,tgt:'W',tag:'WET ETCH',
   cond:'희석 H2SO4 + H2O2 수용액, 실온~60℃ 상당 — 온도 파라미터 없음',src:VER236+' W·TiN 10~400 Å/min(=1~40 nm/min), 모재 대비 ≥10~20 · 산화막·SiN 0 = '+W03+' Piranha·H2O2 50℃ 실측 유추',
   er:{W:6,TiN:6,SiO2:0,MTTEOS:0,HTTEOS:0,SiN:0,SiON:0,Si:0,Poly:0},est:['*'],
   note:'W = TiN (Versum: "TiN and W should be simultaneously etched with equal thickness") · 1~40 nm/min의 로그 중앙값 · DSP+(HF 첨가)의 W/TiN/oxide 식각률 문헌 없음 — oxide 0은 DSP+에서 과소 · PR·Carbon·Cu 데이터 없음(정지+경고)'},

// 갱신: TiN 추가분만
 boe: er에 TiN:2.5 추가 (W03 Table VI 'TiN Sputtered, 5:1 BHF' = 2.5 [src])
 spm: er에 TiN:14 추가, est에 'TiN' 추가 — Intel 92.1% H2SO4 + 7.9% H2O2(≈11.5:1) 100℃ 2.1~2.6 Å/s ×6 = 12.6~15.6 nm/min, 평균 ≈14
      (src 문자열에 ' · TiN: '+INT456 추가)
```

```js
// MATERIALS 추가 (MAT_FAMS에 'void' 추가, PALETTE.metal.TiN·PALETTE.void.VOID 색 추가)
  // TiN: 응력·coverage 출처 없음(MAT_EST 전부 추정). 응력은 증착법(PVD 압축/CVD 인장)에 따라 부호가 바뀌어 0(중립)으로 둠
  TiN:{name:'TiN (Barrier)',fam:'metal',stress:0,side:.80,bot:.70,plan:0,est:MAT_EST},
  // VOID: 측면 wet etch로 비운 자리(표시 전용). 식각·세정·CMP 비용 0, 증착 대상 아님(증착 막 선택 목록에서 제외)
  VOID:{name:'Void (측면 식각 공동)',fam:'void',stress:0,side:0,bot:0,plan:0,est:MAT_EST,display:'only'},
```
- PALETTE.void.VOID: 반투명 배경색 + 점선 테두리(기존 `dash` 방식, L543·L2571 참고)로 표시한다.
- `isDielectric('VOID')`는 false(DIELECTRIC_FAMS에 넣지 않음) → Arcing 판정에서 빠진다. 응력이 0이라 Warpage 계산에도 영향이 없다.
- `KEYS`를 쓰는 증착 막 선택 UI와 막질 표에서는 `MATERIALS[k].display==='only'`인 키를 걸러낸다.
- TiN이 추가되면 `ETCH.*.r`, `SLURRY_DB`, 나머지 `CLN_DB` 약액에는 TiN 값이 없다. 이것은 의도된 동작이다(데이터 없음 → 정지 + ⚠). 다만 레시피에 TiN 증착이 있을 때만 해당한다.

### 1.4 sanity check
| 규칙 | 결과 |
|---|---|
| Hot H3PO4 SiN ≫ SiO2 | hotp 95 ✓, usn 500 ✓ |
| usn이 hotp보다 선택비가 높음 | 500 > 95 ✓ (sel 하한 100이면 거의 같음 — 범위 하한 경고 불필요) |
| dsp W·TiN ≫ oxide·SiN | 6 vs 0 ✓ (Versum ≥20 조건 충족) |
| 기존 spm W 50(est) vs Intel 7:1 W 0 [src] | **⚠ 충돌.** Intel 결과는 H2SO4 비율이 높을수록 W가 0이고 H2O2 비율이 높을수록 72~240 nm/min이다. SPM(진한 황산 위주)이면 0에 가깝다. **spm W를 0으로 바꾸기를 권장한다**(est 유지, src: Intel 7:1 0 Å/min). 기존 50의 근거는 확인하지 못했다 |
| hotp PR 55 | W03 "P120/55"(S1822 120, OCG820 55, P=일부 박리). 유지 |

### 1.5 변경 전/후
| 키 | 항목 | 전 | 후 | 근거 |
|---|---|---|---|---|
| hotp | er | (그대로) | (그대로) | W03 |
| hotp | est | SiON, Poly, W | + SiO2, MTTEOS | PECVD oxide 미측정, LTO 값 대용 |
| hotp | tag/note | — | 'WET ETCH', 선택비·문맥 note | 표 태그 |
| usn | 전체 | 없음 | 신규 (SiN 20, sel 500) | §1.2 |
| dsp | 전체 | 없음 | 신규 (W·TiN 6) | Versum [환산] |
| boe | TiN | 없음 | 2.5 | W03 Table VI |
| spm | TiN | 없음 | 14 (est) | Intel [환산] |
| spm | W | 50 (est) | **0 권장** (est) | Intel 7:1 0 Å/min |
| MATERIALS | TiN, VOID | 없음 | 신규 | §1.3 |
| dhf, lal, 기타 | — | 유지 | 유지 | — |

---

## 2. 측면 식각(lateral recess) 모델 — 1D 단면 근사

### 2.1 정의
- **budget 단위**: 기존 clean과 같이 D = st.amt/1000(target 막 환산 µm)이다. 시간 입력은 기존 `STEP_POST.clean`이 amt = t·rate로 바꾼다. 상대 식각률 r_m = er_m/er_tgt(=`CLEAN[k].r`).
- **끝단(side face)**: 막 j의 h_j[i] > ε(=1 nm)인 연속 구간의 경계 점 b와, 그 바깥 이웃 점 o(h_j[o] ≤ ε)의 쌍이다. 프로파일 인덱스는 전면 평탄부 → 베벨 → 후면 순이므로 경계마다 방향 dir(=+1: o=b−1, recess는 i 증가 방향 / −1)을 둔다. 전면 PES 끝단과 후면 wrap 끝단을 같은 방식으로 처리한다.
  - 제외 대상: 도메인 양 끝(i=0, NP−1)은 계산 영역 경계일 뿐 실제 끝단이 아니다. `isPat(pts[b])` 점(셀 hole 측벽, 즉 셀 영역 Enlarge 자체)은 이번 범위 밖이다. VOID 막도 제외한다.
- **보호막·소진**: 끝단 j의 측면은, 단계 직전(pre) 상태의 바깥 점 o에서 **막 j와 그 위 막(stack 순서 k ≥ j)을 모두 지워야** 약액에 닿는다. 필요한 budget은 다음과 같다.
  ```
  B_open(j,o) = Σ_{k≥j, h_k^pre[o]>ε} h_k^pre[o] / r_k        (µm, target 환산)
                · r_k가 undefined(데이터 없음) 또는 ≤ RESIST_R 이면 ∞ (보호, 데이터 없음이면 noData 기록)
  ```
  - 이 식은 `consume()`이 점 o에서 위부터 막 j 바닥까지 소모하는 need와 같다. 그래서 **보호막(SiON·Oxide·BVO cap) 소진 시간**과 **SiN 테라스(그 SiN이 최상단인 구간) 수직 제거 시간**이 한 식에 자연히 들어간다.
- **recess 깊이**:
  ```
  B_lat(j) = max(0, D·w(o) − B_open(j,o))       w = 처리 영역 가중(wf, imm=1)
  L_j      = κ · r_j · B_lat(j)                   (µm, 등방 측면)
  κ: wet 1.0, gas 1.0 (VHF·XeF2·ClF3 등방, est), plasma 0 (모델 미적용 — 기존 edgeMetrics kLat 경로 유지)
  ```
  - 보호됨: B_open ≥ D·w → L=0, 여유 = 1 − D·w/B_open.
  - 보호막 소진: 0 < B_open < D·w이고 o에 j보다 위 막(k>j)이 있었으면 "소진 후 recess" 상태다.
- **Oxide(저식각 막)도 같은 식**으로 L_ox = κ·r_ox·B_lat 만큼 끝이 후퇴한다(선택비가 자동 반영됨. usn 400 nm에서 0.8 nm).
- **처마 oxide 박막화**: SiN j의 void 위 처마 막 e(점 b에서 j 바로 위, h>ε인 첫 non-VOID 막)는 void 쪽 아래 면이 노출되어 깎인다. 입구가 가장 오래 노출되므로 최악값은 다음과 같다.
  ```
  h_e,eff = h_e^post[b] − κ·r_e·B_lat(j)      (윗면 손실은 수직 consume가 이미 h_e^post에 반영)
  ```
  처마 아래쪽 막(void 바닥 oxide)도 r·B_lat 만큼 얇아진다. 이것은 지표에만 쓰고 지지 쪽이라 위험 판정에서는 뺀다.
- **막 이탈(lift-off)**: L_j ≥ 구간 길이(arc[b] → 구간 반대 끝 또는 도메인 끝)이면 막 j 전체가 void가 되고 위 적층이 떠 있는 상태 → lvl2.

### 2.2 Mold 다층 처리
- 층마다 독립적으로 위 규칙을 적용한다. PES top-down 후 각 SiN j는 자기 끝단 T_j를 가지고, 바깥 점 o에는 j 위의 막이 없다(아래 막만 있음) → B_open = h_j^pre[o]/r_j(테라스, 격자 점이 테라스 안에 있을 때) 또는 0이다.
- 이 경우 **96층이면 SiN 48개 각각에 처마**가 생긴다. 처마 oxide = SiN j 바로 위 oxide(j+1)이다. 그 윗면은 테라스로 노출되어 있고 더 안쪽에서는 SiN j+2가 받친다. 따라서 처마 길이는 L_j이다.
- **cap(BVO SiON·Oxide)**이 PES 뒤에 증착되면 모든 끝단의 o에 cap이 있다 → B_open = h_cap/r_cap + (o에 남은 j 이상 막). 모든 층이 동시에 보호되거나, cap 두께가 같으면 동시에 소진된다. cap은 베벨 쪽(경사면 아래)이 얇은 taper 형태라 **가장 바깥(아래쪽) 끝단이 먼저 열린다** — 모델이 점별 h_cap으로 자동 반영한다.
- 계산량: 경계 찾기는 막당 O(NP)이지만 `nzRange`(이미 meta에 nlo가 있음) 안만 훑으면 된다. 3000층 레시피에서도 기존 `consume` 한 번과 같은 규모다.

### 2.3 처리 순서 (한 clean 단계 안)
1. **pre 스냅샷**: 경계 후보를 찾는 데 필요한 것은 막별 h^pre뿐이다. clean 전에 `layers.map(l=>l.h.slice(lo,hi))`로 0이 아닌 구간만 복사한다(기존 `packH` 재사용 가능).
2. 기존 `clean(rates, D, wf)` 수직 소모(변경 없음).
3. **post 상태에서 끝단을 다시 찾는다.** 각 경계(b, o)에 대해 B_open은 **pre 두께**로 계산한다(위 식). 이렇게 하면 수직 소모로 경계가 안쪽으로 이동한 경우(테라스 제거, cap 소진)도 정확히 처리된다.
4. L_j를 계산하고, 격자 점 중 arc 거리가 끝단 위치 e_j에서 L_j 안에 드는 점을 VOID로 바꾼다(§3).
   - e_j = (arc[b]+arc[o])/2. 반 칸 근사이며 오차는 격자 간격의 절반 이하다.
5. 처마 박막화를 적용한다(VOID로 바뀐 점의 위아래 인접 막. 격자에 VOID가 없으면 지표만 계산).
6. 지표와 칩을 만든다(§4).

### 2.4 적용 범위·한계 [est]
- **전달 제한 무시**: 좁은 틈(SiN 두께 수십 nm) 안으로 깊어질수록 식각률이 떨어진다(TEL 특허: 층수가 많을수록 식각 소요가 늘어남. Reiter SISPAD 2023: 확산·regrowth). 정량값이 없어 κ=1 상수로 둔다. **L_j / h_j > 20(est)이면 정보 칩** "좁은 틈 확산 제한 가능 — 실제 recess는 더 작을 수 있음"을 띄운다.
- **oxide regrowth(silica 재침적) 무시**: usn 같은 실리카 첨가 약액은 입구에 SiO2가 다시 쌓여 틈을 막을 수 있다(Kim·Teng·Reiter, 정성). 수치가 없다.
- **처마 처짐·붕괴는 형상에 반영하지 않는다.** 판정(lvl)으로만 표시한다.
- plasma 세정은 이 모델을 쓰지 않는다. 기존 `edgeMetrics`의 kLat 차등 후퇴를 유지한다.
- wet·gas 단계에서 이 모델이 돌면 `edgeCutOf(st).kLat`를 0으로 두어 기존 undercut 칩과 중복 보고하지 않게 한다.

---

## 3. void 표현

### 3.1 방식: VOID 막을 그 막 바로 위에 끼워 넣기
- recess 구간의 격자 점 i에서 `layers[j].h[i]`의 값 v를 0으로 만들고, **layers 배열의 j+1 위치에 새 막 `{mat:'VOID', thin:layers[j].thin, si:CURSI}`**를 넣어 h[i]=v로 둔다.
  - 그 점에서 VOID는 j의 원래 자리를 차지한다(아래 막 위, 위 막 아래). 표면 높이 LV와 위 막 위치는 변하지 않으므로 **처마가 원래 높이에 그대로 떠 있다.**
  - 같은 단계에서 같은 j에 대한 VOID는 막 하나로 합친다(구간 여러 개면 h 배열 하나에 모음).
  - 한 단계에서 VOID 막이 최대 SiN 층 수만큼 늘어난다. meta는 0이 아닌 구간만 보관하므로(pushLayer 방식) 메모리 부담은 작다.
  - meta를 만드는 함수: `pushLayer`와 같은 내용을 `insertLayerAt(idx, mat, h, thin)`으로 분리한다(법선 nx·ny는 j의 meta 구간을 복사하고, b0는 표시 기준이라 j의 b0 + j 두께를 쓰거나 NO_B0).
- **consume()**: 막 루프에서 rate를 조회하기 **전에** `if(ly.mat==='VOID'){ly.h[i]=0;continue;}`를 둔다. 위가 다 지워져 공동이 열리면 비용 0으로 사라지고(바닥으로 내려앉음), 그 아래 막부터 계속 소모한다. gone(제거된 막 두께 합)에는 넣지 않는다.
  - CMP(`cmpRun`)·`removal()` 비율 곱·`stripTopDown`도 같은 규칙(VOID는 rate 조회 없이 제거)을 따른다. VOID가 SLURRY er에 없어서 '데이터 없음 정지'가 생기는 일이 없게 한다.
- **이후 증착**: 표면(LV)은 처마 위다 → 새 막은 처마 위에 쌓인다. **공동 내부 재충전은 1D에서 무시한다.** conformal 증착(side ≥ 0.7)이면 입구가 막 두께의 약 절반 이상 증착될 때 pinch-off된다는 사실을 note 칩으로만 알린다 [est].
- **표시(frontend)**: VOID는 점선 테두리와 반투명으로 그린다. Mold 묶음 표시(`groupPresence`·`unitBase`·`sameGroup`)는 **VOID 막을 건너뛰고** 묶음을 이어야 한다. 그러지 않으면 VOID가 끼어든 곳에서 Mold 묶음이 SiN 층마다 쪼개진다. 호버 툴팁 문구: "Void (측면 식각) — 막 j(SiN) L µm".
- 대안(참고): 막 배열에 끼워 넣지 않고 `ly.vd`(void 두께 동반 배열)를 두는 방식도 있다. 묶음 표시는 깨지지 않지만 consume·체크포인트·표시 전부에 필드가 하나씩 늘어난다. 사용자 제안(mat 'VOID')을 따라 3.1을 기본으로 한다.

### 3.2 체크포인트
- VOID는 일반 막과 같으므로 `snapState/loadState`를 바꿀 필요가 없다.

### 3.3 격자 분해능 (중요)
- 끝단 격자 간격은 10 µm(d ≤ 11 mm 세분 후)이고, 일반적인 L은 0.1~1 µm다 → **대부분 격자 VOID가 생기지 않는다.** 판정은 해석 지표 L_j, AR로 한다(격자와 무관하게 정확).
- 사용자가 L > 10 µm(예: 'USN 20um')를 넣으면 격자 VOID가 실제로 보인다.
- frontend 권장(선택): 칩을 클릭하면 **끝단 확대 도식**(µm 축척, 위 3~5층의 계단·void·처마를 지표 값으로 그린 그림)을 연다. 엔진 형상이 아니라 도식이라고 표기한다.

---

## 4. 처마 지표·판정 (칩)

| 키 | 정의 | lvl |
|---|---|---|
| `측면 recess` | L_max = max_j L_j (막질별, 대표 = 대상 막 tgt). 예 "SiN 0.34µm · 48층 (est)" | 처마 판정과 같음 |
| `처마` | n = L_j > `LAT_DEF.minUm`(5 nm)인 대상 막 층 수, AR_max = max_j L_j / h_e,eff. 예 "48층 · AR 3.8" | AR < 3 → 0, 3~10 → 1(박리·particle 주의), ≥ 10 → 2(붕괴·박리 위험) |
| `처마 소실` | h_e,eff ≤ 0인 처마(위아래 void가 이어짐 = 층 분리) | 2 |
| `막 이탈` | L_j ≥ 구간 길이 | 2 |
| `보호됨` | 끝단이 있고, 그중 B_open ≥ D·w로 L=0인 끝단 비율과 최소 여유. 예 "SiON cap · 여유 64 %" | 0 (여유 < 20 % → 1, 공정 산포 고려 est) |
| `보호막 소진` | o에 k>j 막이 있었고 0 < B_open < D·w. 예 "SiON 소진 후 0.10µm" | 1 이상 (처마 판정과 max) |
| `확산 제한?` | L_j/h_j > 20 | 0 (정보) |
| `공동 충전` | 이후 단계의 conformal 증착이 VOID 위에 올 때 | 0 (정보, est) |

- 임계값 AR 3·10, 여유 20 %, L/h 20은 모두 **est**다(공개 정량 사례 없음 — sources §못 찾은 것). 상수 하나로 모은다.
- impact 문구 예: "Edge 끝단 SiN 측면 recess 0.54µm(48층) — 처마 AR 6.4: 박리·particle 주의 (est)". 근거 인용: Nanja, Semiconductor Engineering 2019 "nitride exhume step can cause defects at the bevel through wet undercut", "peeling or delamination".
- 칩 표시 하한: L_max ≥ 0.01 µm. 이보다 작으면 칩을 생략한다(기존 DHF 세정 레시피에 의미 없는 칩이 늘어나는 것을 막음). '보호됨'은 끝단이 하나라도 있고 tgt 막 끝단이 보호된 경우에만 띄운다.

---

## 5. 서술형 입력·공정 표

| 입력 | 해석 |
|---|---|
| `ENLARGE H3PO4 30min` | hotp, imm, time 1800 s → amt 600 nm |
| `ENLARGE 20min` | 약액 미지정 → **usn 가정**(note "Enlarge 약액 미지정 — 고선택 인산(USN) 가정") |
| `USN 20min` / `HSP 20min` / `고선택 인산 20분` | usn, amt 400 nm |
| `WET ETCH USN 1um` | usn, amt 1000 nm (SiN 환산) |
| `DSP 5min` | dsp, amt 30 nm |
| `DSP+ 5min` | dsp + warn "DSP+(HF 첨가) 수치 없음 — DSP로 근사, oxide 식각 과소" |
| `BEVEL USN 20min 3mm` | usn, mode edge, distMm 3 (기존 edge 경로) |

```js
// ck 체인 맨 앞에 추가 (DSP+의 'HF', 'DSP H2SO4'가 dhf·spm으로 새지 않게)
const ck=has(/\bUSN\b|\bHSP\b|ULTRA ?SEL|초?고선택 ?(인산|질화|SIN)/)?'usn':
  has(/\bDSP\b|DILUTED ?SULF|희석 ?황산/)?'dsp':
  has(/XEF2/)?'xef2': … (기존 그대로) … :null;
const ckE=ck??(has(/ENLARGE|인라지|엔라지/)?'usn':null);              // 약액 미지정 Enlarge → usn (note)
if(has(/DSP ?\+/))warn('DSP+(HF 첨가) 식각률 문헌 없음 — DSP로 근사 (oxide 식각 과소)');
// WET 명시 시 건식 Etch 키(SIN→nit 등)보다 세정 키 우선: 'WET ETCH SIN USN'이 건식 nit로 가지 않게
const wetForced=has(/\bWET\b|습식|ENLARGE|인라지|엔라지/);
if(ckE&&(!(isEtch&&eKey)||wetForced))return CL(ckE,cmode);
```
- 공정 표 태그: `CLN_DB.tag`(선택 필드)가 있으면 `CLN_TAG[cat]` 대신 쓴다. L1389 `cells`를 `c.tag||CLN_TAG[c.cat]||'WET'`로 바꾼다. 태그 'WET ETCH'는 hotp·usn·dsp에 붙는다. CSS는 기존 `bc` 클래스를 재사용하고 폭만 확인한다.
- (선택, 우선순위 낮음) usn 단계 필드 `sel`(선택비, 100~2000, 비우면 500): SiO2 = SiN/sel, MTTEOS = SiO2, HTTEOS = 0.857·SiO2, SiON = √(SiN·SiO2)로 단계별 rates를 만든다(`cleanRatesOf(st)`). 기본값 외에는 est 칩을 띄운다.

---

## 6. backend-dev 블록

```js
// ---- 측면 wet etch (lateral recess → VOID) — research/analysis/selective-wet-etch.md §2~4 ----
const LAT_DEF=Object.freeze({
  EPS:1e-3,               // µm, 막 존재 판정 (1nm)
  kappa:{wet:1,gas:1,plasma:0},   // 등방 측면 계수 (est)
  minUm:.005,             // 처마로 세는 최소 recess (µm)
  chipUm:.01,             // 칩 표시 하한 (µm)
  arWarn:3,arHigh:10,     // 처마 AR 임계 (est)
  marginWarn:.2,          // 보호 여유 경고 (est)
  diffAR:20,              // L/h 확산 제한 정보 (est)
  src:'est — 등방 wet 측면 = 수직 식각률, 전달 제한·regrowth·처마 처짐 미반영. 위험 근거: Nanja, Semiconductor Engineering 2019 (bevel wet undercut, peeling)'});

// pre: 단계 직전 막 두께 (layers 인덱스 → Float64Array 또는 packH 형식), D: target 환산 µm, wf: 처리 영역 가중
function lateralWet(c,rates,D,wf,pre){
  const kap=LAT_DEF.kappa[c.cat]||0;if(!(kap>0))return null;
  const res={ends:[],noData:new Set()},E=LAT_DEF.EPS;
  const hPre=(k,i)=>{const p=pre[k];return p?(i>=p.lo&&i<p.lo+p.v.length?p.v[i-p.lo]:0):0;};   // 이번 단계에 새로 생긴 막(VOID)은 pre 없음 → 0
  // 끝단 j의 바깥 점 o에서 j 이상(stack 위) 막을 지우는 budget
  const openBudget=(j,o)=>{let B=0,cov=false;
    for(let k=j;k<pre.length;k++){const h=hPre(k,o);if(!(h>E))continue;const m=layers[k].mat;if(m==='VOID')continue;
      const r=rates[m];if(r===undefined){res.noData.add(m);return{B:Infinity,cov:true};}
      if(r<=RESIST_R)return{B:Infinity,cov:true};B+=h/r;if(k>j)cov=true;}
    return{B,cov};};
  const L0=layers.length;
  for(let j=0;j<L0;j++){const ly=layers[j];if(ly.mat==='VOID')continue;const rj=rates[ly.mat];if(!(rj>RESIST_R))continue;
    const[lo,hi]=nzRange(ly.h);
    for(let b=Math.max(1,lo);b<Math.min(NP-1,hi);b++){if(!(ly.h[b]>E))continue;
      for(const dir of[1,-1]){const o=b-dir;if(o<=0||o>=NP-1||ly.h[o]>E)continue;   // 도메인 끝 제외
        if(isPat(pts[b]))continue;                                                  // 셀 hole 측벽 제외
        const{B,cov}=openBudget(j,o),w=wf(pts[o]),Blat=Math.max(0,D*w-B),L=kap*rj*Blat;
        const e=(arc[b]+arc[o])/2;
        // 구간 길이 (dir 방향으로 h>E 연속)
        let q=b;while(q+dir>=0&&q+dir<NP&&ly.h[q+dir]>E)q+=dir;const run=Math.abs(arc[q]-e);
        const top=aboveAt(j,b);   // 처마: j 위 첫 non-VOID 막 인덱스(h>E) 또는 -1
        const he=top>=0?layers[top].h[b]-kap*(rates[layers[top].mat]??0)*Blat:null;
        res.ends.push({j,mat:ly.mat,b,o,dir,e,L,Blat,B,D:D*w,cov,run,released:L>=run,eave:top,heEff:he,hj:ly.h[b]});}}}
  return res;}
const aboveAt=(j,i)=>{for(let k=j+1;k<layers.length;k++){const l=layers[k];if(l.mat!=='VOID'&&l.h[i]>LAT_DEF.EPS)return k;}return -1;};

// 격자 VOID 변환 + 처마 박막화. 같은 j는 VOID 막 하나로 모음. 뒤 인덱스부터 끼워 넣어 앞 인덱스가 밀리지 않게 함
function applyVoids(res,rates){
  const byJ=new Map();
  for(const e of res.ends){if(!(e.L>0))continue;
    for(let i=e.b;i>=0&&i<NP;i+=e.dir){const s=Math.abs(arc[i]-e.e);if(s>e.L)break;const ly=layers[e.j],v=ly.h[i];if(!(v>0))break;
      const tau=e.Blat-s/(LAT_DEF.kappa.wet*rates[ly.mat]);   // 측면 전선이 점 i를 지난 뒤 남은 budget
      ly.h[i]=0;let vh=byJ.get(e.j);if(!vh){vh=new Float64Array(NP);byJ.set(e.j,vh);}vh[i]+=v;
      thinNeighbors(e.j,i,Math.max(0,tau),rates);}}   // 위아래 인접 막(h>0, non-VOID)을 r·tau만큼
  [...byJ.keys()].sort((a,b)=>b-a).forEach(j=>insertLayerAt(j+1,'VOID',byJ.get(j),layers[j].thin));
  recalc();}

// 지표 (§4)
function lateralMetrics(res,tgt){
  const T=res.ends.filter(e=>e.mat===tgt),act=T.filter(e=>e.L>LAT_DEF.minUm);
  const ar=act.filter(e=>e.eave>=0).map(e=>e.heEff>0?e.L/e.heEff:Infinity);
  const prot=T.filter(e=>e.L<=0&&e.B>=e.D&&e.D>0),margin=prot.length?Math.min(...prot.map(e=>1-e.D/e.B)):null;
  return{Lmax:act.length?Math.max(...act.map(e=>e.L)):0,n:act.length,ARmax:ar.length?Math.max(...ar):0,
    gone:act.some(e=>e.eave>=0&&!(e.heEff>0)),released:act.some(e=>e.released),
    nProt:prot.length,margin,exhausted:act.filter(e=>e.cov).length,diff:act.some(e=>e.L/Math.max(e.hj,1e-6)>LAT_DEF.diffAR),
    byMat:Object.fromEntries([...new Set(res.ends.map(e=>e.mat))].map(m=>[m,Math.max(0,...res.ends.filter(e=>e.mat===m).map(e=>e.L))]))};}
```

**applyStep clean 분기 연결 (요지)**
```js
else if(st.type==='clean'){ …기존 wf 결정…
  const pre=LAT_DEF.kappa[c.cat]>0?layers.map(l=>packH(l.h)):null;
  noData=clean(c.r,st.amt/1000,wf);
  if(pre){const lat=lateralWet(c,c.r,st.amt/1000,wf,pre);
    if(lat){lat.noData.forEach(m=>noData.add(m));applyVoids(lat,c.r);if(R)R.lat=lateralMetrics(lat,c.tgt);}}}
// 칩: R.lat → latChips(R.lat) (§4 표). cut(edgeCutOf)이 있으면 wet/gas일 때 cut.kLat=0 (중복 방지)
```
- 데이터 없음 처리: 덮는 막의 rate가 없으면 보호(∞)로 보고 `noData`에 넣는다 → 기존 ⚠ 문구 경로를 그대로 탄다.
- 입력 검증: `D`가 유한하고 0 이상이 아니면 throw. `rates[ly.mat]`가 NaN이면 rt()가 이미 막는다. `insertLayerAt`의 idx 범위를 검사한다.
- `consume`, `cmpRun`, `removal`, `stripTopDown`, `edgeMetrics`(끝단 목록), `groupPresence`에서 VOID를 건너뛴다(§3.1).

---

## 7. 테스트 기준

공통: Mold 기본 Ox 90 / Nit 60 nm. 허용오차는 L ±1e-6 µm(해석식). 격자 VOID 테스트는 점 개수 ±1. "PES 2.5" = remove strip distMm 2.5(process 모델).

| # | 레시피 | 기대 |
|---|---|---|
| T1 노출 끝단 기본식 | 전면 SiN 0.06µm → EEW 2mm → `USN amt 400nm` | o에서 j 위 막 없음, h_j^pre[o]=0 → B_open=0 → **L_SiN = 1·1·0.400 = 0.400 µm**. 칩 측면 recess 0.40µm, 처마 없음(위 막 없음) |
| T2 시간 입력 | T1에서 `USN 20min` | amt = 1200 s × 20/60 nm/s = 400 → T1과 같음 |
| T3 SiON 보호 | SiN 60nm → EEW 2mm → SiON 0.05µm 전면(덮음) → `USN 20min` | r_SiON = 0.9/20 = 0.045 → B_open = 0.05/0.045 = 1.111 > 0.4 → **L=0**, 칩 "보호됨 · 여유 64 %" |
| T4 보호막 소진 | T3 구조 → `ENLARGE H3PO4 30min` (amt 600) | r_SiON = 2/20 = 0.1 → B_open 0.5 → **L = 0.100 µm**, 칩 "보호막 소진" lvl≥1 |
| T5 Oxide cap | SiN → EEW → SiO2 0.05µm → H3PO4 30min | B_open = 0.05/(0.21/20) = 4.76 → L=0 (보호) |
| T6 oxide 측면 | 전면 SiO2 0.09µm → EEW → USN 400nm | L_ox = 0.4·0.002 = **0.0008 µm** (칩 하한 미만 → 칩 없음) |
| T7 Mold 처마 | Mold 48쌍 → PES 2.5 → USN 20min | SiN 끝단 48개. 테라스 점이 격자에 있으면 B_open=0.06, 없으면 0 → L ∈ [0.34, 0.40] µm. 처마 oxide 90nm − 0.002·B ≈ 89.9 nm → AR 3.8~4.4 → **lvl1**, n=48 |
| T8 Mold 장시간 | T7에서 H3PO4 60min (amt 1200) | L ≈ 1.14~1.20 µm, 처마 90nm − 아랫면 0.0105·1.14µm(12nm) − 윗면(테라스 노출 시) 12.6nm ≈ 65~78 nm → AR ≈ 15~18 → **lvl2** |
| T9 DSP | W 0.1µm 전면 → EEW 2mm → `DSP 5min` (amt 30) | L_W = 0.030 µm. W 위에 SiO2 20nm를 덮으면 r_SiO2=0 → ∞ → L=0 (보호) |
| T10 격자 VOID | T1에서 `USN 30um` (amt 30000, 범위 안이면) | L=30 µm → 끝단 격자(10 µm)에서 VOID 점 3개(±1). VOID 막 1개가 j+1 위치에 생기고, LV는 단계 전후 그 점들에서 같다(처마 높이 유지) |
| T11 VOID 소모 | T10 뒤 `PES 3mm` 또는 `BOE` | 처마가 지워진 점에서 VOID가 budget 0으로 사라짐. noData 경고 없음 |
| T12 데이터 없음 cap | SiN 끝단 위 Cu 덮음 → USN | Cu rate 없음 → 보호(∞) + ⚠ 데이터 없음(Cu) |
| T13 회귀 | VOID·usn·dsp가 없는 기존 기본 레시피(L1340, L2588 부근) | 막 두께 결과 동일. 칩 증가는 L ≥ 0.01 µm인 wet 단계에서만 |
| T14 plasma 제외 | cf4 edge clean | lateralWet null, 기존 edgeMetrics undercut 칩 유지 |
| T15 파서 | 'WET ETCH SIN USN 1um' → clean usn (건식 nit 아님). 'DSP+ HF 5min' → dsp + warn (dhf 아님). 'ENLARGE 20min' → usn + note | |

---

## 8. 신뢰도·공백

| 값 | 신뢰도 | 이유 |
|---|---|---|
| hotp er | 상 (SiO2 대용 중) | W03 표 직접 확인, YMTC 교차 |
| usn SiN 20 | 하~중 | 첨가제 영향 0 가정, 3D NAND 특허 문맥 3.5~6.5와 3배 차이 |
| usn 선택비 500 | 하 (est) | 문헌 범위의 중간값, 실측 표 미확인(Entegris 실시예 표, Chung-Ang 본문) |
| usn SiON 0.9, hotp SiON 2 | 하 (est) | 기하평균 규칙. **보호 판정이 이 값에 크게 좌우됨** |
| dsp W·TiN 6 | 하 (est) | 특허 청구 범위 1~40의 중앙값, DSP 조성 실측 없음 |
| spm TiN 14 | 중 | Intel 실시예(진한 SPM 100 ℃)를 spm 키에 대응 |
| 측면 모델 구조(B_open, L=κ·r·B) | 중 | 등방 wet의 기본 물리, consume과 같은 budget 단위 |
| κ=1, 전달 제한·regrowth 무시 | 하 | 정량 문헌 없음 (L 과대 쪽 오차) |
| AR 임계 3/10 | 하 (est) | 붕괴·박리 정량 사례 없음 |

**공백**: 'USN' 명칭과 제품 수치, 고선택 인산의 SiN/SiO2/**SiON** 절대 식각률(maker datasheet), 측면 recess 깊이·속도 실측(좁은 틈 전달 제한), oxide 처마 붕괴·박리 임계 정량값, DSP·DSP+의 W/TiN/oxide 식각률, W03 Table VI TiN 열(H2O2·Piranha·HF·O2 등), Edge undercut 정량 사례.

**researcher 추가 검색어**
1. `"silicon oxynitride" etch rate "phosphoric acid" 160 nm/min` / `SiON wet etch rate hot phosphoric refractive index`
2. `US 11421157 example table silicon nitride etch rate silicon oxide angstrom` (Entegris 실시예 표, offset 100000 이후)
3. `Seo 2014 Microelectronic Engineering 118 66 selective wet etching Si3N4 SiO2 fluoride silicic` (본문 표)
4. `Kim 2020 Microelectronic Engineering 221 111191 oxide regrowth nitride lateral etch depth`
5. `3D NAND "nitride recess" OR "nitride pull back" lateral etch rate slit depth time phosphoric`
6. `"oxide fin" OR "oxide overhang" collapse aspect ratio wet drying stiction nitride removal 3D NAND`
7. `diluted sulfuric peroxide tungsten etch rate nm/min TiN room temperature` / `DSP+ cleaning tungsten titanium nitride etch rate`
8. `Williams 2003 Table VI TiN sputtered etch rate H2O2 piranha` (기존 로컬 PDF에서 TiN 열 추출)
