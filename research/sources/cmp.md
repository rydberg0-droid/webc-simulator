# CMP(화학기계연마) 공개 문헌 수치 — 조사일 2026-10-08

우선순위: Oxide CMP, W CMP 최우선 → Cu / Poly / STI-ceria 다음. 수치는 원문 그대로이며 환산·보간은 하지 않았다. 원문 PDF/텍스트는 `research/_tmp/cmp/`에 있다.
"원문 확인"은 PDF 또는 특허 전문을 직접 읽었다는 뜻이다. "검색 요약만"은 검색 결과 발췌만 보았다는 뜻이며 원문 대조가 필요하다.

---
# A. Oxide CMP (ILD/PMD)

## A-1. D. Ouma, B. Stine, R. Divecha, D. Boning, J. Chung, G. Shinn, I. Ali, J. Clark, "Wafer-Scale Modeling of Pattern Effect in Oxide Chemical Mechanical Polishing", SPIE Microelectronic Device Technology Session / Microelectronics Manufacturing Conf., Austin TX, Oct. 1997 (MIT MTL + TI) — https://boning.mit.edu/wp-content/uploads/2022/11/SPIE97.pdf (원문 확인)
- 조건: 6" 웨이퍼. 1000 nm LPCVD TEOS 증착, 금속 패턴·식각 후 2000 nm TEOS 증착. Rodel K-Grooved IC 1400 pad, Cabot SS 25 slurry, carrier 20 rpm, back pressure 2 psi, Strasbaugh 6DS-SP 연마기. 2차 실험은 IPEC/Planar 472, table 32 rpm, carrier 28 rpm, 패드 IC 1000/Suba IV perforated 및 IC 1400 K-Grooved.
- 모델(원문 식 3, 4): z = z0 − Kt/ρ0(x,y) (Kt/ρ0 < z1일 때), z = z0 − z1 − Kt + ρ0 z1 (Kt/ρ0 > z1일 때). K = 비패턴 연마속도, ρ0 = 국부 패턴밀도, z1 = 초기 step height. 국부 압력은 패턴밀도에 반비례한다고 서술한다(Preston 식 인용).
- Mask 구성: Mask I 블록 20–3000 µm, Mask II pitch 2–1000 µm(밀도 50%), Mask III 밀도 4–100% (4% 간격, pitch 250 µm, 2 mm x 2 mm 블록), Mask IV perimeter/area.
- 원문 "planarization length of the pads was as small as 3 mm"; 이 모델은 down feature가 planarization length의 15%(500 µm)까지 유효하다고 서술한다. STI에는 수정이 필요하다고 한다.

| 공정(Table 1) | Down force (psi) | Table speed (rpm) | Time (s) | Table 2: Center die K (nm/min) | Edge die K (nm/min) | Planarization(Polish) Length (mm) |
|---|---|---|---|---|---|---|
| A(L,L) | 4.0 | 20 | 470 | 79.6 | 83.8 | 3.08 |
| B(H,H) | 8.0 | 50 | 112 | 390.3 | 446.3 | 2.73 |
| C(L,H) | 4.0 | 50 | 242 | 205.3 | 210.2 | 3.30 |
| D(H,L) | 8.0 | 20 | 228 | 201.3 | 221.3 | 2.75 |
| E(C,C) | 6.0 | 35 | 200 | 225.5 | 250.8 | 2.78 |

| 패드(Table 3) | 8 psi | 6 psi | 비고 |
|---|---|---|---|
| IC 1000/Suba IV | 3.00 mm | 2.72 mm | 6 psi 시료는 국부 평탄화가 전 웨이퍼에서 완료되지 않아 비정상이라고 원문이 설명 |
| IC 1400 | 2.80 mm | 2.66 mm | 〃 |

- 웨이퍼 edge 관련: "high down force results in higher wafer level variation as the edge polishes faster than the center" (원문 8절). Process B 진단 스캔(Fig.10) 축 범위는 350~500 nm/min이다. Fig.6 같은 공정 B에서 edge die 두께 min 6109 Å, max 10532 Å, range 4422 Å; center die min 5385 Å, max 9373 Å, range 3988 Å(그림 라벨 순서는 left/right 라벨 기준이며 어느 쪽이 edge인지는 캡션 "edge (left) and center (right)" 그대로).
- 원문: "the range of variation in the center die is approximately 10% larger than the range in variation for the edge die" (4절) — 위 그림 라벨 수치와 순서가 서로 맞는지는 원문 재확인 필요(둘 다 그대로 적음).
- 공정별 중심 대비 edge die K는 Table 2 값 그대로다.

