# Wafer edge 막 끝단(film edge) 단면 프로파일 — 조사일 2026-10-08

범례: 모든 출처는 WebFetch(요약 모델 경유)로 본문 발췌를 확인했다. PDF 원문 대조·이미지 렌더는 하지 않았다("본문 발췌 확인"). 따옴표 안은 영어 원문 그대로, 숫자·단위 환산 없음. 상호 간 환산·추정 없음.

## 출처 1: J. Chen, Y. Kim (Lam Research), "Method and apparatus for processing bevel edge", US 8,562,750 B2 (출원 2009-12-17, 등록 2013-10-22) — https://patents.google.com/patent/US8562750
- 조건: confined plasma bevel etcher. 가스 분배판-기판 gap 140. 보호(passivation) 폴리머를 bevel에 증착 후 패터닝 → oxide 식각. 폴리머 증착: C2H4 120 sccm + N2 120 sccm, 4 Torr, RF 400 W. 패터닝 가스 O2.
| 항목(원문 표기) | 값 | 단위 | 원문 위치 | 비고 |
|---|---|---|---|---|
| 기존 confined plasma bevel clean의 transition(full thickness→complete removal) distance | "of the order of 0.5 mm" | mm | 배경/본문 | 기준(종래) 공정 |
| passivation 패턴 마스크 + 고선택비 공정 후 transition distance | "of the order of less than 0.05 mm (the threshold of thin film metrology resolution)" | mm | 본문 | 측정 분해능 한계 |
| dielectric 식각 후 transition (비교 실시) | "relatively longer ... on the order of 1 mm" | mm | 본문 | 조건 차이는 원문 참조 |
| dielectric 식각 후 transition (다른 실시) | "shorter ... on the order of 0.1 mm or less is measured" | mm | 본문 | |
| 패턴된 oxide 층 프로파일 서술 | "very steep etch profile" | - | FIG. 7 부근 | 각도 수치 없음 |
| gap | 0.3 mm ~ few mm; 0.60–0.90 mm (바람직 약 0.65); 0.30 mm; 0.35 mm | mm | 본문 | 폴리머 코팅 0.65 mm gap 후 O2 식각 0.30 mm gap 예 |
| 챔버 압력 | 1–4 Torr (바람직 1.25–4, 1.5–4); 약 1.9–4 Torr (gap 0.35 mm) | Torr | 본문 | |
| CHF3–N2 chemistry 선택비 (oxide:Si:passivation polymer) | "about 7:1:0.7" | - | 본문 | |
| passivation 층 두께 | "a few nanometer to several microns"; 폴리머 10–15 s 증착 시 "about 1 µm" (원문 µ 글자 깨짐) | - | 본문 | |
| 결함 영역 | "the region at 1.8 mm and outward is considered as a defect region" | mm | 본문 | |
| 다이 없는 가장자리 | "between about 5 mm to about 15 mm" | mm | 본문 | |
- 원문은 CMP·wet cleaning이 steep edge profile을 줄 수 있으나 재현성이 낮다는 취지로 서술(검색 요약, 본문 해당 문단은 발췌에서 확인 못함 → 미확인).
- 취급 주의: 문서 뒤쪽 55,933자는 읽지 못함.

## 출처 2: Lam Research, "Gas modulation to control edge exclusion in a bevel edge etching plasma chamber", US 8,083,890 B2 (우선 2005-09-27, 출원 2008-01-28, 등록 2011-12-27) — https://patents.google.com/patent/US8083890
- 조건: 막 SiO2(TEOS 증착). gap 약 0.4 mm(원문: "gap space of 0.4 mm yields the best results"), 압력 약 1500 mTorr, 10 sccm NF3 + 200 sccm CO2 (center feed).
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| 목표 edge exclusion | "less than 2 mm"; "X is less than about 2 mm, preferably less than about 1 mm, and more preferably less than about 0.5 mm" | mm | 본문 | |
| 기준 공정의 zero-etch-rate 경계 | "more than 3 mm from the edge of substrate" | mm | FIG. 3C 서술 | |
| edge gas feed로 공급 | 제로 식각 영역 "about 2 mm from the edge" | mm | 〃 | |
| 500 sccm CO2 | "about 2.5 mm from the edge" | mm | 〃 | |
| 200 sccm N2 + 500 sccm He 조합 | "about 2.2 mm" (원문: best results) | mm | 〃 | |
| 막 두께 범위 | "a few angstroms to a few microns" | - | 본문 | |
- 프로파일 기울기·전이 폭 수치: 없음(FIG. 3C에 3개 공정의 bevel etch profile 그림이 있다고만 서술). 문서 뒤 14,347자 미확인.

