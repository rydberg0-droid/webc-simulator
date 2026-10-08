# 세정·Strip 식각률 — 조사일 2026-10-08

## 출처 1: K. R. Williams, K. Gupta, M. Wasilik, "Etch Rates for Micromachining Processing—Part II", J. Microelectromechanical Systems 12(6), Dec. 2003, pp. 761–778
- PDF: http://microlab.berkeley.edu/labmanual/chap1/JMEMSEtchRates2(2003).pdf (사본: https://www.seas.upenn.edu/~nanosop/documents/Etchratesformicromachiningprocessing.pdf)
- 단위는 nm/min이다. 표 기호: W=식각되나 미측정, S=느림/0 미측정, R=거칠어짐, P=일부 박리, I=잠복시간

| Etch (조건) | Si(100) | Poly 비도핑 | 열산화 | Ann LTO | PECVD Ox 비어닐 | PECVD Ox 어닐 | Stoich SiN LPCVD | PECVD SiN 고RI | PR (S1822/OCG820) | W sputter | Copper Evap |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 10:1 HF (실온) | S | 0 | 23 | 34 | W | W | 1.1 | - | S/0 | 0 | S |
| 5:1 BHF (실온) | 0 | 0.2 | 100 | 120 | 490 | 240 | S | 8.2 | 0/0 | <2 | R <5 |
| Phosphoric 85%, 160℃ | 0.17 | S | 0.18 | 0.21 | - | - | 4.5 | 20 | P120/55 | - | - |
| Piranha | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | >92,000/F | - | 88 |
| Si Iso Etch (126 HNO3:60 H2O:5 NH4F) | 150 | 100 | 8.7 | 11 | 100 | 25 | - | 12 | P0/0 | 13 | 37 |
| H2O2 50℃ | S | S | 0 | S | S | S | 0 | S | RT0/S | 150 | - |
| XeF2 | 460 | 180 | 0 | 0 | S | S | 12 | - | S/0 | 80 | - |
| HF vapor (실온) | S | 0 | 66 | 78 | W | W | 1.0 | - | -/P0 | 0 | R |
| Technics O2 plasma | S | 0 | 0 | 0 | S | S | 0 | S | 300/340 | 0 | S |
| STS SF6+O2 | 1500 | W | 29 | 48 | 55 | 32 | 150 | 190 | 180/- | W | S |
| STS CF4+O2 | 95 | - | 44 | 46 | 51 | 43 | 120 | 110 | 130/- | - | - |

- Copper Evap 열(2026-10-08 추가): 같은 출처 Table VI 'Copper Evap'(증착 Cu) 원문 표기. Phosphoric·XeF2 칸은 원문 Table VI 이미지 확인 결과 '-'(미측정).
  - 시뮬레이터 반영(CLN_DB.er.Cu): Piranha 88, Si Iso Etch 37, 5:1 BHF 5(‘R <5’ 상한값, est·거칠어짐 표시). '-'·'S'·'R'(값 없음)·미확인 칸은 넣지 않음 → 데이터 없음(정지+경고).
  - 표 밖 Cu 측정값(FeCl3 3900, APS 2500, aqua regia 600, CR-7 280, Al Etch A >2900)은 해당 약액이 시뮬레이터 DB에 없어 반영하지 않음.

- Table VIII은 열산화막 기준이다: Conc HF 2300, 10:1 HF 23, 25:1 HF 9.7, 100:1 HF 2.3, 5:1 BHF 100, 10:1 BHF 50.
  - 10:1~100:1 구간에서 농도에 선형이다.
  - 10:1 BHF는 5:1의 정확히 1/2이다.
- 기타 측정값:
  - Technics O2: Polyimide 370, Parylene-C 220
  - STS SF6+O2: Mo 130
  - Graphite(ion-mill): Si Iso Etch 60, O2 0

## 출처 2: Stella Chemifa 특허 (BHF)
- BHF(40% NH4F + 50% HF) 6:1~100:1에서 SiO2 식각속도가 90~1200 Å/min이라고 한 문장이 있다. 다른 특허에는 27~115 nm/min으로 나온다.
- LAL 제품별(LAL500/800 등) 공개 수치는 찾지 못했다.

## 출처 3: Applied Materials 특허 "Selective etch of silicon nitride" (US 8,956,980 / US 9,209,012 계열)
- NF3/O2/He/Ar remote plasma에서 SiN의 식각속도는 SiO2의 약 90배, Poly의 약 15배다.
- 동일 계열의 다른 특허에서는 SiO2 대비 약 100배, Poly 대비 30배 이상으로 나온다.
- 절대 속도(nm/min)는 snippet에서 찾지 못했다.

## 출처 4: Y. Saito, Sensors and Materials (2002), 무플라즈마 ClF3 Si 식각 — https://sensors.myu-group.co.jp/sm_pdf/SM485.pdf
- Si/SiO2 선택비는 실온~400℃에서 100~300이다. 5% ClF3, 상압, 실온 조건에서 약 300이었다고 인용한다(Ueda & Kuribayashi).
- 활성화에너지는 0.18 eV다. 절대 속도는 abstract에 없다.

## 출처 5: Lee et al., Scientific Reports (2022), ClF3/H2 remote plasma — https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8983696/
- ClF3 remote plasma에서 SiNx는 실온에서 80 nm/min 이상, SiNx/SiOy 선택비는 약 130이다. H2를 넣으면 200 이상이 된다.
- ClF3 gas만 흘렸을 때는 SiNx 식각이 훨씬 느리다.

## 못 찾은 것
- SC1(1:1:5, 70~80℃)의 SiO2·SiN·Si nm/min 정량값. 정성적으로만 확인했다(Si는 수 Å/min 수준).
- CHF3/CF4, Cl2/HBr, N2/H2, O3의 막질별 정량값.
- 비정질 탄소(ACL)와 SOH의 O2 ashing 속도를 PR과 같은 조건에서 비교한 값.
- 검색어 후보: "amorphous carbon hardmask ash rate O2 downstream", "SC1 etch rate thermal oxide 1:1:5 nm/min", "HBr Cl2 polysilicon oxide selectivity etch rate table".

## 요약
- 찾은 것: Williams 2003 표 하나로 DHF, BOE, H3PO4, Piranha, HF-Nitric, H2O2, XeF2, VHF, O2, SF6/O2, CF4/O2의 실측값을 확보했다.
- 신뢰도: 상(동일 실험실, 동일 막 세트). 다만 MEMS 장비 기준이라 양산 설비의 절대 속도와는 다를 수 있고, 선택비 경향은 유효하다.
- 공백: LAL 제품 수치, NF3·ClF3의 절대 속도, ACL/SOH의 ashing 속도, SC1·CHF3·Cl2/HBr·N2/H2·O3.