## A-2. D. Boning, B. Lee, C. Oji, D. Ouma, T. Park, T. Smith, T. Tugbawa, "Pattern Dependent Modeling for CMP Optimization and Control", MRS Spring Meeting Symp. P, San Francisco, Apr. 1999 — https://boning.mit.edu/wp-content/uploads/2022/11/MRS99-reprint.pdf (원문 확인, 수치 적음)
- 원문: 효과적 밀도(effective density)는 planarization length(가중 윈도 크기)로 계산한다. oxide planarization 실험에 대해 상향 단차/하향 영역 모델 적합 시 "root mean square errors below 300 Å" 수준이라고 서술.
- STI 관심사: over-polish에 의한 oxide dishing, 지지 nitride erosion, corner rounding. Cu: dishing과 oxide erosion. (Fig.1 개념도)

## A-3. B. Lee, D. S. Boning, L. Economikos, "A Fixed Abrasive CMP Model", Proc. CMP-MIC, pp. 395-402, Santa Clara, Mar. 2001 — https://mtlsites.mit.edu/researchgroups/Metrology/PAPERS/CMPMIC01-Lee-paper.pdf (원문 확인)
- 모델 방정식: 단차 H는 접촉높이 hc 이하에서 H = hc·exp(−(t−tc)/τox), τox = hc/K1, tc = (z1−hc)/K1 (원문 식 5). Up/down 면 연마속도는 H에 선형(Phase 2): RRup = (K1−K2)H/hc + K2, RRdown = −(K2/hc)·H + K2 (원문 식 4a,b). Phase 1(패드가 down 영역에 닿기 전): RRup = K1, RRdown = 0.
- 고전식: K1 = K/ρ (pure inverse density). 제안식: K1 = Kρ(1−ρ)/ρ + Kc. 원문 Fig.4: 순수 역밀도는 K = 500 Å/min, RMS error 1800 Å/min; 제안식은 Kρ = 1100 Å/min, Kc = 30 Å/min, RMS error 860 Å/min.
- 실험: STI 웨이퍼, trench 3100 Å, pad oxide 60 Å, nitride 1100 Å, HDP SiO2 4300 Å(trench 내), 실제 oxide step height 3600 Å(profilometry). Obsidian Flatland 501, 3M fixed abrasive ceria pad (SWR 159 std), pH 11.5, 20–210 s(8장). 모델 파라미터: contact height 1000 Å, K2 = 30 Å(단위 원문 표기 그대로 "Å"; Fig.4 쪽은 Å/min). 50%·80% 밀도의 down 영역은 연마량이 뚜렷하지 않았고 10% 영역만 down 연마가 관찰됨.
- 주의: fixed abrasive(고정연마재) 슬러리 프리 공정 결과이며 일반 slurry 공정과 다르다.

## A-4. 검색 요약만 (원문 미확인)
- Boning 그룹 발표 요약(검색 발췌): "Soft" pad planarization length ~3-4 mm, "Stiff" pad ~7-10 mm (nanotopography 맥락). 단차 감소는 밀도 효과 우세 시 시간에 선형, up/down 압력차 우세 시 시간에 지수적. 통합 모델 오차 273 Å rms(밀도 모델) → 98 Å RMSE(통합 모델). 출처 URL 후보: https://mtlsites.mit.edu/researchgroups/Metrology/PAPERS/SemiconWest2001.pdf (내려받아 `_tmp/cmp/sw2001.pdf` 저장, 위 수치는 아직 본문에서 대조하지 못함).
- 구리 CMP 상호작용 거리 50–100 µm, oxide 3–5 mm (Boning 그룹 논문, 검색 발췌만).

---
# B. W CMP

## B-1. K. Hosokawa, S. Yoshida, Y. Ota (Nitta Haas), "The Oxidant Impact for Tungsten Polishing" (2014 Technology 자료) — https://www.nittadupont.co.jp/wp-content/uploads/2014/12/2014_Technology_2.pdf (원문 확인)
- 조건: Nitta Haas IC1000 circular groove pad, KINIC diamond disk, EBARA EPO222(200 mm), down force 4 psi, head/platen 100/103 rpm, slurry 150 ml/min. Slurry pH 2.0, fumed silica 2.5 wt%. 패턴 TEG: W/Ti/TiN/TEOS = 4000/130/320/4000 (원문 단위 표기 그대로, Å 추정). 평가 영역은 1.0 µm via plug 20% array(AFM). 연마 단계: W cleared / Ti/TiN cleared(Just) / over polish 15 s(약 15%) / over polish 30 s(약 35%).
- 원문 텍스트 수치:

| 항목 | 값 | 원문 위치 | 비고 |
|---|---|---|---|
| H2O2+촉매계 vs iodic oxidant A, W cleared 시점 recess | H2O2계가 100 nm 더 깊음 | III.B | |
| Ti/TiN cleared 시점 H2O2+촉매(+inhibitor) recess | 80 nm 잔존 | III.B | over-polish 증가 시 감소 경향 |
| iodic oxidant A: W cleared→barrier cleared recess 감소 | 50 nm (barrier 약 50 nm 제거 동안 plug 비식각) | III.C | |
| iodic A: barrier clear 후 step height | 약 10 nm 잔존, over-polish 시간에 따라 일정 | III.B/C | |
| W static etch rate (50℃) | 그림(Fig.1)에 H2O2계 최대 축 900 Å/min 범위, iodic A 최저 | Fig.1 | 정확한 막대값은 텍스트 없음 |
| W/TEOS 블랭킷 RR | Fig.3 막대그래프(축 0–4000 Å/min). 텍스트: iodic A,B는 H2O2+촉매계와 "comparative W removal rate and W/TEOS selectivity" | Fig.3 | 수치 라벨 없음 |

- Fig.4 recess vs over-polish(1 µm plug, 20% array)는 그래프이며 수치 라벨 없음.

## B-2. Air Products (R. D. McConnell, A. M. Hurst), US 8,790,521 B2 "Combination, method, and composition for CMP of a tungsten-containing substrate" — https://patents.google.com/patent/US8790521B2/en (특허 전문 확인)
- 조건(예 1–12): colloidal silica + periodic acid(PIA), down force 4.0 psi, slurry 150 cc/min, table 120 rpm, 60 s. 일반 baseline: head 123 rpm, 4.0 psi membrane, 5.0 psi inter-tube, 6.5 psi retaining ring. "Higher removal rates are attained when down force values greater than 4 psi are used."

| 예 | silica wt% | PIA wt% | pH(전→후) | W RR | TEOS RR | W:TEOS |
|---|---|---|---|---|---|---|
| 1 | 13 | 0.5 | 2.99→1.92 | 1114 | 2081 | 0.54 |
| 3 | 5 | 0.5 | 3.38→1.97 | 883 | 1274 | 0.69 |
| 5 | 13 | 1.25 | 2.93→1.73 | 1692 | 2162 | 0.78 |
| 8 | 13 | 2 | 2.87→1.58 | 2115 | 2174 | 0.97 |
| 10 | 9 | 2 | 3.07→1.63 | 1861 | 1718 | 1.08 |
| 12 | 5 | 2 | 3.31→1.60 | 1712 | 1321 | 1.30 |
| 14 (amino alcohol 0) | 9 | 1.25 | 3.04→1.59 | 1587 | 1714 | 0.93 |
| 15 (2-(2-aminoethoxy)ethanol 0.582 wt%) | 9 | 1.25 | 10.45→3.48 | 2120 | 1601 | 1.32 |

- 단위: RR은 Å/min(원문). 나머지 예(2, 4, 6, 7, 9, 11)는 원문 표에 있으나 위에서 생략했다.
- 예 13(silica 10 wt%, PIA 1.11 wt%): 패턴 웨이퍼 erosion을 over-polish 15%, 30%, 60%에서 측정. 2x3 array center die 값 47, 57, 75(단위·조건은 원문 표에 명시 없음, 검색 도구 요약 기준 — 원문 재대조 필요).
- 주의: 이 특허의 W:TEOS는 0.5~1.3으로 낮은 선택비(저선택 슬러리)다. 고선택 W 슬러리(W:oxide 수십 이상)와 다른 계열이다.