## 출처 3: Lam Research (T. Fang, Y. Kim, K. Kim, G. Stojakovic), "Control of bevel etch film profile using plasma exclusion zone rings larger than the wafer diameter", US 8,398,778 B2 (우선 2007-01-26, 출원 2008-03-14, 등록 2013-03-19) — https://patents.google.com/patent/US8398778B2/en
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| 상부 PEZ ring D1 > 0 ~ 2 mm 일 때 하부 외경 | "296 mm to less than 300 mm" | mm | 본문 | 300 mm 웨이퍼 |
| D1 음수(링이 웨이퍼보다 큼)일 때 외경 | "300.5 mm to 302.5 mm" (D1 −0.25 ~ −1.25 mm) | mm | 〃 | |
| 링 반경 한도 | "up to 10% larger than the diameter of the substrate" | - | 〃 | |
| 부분 세정 | "remove deposited material on the lower 60% to 90% of the bevel edge" | % | 〃 | |
| 식각률 | apex "about 7,000 Å/minute at a radius at 150 mm"; 상부 bevel "2,000 Å/minute at a radius of about 149.8 mm" | Å/min | 〃 | 막 TEOS |
| 공정 조건 | 압력 0.5–2 Torr, RF 400–800 W, F계 가스 10–100 sccm, 총유량 200–500 sccm (balance CO2/O2/N2) | - | 〃 | |
| 막 두께, 프로파일 기울기 | 없음 | | | 높이 H1, H2는 "precisely controlled"라고만 서술 |
- 의미: 식각률 최대가 bevel apex에서 발생(원문 서술), 상부 bevel은 apex 대비 낮음.

## 출처 4: Novellus Systems, "Apparatus and method for edge bevel removal of copper from silicon wafers", US 9,685,353 B2 — https://patents.google.com/patent/US9685353B2/en
- 조건: Cu EBR/BSE, 단일 웨이퍼 spin. 에천트 H2SO4 15–25 wt% + H2O2 20–35 wt% (예: 20% H2SO4 + 28% H2O2). 300 mm 웨이퍼, Cu bevel 0.5 µm 예.
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| taper width (thinning 도입 시) | "less than about 200 micrometers" | µm | 본문 | taper = full metallization thickness 경계 → no metal(edge exclusion) 경계 |
| taper width 실시형태 | "less than about 100 micrometers"; "less than about 50 micrometers" | µm | 〃 | |
| 실시예 결과 | "estimated to be about 127 µm" | µm | 예 | "estimated" 표기 그대로 |
| 선택 정의 | "A narrow taper is highly desirable" | - | 본문 | |
| 핵심 서술 | 두꺼운 pre-rinse 액층이 긴 확산경로를 만들어 에천트가 중심으로 확산 → 넓은 taper | - | 본문 | |
| 조건 수치 | pre-rinse 2 s/400 rpm (예), thinning 600–1200 rpm 1.5–3 s, 800 rpm 2 s 예, 에천트 총 2–14 ml (0.25–2 ml/s), EBR 36 s → 23 s | - | 본문 | |
- 가장 정량적인 wet EBR taper 수치 출처. 문서 뒤 78,311자 미확인.

## 출처 5: N. Sato, C. Bowker (LSI Logic), L. Archer (SEZ America), "Using a single-wafer spin system to prevent dielectric film peeling", Solid State Technology (Semiconductor Digest), 2005-06-01 — https://sst.semiconductor-digest.com/issue/?id=17046
- 조건: SEZ single-wafer spin, 49% HF, 23℃, 1.0 L/min. 막 스택 P-SiO2(base)/low-k/P-SiO2(cap) on Si. Taguchi L9: 회전 500/750/1000 rpm, N2 90/110/130 L/min, 시간 20/40/60 s, wafer shift 0/2/4 counts. BKM: 750 rpm, 40 s, shift 4회, N2 110 L/min. 측정: 광학현미경 12점, SEM 단면(Fig. 6).
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| 목표 | "0.7 ± 0.3mm edge exclusion, with no pin marks" | mm | 본문 | |
| BKM 결과 | "0.7 ± 0.2 mm" | mm | 본문 | wafer shift 필요 |
| ILD 1 µm edge step 위 식각 | "0.7 ± 0.1 mm" | mm | 본문 | |
| 회전수 영향 | 0.35–1.2 mm, 회전수와 선형 | mm | 본문 | 회전수 최대 영향 인자 |
| step 0/0.5/1.0 µm | 750 rpm에서 모두 0.7 mm; 450 rpm에서 step 영향 커짐 | - | 본문 | |
| SiN 하지막 | bare Si 대비 exclusion 증가 | - | 본문 | |
- 전이 폭(10–90%)은 없음. exclusion 위치만 있다. SEM 단면 그림은 이미지라 수치 미확인.

## 출처 6: ACM Research, "Wet Bevel Etch and Cleaning Improves Wafer Yields and Throughput" — https://www.acmr.com/?p=2115
| 항목 | 값 | 단위 | 비고 |
|---|---|---|---|
| bevel etch/cut accuracy | "variable wafer bevel etch/cut accuracy of 1-7mm" | mm | 원문 표기 |
| 균일도 | "+/-0.1mm"; 1 mm cut, SC1/DHF: TiN 2.22%, SiO2 3.16% | - | |
| 프로파일 | "slightly rounded above and below the apex" | - | 수치 없음 |