## B-3. 검색 요약만 (W, 원문 미확인)
- W 슬러리 특허 예: down force 6 psi, table 110 rpm, carrier 95 rpm, 150 ml/min에서 W RR 7860 Å/min, TEOS RR 801 Å/min, W:TEOS 약 10 (특허 번호 확인 필요, 검색 결과 발췌).
- Iodic acid 첨가 W RR: 0% 일 때 1000~1200 Å/min, 1.5% 일 때 약 1600 Å/min, 3% 일 때 2000 Å/min 초과(출처 미확인).
- W:ILD 선택비 50~150 이면 plug recess 과다·표면 거칠기(특허 발췌). W:Ti 약 10:1(Ti/TiN을 stop으로 사용) 특허 발췌. 별도 특허는 W:TiN 약 1:1.5~2, W:oxide 2:1 이상 목표. 두 값 상충하며 번호 미확인.
- Edge-over-erosion (EOE) in tungsten CMP (검색 발췌): 좁은 line에서 약 30 nm, 넓은 line array에서 약 50 nm, 0.18 µm line array 50% 밀도에서 lateral EOE 약 100 µm (ResearchGate 403으로 원문 열람 불가).
- 패턴밀도 경향(특허 서술): 고밀도 영역은 erosion, 저밀도 영역은 dishing. over-polish가 둘 다 악화. W plug는 크기가 작아 intra-die topography 영향이 작다고 서술하는 선행기술 있음.

## B-4. W 웨이퍼 edge/bevel 잔막
- Applied Materials, R. T. Lum 등, US 6,468,136 "Tungsten CMP with improved alignment mark integrity, reduced edge residue, and reduced retainer ring notching" (특허 전문 확인): retaining ring 경도 "greater than about 85 durometer", 연마 패드 경도 "less than about 60 durometer"(바람직 50 미만, 청구항 40 미만), ring 마모 "less than about 1 mil per hour"(예 0.5 미만), W RR "at least 3000 Å/min"(청구항 4000 Å/min 이상). edge 잔막 폭(mm), 두께는 원문에 없음.
- TSMC, S.-M. Jang 등, US 6,121,111 "Method of removing tungsten near the wafer edge after CMP" (특허 확인): W 잔막이 bevel edge에 남아 peeling→오염 원인. 건식 식각 SF6/Cl2/N2(W), BCl3/Cl2/N2(TiN, AlCu). 수치(폭, 시간)는 없음.
- US 6,881,675 "reducing wafer edge tungsten residue utilizing a spin etch" (제목만 확인, 수치 미확인).

---
# C. Wafer edge: edge roll-off, retaining ring (Oxide/W 공통)

## C-1. A. Fukuda, H. Hiyama, K. Hirokawa, M. Tsujimura, T. Fukuda (Ebara), "The Impact of Wafer Edge Roll-Off on CMP Performance", Trans. JSME Ser. C 72(719), 2006, pp. 2330-2335 — https://www.jstage.jst.go.jp/article/kikaic1979/72/719/72_719_2330/_article (abstract 확인)
| 항목 | 값 | 단위 | 비고 |
|---|---|---|---|
| 영향 범위(edge로부터) | 4 (stacked pad), 10 (solo pad) | mm | FEM 압력 분포 기반 |
| ROA 1.27 µm에서 edge 근처 표면압/중심 | 약 30 (stacked), 약 23 (solo) | % | |
| retainer ring pressure | 23 kPa → 30 kPa | kPa | stacked pad는 ring 압력으로 edge 효과 상쇄 가능, 허용 ROA 범위 비균일 |
| solo pad 허용 ROA | 약 0 ~ 0.4 | µm | ring 압력과 무관 |

## C-2. X. Xie, D. Boning, "CMP at the Wafer Edge – Modeling the Interaction between Wafer Edge Geometry and Polish Performance", MRS Proc. (abstract 확인)
- 산업 목표 edge exclusion 2 mm 이하. 시뮬레이션: edge 안쪽 수 mm 구간이 wafer/ring 압력, wafer-ring gap, pad Young's modulus에 따라 중심보다 빠르게도 느리게도 연마됨(원문 표현 "several millimeters"). 출발 웨이퍼 edge roll-off 형상이 균일도에 큰 영향. 수치 프로파일은 abstract에 없음. URL: https://resolve.cambridge.org/core/journals/mrs-online-proceedings-library-archive/article/abs/cmp-at-the-wafer-edge-modeling-the-interaction-between-wafer-edge-geometry-and-polish-performance/42979413B3289409FD2BD54EE1C19557

## C-3. Yun-Biao Xin, "Modeling of Pad-Wafer Contact Pressure Distribution in CMP" (저널·연도 불명, 사이트 확인) — https://www.sensorprod.com/research-articles/modeling-of-pad-wafer-contact-pressure-distribution-in-chemical-mechanical-polishing/
- 모델 인가압력 5 psi, 실험 3 psi(soft rubber pad vs Rodel H-2 hard pad), stacked pad(IC1000/Suba IV). 정량 edge 비율, 거리 mm, ring 압력 수치는 없음. "retainer ring pressure should be slightly higher than the surface pressure"로 서술.

## C-4. Lam Research (A. Owczarz, J. Boyd, R. Kistler), US 6,776,695 / US 6,913,521 (특허 확인)
- 정량 edge zone 수치 없음. 원문: 플래튼 retaining ring 폭 약 1.0 inch(0.5~2 inch), 높이 약 0.8 inch(0.5~1 inch). 도면에서 edge 제거속도 "extremely high relative to other positions"로만 서술.
- 검색 요약만(원문 미확인): "within about 4 mm 평균보다 높은 제거, 3~20 mm 사이 낮은 제거 구간", 다중 구역 carrier는 3~20 mm 제어, 단일 구역 carrier 영향 5~7 mm. 링 마모로 edge 정규화 RR 약 6% 상승(신/구 링, 특허 발췌). 출처 번호 미확정.

---
# D. STI ceria slurry

## D-1. R. Srinivasan, S. V. Babu, W. G. America, Y.-S. Her, US 7,091,164 B2 "Slurry for chemical mechanical polishing silicon dioxide" (Clarkson Univ., Eastman Kodak, Ferro; 우선일 1999-12-08) — https://patents.google.com/patent/US7091164B2/en (특허 전문 확인)
- 조건(Table 1, ceria 5 wt%, pH 10): 5.6 psi, table 30 rpm, quill 30 rpm, 25 ℃, 240 cc/min. 단위 nm/min.

| 첨가제 | Oxide | Nitride | 선택비 |
|---|---|---|---|
| 없음 | 489 | 66 | <8 |
| 1% glycine | 547 | 34 | 16 |
| 1% L-alanine | 545 | 20 | 27 |
| 1% L-proline | 487 | 12 | 41 |
| 4% L-proline | 430 | 2 | 230 |

- Table 2(titania 5 wt%, pH 10, 5.6 psi, 40/40 rpm, 25 ℃, 240 cc/min): 첨가제 없음 oxide 57, nitride 36, 선택비 <2. 4% L-proline oxide 73, nitride 1, 선택비 73.
- Fig 3-4 고선택 슬러리: 1 wt% ceria + 2 wt% L-proline, 6 psi, back 2 psi, 40/40 rpm, 20 ℃, 340 cc/min. 수치 라벨 없음. 특허 서술: pH 6~11 범위에서 고선택비.

## D-2. 검색 요약만
- 낮은 pH(<5)에서는 oxide RR 감소(ceria 슬러리 서술), nitride 등전점 부근에서 nitride RR 급감(선택비 약 50배 개선, 출처 미확인).

---
# E. Cu / barrier

## E-1. (공개 저장소에서 제외) Rodel 2002 CMPUG 슬라이드 — 원문에 "CONFIDENTIAL" 표기가 있어 수치·인용을 싣지 않음. 시뮬레이터에도 사용하지 않음.

## E-2. K. Yang, S. Avanzino, C. M. Woo, US 6,332,989 B1 (AMD; 현 GlobalFoundries 표시) "Slurry for chemical mechanical polishing of copper" (특허 확인)
- 조건 예: 2 psi, table 150 rpm → Cu RR 약 6,000 Å/min, Cu etching 없음, barrier erosion 약 200 Å, 10 µm Cu line dishing 약 400 Å. 조성 Al2O3 0.2~0.7 wt%, oxalic acid 0.3~1 wt%. Cu static etch < 5 Å/min, Cu RR 최대 약 10,000 Å/min, Ta/TaN 선택비 최대 약 500. 압력 1~4 psi, 패드 30~150 rpm. pH, oxide RR은 없음.

---
# F. Poly slurry

## F-1. Y.-R. Park 등 (Samsung), US 7,196,010 "Slurry for CMP process and method of manufacturing semiconductor device using the same" (특허 확인; 1차 읽기 100,000자까지)
- 조건: Cabot SS25 oxide slurry 기반, silica 약 5~12.5 wt%, 첨가제 0.001~5 wt%, 압력 2~5 psi, 바람직 pH 약 7~11. 속도(rpm) 없음. 단위 Å/min.

| 첨가제 | wt% | Oxide | Poly-Si | 선택비 oxide:poly |
|---|---|---|---|---|
| PVME | 0 | 2677 | 3972 | 0.7 |
| PVME | 0.01 | 2556 | 408 | 6.3 |
| PVME | 0.1 | 2030 | 278 | 7.3 |
| PVME | 1 | 1926 | 248 | 7.8 |
| PEG | 0.1 | 2336 | 683 | 3.4 |
| PEGBE | 1 | 2389 | 776 | 3.1 |
| POLE(Brij35) | 0.1 | 2520 | 633 | 4.0 |