## 출처 7: Applied Materials, "Bevel etch profile control", US 10,276,364 B2 (등록 2019-04-30) — https://patents.google.com/patent/US10276364B2/en
- 마스크-기판 거리 "less than 100 mil", "about 10 mil", "between 5 mil and 20 mil"; 일반 gap 0.003–0.100 inch. 전이 폭·기울기·exclusion 수치 없음. (장비 구조 정보만)

## 출처 8: Photo EBR 측정 (참고)
- Rudolph/August Technology (P. Simpkins), "Photoresist edge bead removal measurement", US 7,197,178 B2 (등록 2007-03-27) — https://patents.google.com/patent/US7197178 : 상면 edge 카메라 해상도 "up to 7 micrometers", 128장 영상, 2.1 회전, 웨이퍼당 약 10 s 미만. EBR 폭 수치·resist 단면 기울기 없음("distance is not consistent about the circumference").
- 검색 요약만(원문 미확인): EBR 폭은 보통 "0 mm and 6 mm" 범위로 측정(topside edge-exclusion metrology); stylus profiler 방식은 진동에 민감. IEEE TSM 2022 Hough 변환 기반 EBR 폭 측정 논문 존재(제목 "An Investigation of Edge Bead Removal Width Variability, Effects and Process Control in Photolithographic Manufacturing" 도 ATU/Ulster 페이지에서 확인) — 수치 미열람.

## 출처 9: Edge 계측 일반 (검색 요약만, 원문 미확인)
- 검색 요약: edge roll-off는 "several millimeters order in the diameter direction and several tens of nanometers to several hundreds of nanometers order in the thickness direction"(특허 발췌, 번호 미확인). "between wafer edge and 2mm from the wafer edge, it becomes challenging for standard wafer metrology tools to measure the thickness profile". 
- 출처 URL: https://www.bruker.com/es/products-and-solutions/semiconductor-solutions/surface-metrology-systems/edge-roll-off-ero.html ; 전면/베벨/apex/후면 막 두께 측정 시스템 US 10,563,973 (미열람).
- 검색 요약만(원문 미확인): PECVD 비정질 카본에서 edge-hump, shadow ring 방식 edge exclusion "3.5 mm" (Lam 터널러블 PEZ 특허 US 12,340,987 계열 발췌); toroidal plasma + PEZ 링으로 웨이퍼 외곽 "up to 4 mm" 도달(eetasia 기사 https://www.eetasia.com/?p=53401).

## 못 찾은 것
- plasma bevel etch의 **기울기(taper angle, 도 단위)**: 어느 출처에도 각도 수치 없음("very steep", "slightly rounded"만).
- wet spin etch의 **10–90% 전이 폭(µm)**: Novellus taper width(<200/<100/<50 µm, 예시 127 µm) 외에 없음. HF/SC1 계열 spin etch 전이 폭은 없음.
- 두꺼운 다층막(ON stack, mold)의 **막질별 식각속도 차에 의한 stair-step/undercut** 수치: 못 찾음("stepped edge profile", "staircase bevel", "ON stack bevel etch step height" 검색 — 설명 문장 없음). SiN 하지막이 wet exclusion을 늘린다는 정성 서술만(출처 5).
- **막 두께에 따른 프로파일 변화** 정량: ILD edge step 0/0.5/1.0 µm에서 exclusion 변화(출처 5)만.
- Photo EBR resist 끝단 단면(기울기·전이 폭): 없음.
- Bevel deposition(PECVD wrap) 두께-거리 프로파일 수치: 없음. Lam/AMAT/TEL/SCREEN/Semes/Ebara 공개 app note·백서 수치: 이번에 찾지 못함(특허 중심). 논문(JVST/JES/ECS Trans./IEEE TSM)에서 정량 edge profile 데이터는 못 찾음.
- 모든 값은 패치 발췌 확인이며 PDF·도면 이미지 대조는 하지 않음. 도면(FIG. 3C, 7 등)의 프로파일 수치 미확인.

## 요약 3줄
1. 찾은 것: plasma bevel transition 0.5 mm(종래) → <0.05 mm(passivation 마스크, 계측 한계) / 0.1 mm 이하(Lam US8562750), exclusion 목표 <2/<1/<0.5 mm와 zero-etch 경계 2~3 mm(US8083890), wet Cu EBR taper <200/<100/<50 µm, 예시 127 µm(US9685353), wet HF spin edge exclusion 0.7±0.1~0.3 mm, 0.35–1.2 mm(회전수 의존)(SST 2005), ACM wet bevel accuracy 1–7 mm, 균일도 ±0.1 mm.
2. 신뢰도: 특허 본문 발췌(AI 요약 경유)로 수치는 비교적 구체적이나 PDF 원문·도면 미대조, "order of" 같은 완곡 표기와 실시예 한정 값이므로 일반화 금지. 논문급 정량 자료 없음. 출처 8·9는 검색 요약만.
3. 비어 있는 부분: taper angle(도), 10–90% 전이 폭의 wet spin etch, 다층막 stair-step/undercut, 막 두께 의존성, photo EBR 단면, bevel deposition wrap 프로파일, 장비사 app note.