- 1 wt% PVME 3번째 실시예(Å/min): poly-Si 약 210, unannealed BPSG 약 8786 (42:1), annealed BPSG 약 5374 (27:1), PETEOS 약 1250 (6:1), annealed poly-Si 약 480. pH 8에서 25:1 선택비(1 wt% PVME + H2SO4). 나머지 PEG 0.01·1 wt%, PEGBE 0.01·0.1 wt%, POLE 0.01·0.5 wt% 행은 원문에 있으나 생략.
- 반대 방향(poly:oxide 선택) 고선택 poly 슬러리는 검색 발췌만: 목표 poly RR 100 nm/min 이상(150, 200 바람직), poly:SiO2 30 이상(50 바람직) (US 7,723,234, 원문 미확인).

---
## 못 찾은 것
- Oxide: edge roll-off의 edge-fast/slow 폭·깊이를 mm/nm로 직접 보고한 공개 수치(두께 프로파일). Xie/Boning MRS 본문, Ebara 본문은 열람 못했고 abstract만 확보. 시도: "oxide CMP edge roll-off profile nm within 3 mm", "CMP at the wafer edge".
- Oxide: 단차(step height) 감소 곡선의 시간별 Å 값(블랭킷 oxide slurry와 일반 패드 기준). Lee 2001(fixed abrasive STI) 외에는 없음. SemiconWest2001/VMIC2001 PDF는 받았으나 수치 대조 미완.
- Oxide: SiN stop 시 STI dishing의 over-polish 시간 대비 Å 값, nitride loss Å 값. MRS "Dishing model for STI CMP", "STI test mask with realistic geometric shapes" 초록만 검색됨.
- W: W:oxide 및 W:Ti/TiN 선택비를 같은 조건에서 보고한 peer-review 표(Å/min). W plug recess/erosion의 패턴밀도·over-polish 정량 표. Nitta 자료의 Fig.1, 3, 4는 막대/선 그래프이며 수치 라벨이 없다.
- W: bevel/edge W 잔막의 폭(mm), 두께, peeling 발생률. 특허는 정성 서술만 있고 수치 없음.
- 공통: edge 0~5 mm 구간 두께 변화 정량 대표값(nm). Ebara 값(영향 범위 4/10 mm, 압력비 30%/23%)이 유일.
- Cu: Cu:Ta:TaN:oxide를 같은 조건에서 보고한 표, pH. Poly: carbon/SOH CMP 속도(검색 시도 안 함 또는 결과 없음).
- 검색어 후보: "tungsten CMP erosion recess over-polish dense plug array nm", "Tugbawa CMPMIC 2001 dishing erosion model", "oxide ILD CMP edge exclusion thickness profile 3 mm retaining ring pressure nm", "ceria slurry STI Å/min HDP nitride selectivity psi pH JES".

## 요약
- 찾은 것: Oxide CMP는 MIT/TI Ouma 1997 원문에서 K(79.6~446.3 nm/min), planarization length 2.66~3.30 mm, edge die가 center보다 K 큼, Stine 식, Lee 2001의 step height 지수 감소식과 파라미터를 확보했다. W CMP는 Air Products 특허의 W/TEOS RR 표(W 883~2120, TEOS 1274~2174 Å/min, 4 psi)와 Nitta의 recess 값(H2O2계 80 nm vs iodic 약 10 nm), ceria STI(oxide 430~547, nitride 2~66 nm/min), poly(oxide:poly 0.7~7.8), Cu(AMD 특허 Cu RR·dishing)를 확보했다.
- 신뢰도: Ouma 1997, Lee 2001, Nitta, 특허 표는 원문 직접 확인으로 높음. 단 특허·maker 자료는 단일 연구실·단일 조건이라 일반화 불가. "검색 요약만" 표시 항목(planarization length 3-4/7-10 mm, EOE 30/50 nm, W:Ti 10:1 등)과 예 13 erosion 단위는 원문 대조 전까지 낮음.
- 공백: edge 0~5 mm 두께 프로파일 정량(nm), W bevel 잔막 수치, STI/SiN stop dishing의 over-polish 정량, W:oxide·W:Ti/TiN 선택비의 동일 조건 peer-review 표.
