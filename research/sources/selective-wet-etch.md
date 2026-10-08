# 3D NAND Enlarge / 선택적 wet etch (고선택 SiN, lateral SiN 제거, DSP 계열, 등방 wet CD 확대, Edge undercut) — 조사일 2026-10-08

표기: [확인] = 원문(또는 원문 페이지/특허 본문)을 직접 열어 확인. [초록/검색발췌] = 초록·검색 발췌만 확인(본문 표 미확인).
기밀 표기 자료: 해당 없음(CONFIDENTIAL 표기 자료 발견 못 함). 원문 저장: research\_tmp\wet\ (sispad2023_4-4.pdf, wm1996.pdf(실제는 Williams 2003 Part II), 렌더 PNG).

## 1. 고선택 SiN wet etch (hot H3PO4 + 첨가제)

## 출처 1: Williams, Gupta, Wasilik, "Etch Rates for Micromachining Processing—Part II", J. Microelectromech. Syst. 12(6), 761-778, 2003 — 로컬 research\_tmp\wet\wm1996.pdf (UPenn nanofab 사본)
- 조건: Phosphoric Acid 85 wt%, 160 °C(원문: "this bath was likely a few degrees hotter"); 단위 nm/min. 5:1 BHF = 5 parts 40% NH4F : 1 part 49% HF, ~20 °C. 확인 방법: PDF 표 PNG 렌더 후 직접 읽음 [확인]
| 막질(원문 표기) | 값 | 단위 | 원문 위치 | 비고 |
|---|---|---|---|---|
| Stoich Si Nit. LPCVD, Phosphoric | 4.5 | nm/min | Table IV (p.765) | |
| Si-Rich Si Nit. LPCVD, Phosphoric | 2.7 | nm/min | Table IV | |
| PECVD Si Nit. High RI, Phosphoric | 20 | nm/min | Table IV | |
| PECVD Si Nit. Low RI, Phosphoric | W | - | Table IV | W=작동 알지만 식각률 미측정 |
| Thermal Oxide Wet-Grn, Phosphoric | 0.18 | nm/min | Table III (p.764) | |
| Ann. LTO LPCVD Calogic, Phosphoric | S | - | Table III | S=느리거나 0, 미측정 |
| Unan. LTO LPCVD Tylan / Ann. LTO Tylan, Phosphoric | 0.21 / 0.21 | nm/min | Table III | |
| Unan. PSG / Ann. PSG, Phosphoric | 2.7 / 1.8 | nm/min | Table III | |
| Thermal Oxide, Phos+Sulf | 0.057 | nm/min | Table III | Phos+Sulf 조성은 본문 표 외 확인 안 함 |
| Stoich Si Nit. LPCVD, Phos+Sulf | 2.9 | nm/min | Table IV | |
| Photoresist S1822, Phosphoric | P 120 | nm/min | Table VII | P=막 일부 박리 |
- 비고: 선택비 값은 원문에 없음(계산 안 함). 원문 본문: "Hot phosphoric acid was also found to rapidly etch aluminum."

## 출처 2: Chang Chien, Hu, Yang, "A Design for Selective Wet Etching of Si3N4/SiO2 in Phosphoric Acid Using a Single Wafer Processor", J. Electrochem. Soc. 165(4) H3187, 2018 — https://iopscience.iop.org/article/10.1149/2.0281804jes [초록]
- 조건: 단매엽 장비, 상부 heater plate; 변수 rotation speed, puddle time, temperature.
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| Selectivity (Si3N4/SiO2) | "ca. 100 to 60" | - | Abstract | H3PO4 온도 144→154 °C 상승 시 감소, heater plate로 선택비 크게 개선 |

## 출처 3: T. Park, T. Kim, C. Son, S. Lim (Yonsei), "Kinetic Effect of Additives in High Temperature Phosphoric Acid on the Etching of Si3N4/SiO2", 236th ECS Meeting 2019 (Abstract) — https://ecs.confex.com/ecs/236/webprogram/Paper126847.html [초록]
- 조건: LPCVD Si3N4, SiO2 blanket; H3PO4 + HF, NH4F, Si(OH)4, Si(OC2H5)4, H2SiF6; 160~200 °C; 엘립소미터.
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| F 첨가제의 Si3N4, SiO2 식각률 증가 | "more than 30%" | % | Abstract | |
| H3PO4 Si3N4 활성화 에너지(F 첨가제 시) | "54" | kJ/mol·K (원문 표기) | Abstract | 순수 H3PO4 값은 초록에 명시 안 됨(54가 F 첨가 시 값인지 원문 문장 모호) |
| 순수 H3PO4 SiO2 활성화 에너지 | "81" | kJ/mol·K (원문 표기) | Abstract | |
| Si계 첨가제 | 두 막 모두 식각률 감소, SiO2 감소폭이 훨씬 큼 | - | Abstract | |
| H2SiF6 | Si3N4 증가, SiO2 감소 | - | Abstract | |
- nm/min 절대값은 초록에 없음.

## 출처 4: T. Kim, C. Son, T. Park, S. Lim (Yonsei), "Effect of SiO2 Etching Inhibitor to H3PO4 for the Selective Si3N4 Wet Etching of 3D NAND", 236th ECS Meeting 2019 (Abstract) — https://ecs.confex.com/ecs/236/webprogram/Paper126410.html [초록]
- 조건: 패턴 Si3N4/SiO2 coupon, 85% H3PO4 ± inhibitor, 160 °C, 엘립소미터, FE-SEM/HR-TEM.
| 항목 | 값 | 비고 |
|---|---|---|
| 재성장(regrowth) 위치 | trench corner, stack bottom에 집중 | 원문 |
| inhibitor 농도 의존 | 농도 증가 시 regrowth 증가 | 원문 |
| 최적화 결과 | "without oxide thinning or regrowth" 달성 | 수치 없음 |

## 출처 5: Entegris (Daniela White, David Kuiper, Susan DiMeo), US 11,421,157 B2 "Formulations for high selective silicon nitride etch" (priority 2019-08-21, 등록 2022-08-23); 계속출원 US 12,203,022 — https://patents.google.com/patent/US11421157B2/en , https://patents.google.com/patent/US12203022 [확인: 본문 앞 100,000자만, 실시예 표는 미확인]
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| fresh hot H3PO4 Si3N4:SiO2 | "about 40:1" | - | Background | |
| 희석으로 달성 | "about 10:1" | - | Background | |
| hot phos 선행기술 온도 | "approximately 145-180° C." | °C | Background | |
| 신규 조성 선택비(청구/실시형태) | "about 10:1 to about 7,000:1"; 다른 실시형태 "about 100:1 to about 2000:1" | - | Summary(US12203022) | |
| 신규 조성 온도 | "about 40° C. to about 120° C."; "about 60° C. to about 95° C." | °C | Summary | |
| H3PO4 / water | "about 50 to about 95 weight percent" / "about 5 weight percent to about 25 percent" | wt% | Summary | |
| 첨가제 예 | 85% H3PO4 + "0.0002 moles of (3-aminopropyl)silane triol"(Fig.1) | - | Fig.1 설명 | alkylaminoalkoxysilane류, O-phosphorylethanolamine(Si3N4 가속제) 등 열거 |
- 원문 서술: 96층 이상에서는 "a specially formulated wet etch chemistry is needed"; 슬릿 입구 쪽 oxide 침적이 "eventually blocking them"; 기존 pre-dissolve 방식은 pre-etch oxide 농도 window가 좁고 bath 교체 빈번.
- SiN/SiO2 식각률 절대값(실시예 표)은 미확인.

## 출처 6: YMTC, US 10,913,893 B2 "Additive to phosphoric acid etchant" — https://patents.google.com/patent/US10913893B2/en [확인: 요약·배경]
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| 무첨가 hot H3PO4 Si3N4 식각률 (about 150-170 °C) | "about 35 A/min to about 65 A/min" | Å/min | Background | |
| 동일 조건 Si oxide 식각률 | "about 70 A/h to about 130 A/h" | Å/h (원문 단위) | Background | |
| 선택비 | "about 30" | - | Background | "needs to be increased to, for example, above 400" |
| 첨가제 | SiR3-N형 organosilane >about 0.3 wt%, surfactant about 0.03 wt%, SiR3-Cl형 organosilane >about 4 wt% | wt% | Summary/Claim 20 | |

## 출처 7: Tokyo Electron (Bassett, Rotondaro, Simms, Hurd), US 10,886,290 B2 "Etching of silicon nitride and silica deposition control in 3D NAND structures" (provisional 2018-07-20) — https://patents.google.com/patent/US10886290 [확인: 실시예 시뮬레이션]
- 조건: H3PO4 "85.8-86.6 wt. %"; 77/150/200 alternating layer 시뮬레이션.
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| baseline bath 온도 / SiN 식각률 | 150 °C / "62 Å/min" | - | Figs 2-4 설명 | 77, 150, 200층 |
| 150층 완전식각 소요 / 식각률 / 온도 | "4.3 hours" / "25 Å/min" / "about 123° C." | - | 본문 | |
| 200층 완전식각 소요 / 식각률 / 온도 | "7.0 hours" / "15 Å/min"(소요식각률 기재) / "about 108° C."(25 Å/min 사례로 기재) | - | 본문 | 원문 내 15/25 Å/min 병기, 맥락 재확인 필요 |
| trench bottom 초기 silica 농도 | 77층 "about 70 ppm", 150층 "about 112 ppm", 200층 "about 162 ppm" | ppm | 본문 | 청구항: ~70 ppm 이하 유지 |
| SiN:SiO2 선택비 | "greater than 100:1" | - | 본문 | silica 첨가 + 적절한 tuning |
- silica 침적 제어: 온도 낮춤, H2SO4 희석, 다단 bath, silica 농도 모니터링.
- 같은 저자 학회 초록: D. Bassett, W. Printz, T. Furukawa (TEL), "Etching of Silicon Nitride in 3D NAND Structures", 228th ECS Meeting 2015 (ECS Trans. 69 p.159 인용은 SISPAD 2023 참고문헌 [3]) — https://ecs.confex.com/ecs/228/webprogram/Paper60572.html [검색발췌]: "hot phosphoric acid bath with a silica additive ... selectivity of greater than 100:1 for etching SiN:SiO2".

## 출처 8 (선택비 940 사례): Chung-Ang Univ., "Green Manufacturing of Silyl-Phosphate for Use in 3D NAND Flash Memory Fabrication" (ACS Sustainable Chem. Eng. 2021, DOI 10.1021/acssuschemeng.0c05677로 검색 결과 안내) — https://scholarworks.bwise.kr/cau/handle/2019.sw.cau/51388 [검색발췌만]
- 원문 발췌: "Si3N4/SiO2 layer etching ratio of up to 940". 조건(온도, 식각률) 미확인.

## 'USN' 명칭 확인
- "USN" / "Ultra Selective Nitride" 명칭의 공개 자료(논문, maker 자료, 특허): 못 찾음 (검색: "ultra selective nitride" OR "USN" wet etch phosphoric acid 3D NAND; 특허 검색 포함). 
- 유사 명칭: SK Materials "HSP (High Selectivity Phosphoric acid)" — 제품 페이지 한 줄 소개만, 수치 없음 (https://www.sk-materials.com/new/eng/html/products/Business08.asp) [검색발췌]. LTCAM 관련 보도 https://english.etnews.com/20200218200002 [검색발췌].
- 주의: Lam Research US 10,192,751 "Systems and methods for ultrahigh selective nitride etch"는 건식(NF3/CH2F2/O2 등 플라즈마, 0.3-10 Torr)이며 "greater than 1000:1", "less than 1 Å of silicon dioxide thin loss" 서술. wet 아님 [확인]. 'USN'과의 관련은 확인 안 됨.

## 2. Replacement gate SiN 제거 시 slit lateral etch / regrowth / collapse

## 출처 9: Reiter, Toifl, Hössinger, Filipovic, "Modeling Oxide Regrowth During Selective Etching in Vertical 3D NAND Structures", SISPAD 2023, 4-4, pp.85-88 — https://in4.iue.tuwien.ac.at/pdfs/sispad2023/SISPAD2023_4-4.pdf [확인: 로컬 PDF 텍스트 추출] (시뮬레이션 논문, 실측 아님)
- 조건: 등방 식각, SiO2 식각률 0(ideal selectivity), 그리드 2.5 nm, 시뮬레이션 영역 일부(원문: 30 nm, trench 150 nm, 200 nm 언급).
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| 확산계수 D | 50 | nm2/s | Table I | 교정 파라미터(Kim et al. 실험에 맞춤) |
| cavity stream velocity vc | 5 | nm/s | Table I | |
| trench stream velocity vt | 7.5 | nm/s | Table I | |
| sink S | 0.1 | concentration/s | Table I | |
| redeposition factor RD | 0.01 | - | Table I | 본문에 0.005 사용 언급 있음 |
- 원문 서술: silicic acid 등 SiO2 inhibitor 첨가 + byproduct 증가로 "abnormal oxide regrowth"; 층수 많을수록 byproduct mass transfer 제한으로 regrowth 증가; 결과 결함 = "SiO2 layer thickening"과 "Si3N4 trench clogging"으로 W 증착 균일성 저하, W void.
- 인용된 실험 문헌(원문 본문 미확인, 제목만): T. Kim et al., "Oxide regrowth mechanism during silicon nitride etching in vertical 3D NAND structures", Microelectron. Eng. 221, 111191 (2020); Teng et al., J. Mater. Sci. 55, 1126 (2020); Z. Zhou et al., J. Ind. Eng. Chem. 119, 218 (2023); Seo et al., Microelectron. Eng. 118, 66 (2014) ("Selective wet etching of Si3N4/SiO2 in phosphoric acid with the addition of fluoride and silicic compounds").

## 출처 10: Teng, Tu, Hu, Huang, Sheng, Tsao, "Abnormal redeposition of silicate from Si3N4 etching onto SiO2 surfaces in flash memory manufacturing", J. Mater. Sci. 55(3), 1126-1135, 2020 — https://agris.fao.org/search/fr/records/65df82257c7033e84bededc7 [초록]
- 조건: blanket wafer 2장 사이 간격 "~80 μm".
- 결과(원문 요약): 수분 함량 또는 agitation 증가 시 SiO2 growth rate 감소; 화학 침적과 mass transfer 경쟁.

## 출처 11: T. H. Kim, Y. S. Lee, J. W. Han, S. W. Lim, "Investigation of Oxide Regrowth in the Selective Si3N4 Etching Process for 3D NAND Fabrication by Using Finite Element Modeling Simulation", Solid State Phenomena 346, p.143~ — https://www.scientific.net/SSP.346/3 [초록]
- 결과: 적층 수 증가, byproduct 확산도 감소 시 regrowth 악화; H2SiO3 확산 촉진 etchant 제안. 수치 없음. 연도 페이지에 미표기.

## 출처 12: Nanja (Coventor/Lam), "Challenges And Solutions For Silicon Wafer Bevel Defects During 3D NAND Flash Manufacturing", Semiconductor Engineering, 2019-05-23 — https://semiengineering.com/challenges-and-solutions-for-silicon-wafer-bevel-defects-during-3d-nand-flash-manufacturing/ [확인] (해설 기사)
- 원문 인용: "This nitride exhume step can cause defects at the bevel through wet undercut" (HAR etch의 micromasking이 있었던 영역에서 위험 증가); "Wet etch processes can also attack the thin surfaces on the wafer edge"; 입자 축적이 "peeling or delamination"으로 이어짐; blister 파손 시 추가 particle; "Micromasking at the bevel can be mitigated by carefully applying a bevel etch step". 수치: 에지 영역 "From 2-3mm out to the wafer's edge"만.

## 3. DSP / DSP+ 계열 및 W/TiN recess 약액

## 출처 13: K. H. An, D. G. Kim, H. T. Kim, N. P. Yerriboina, T. G. Kim, J. G. Park, "Formulation and Evaluation of Diluted Sulfuric-Peroxide-HF (DSP+) Mixtures for Cleaning High-Aspect Ratio Contacts in 3D NAND", Solid State Phenomena 314, 161-166, 2021 (DOI 10.4028/www.scientific.net/ssp.314.161) — https://www.scientific.net/SSP.314.161.pdf [본문 403, 초록·목록 메타만 확인]
- 내용(검색 요약 기준): 포토레지스트 strip rate, 입자제거효율(PRE), 접촉각을 H2SO4/H2O2/HF/IPA 농도별로 평가; H2SO4 증가 시 strip rate 급증, IPA 첨가 시 strip rate 증가·접촉각 감소, PRE는 HF 농도가 주 인자. 
- W, TiN, Ti, Al, Cu 식각률: 초록에 없음. 본문 미확인.

## 출처 14: Intel (Thompson, Mistkawi, Grover), US 9,472,456 B2 "Technology for selectively etching titanium and titanium nitride in the presence of other materials" — https://patents.google.com/patent/US9472456B2/en [확인: 앞 100,000자]
| 막질(원문 표기) | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| TiN, 92.1 wt% H2SO4 + 7.9 wt% H2O2, 100 °C (약 11.5:1) | "2.1 to about 2.6" (대부분 2.2~2.4, 평균 약 2.3~2.4) | Å/s | 실시예 | |
| W, H2SO4:H2O2 "7:1" | 0 | Å/min | 실시예 | 단위 원문 그대로 |
| W, "1:4" | "about 12 to about 20" | Å/s | 실시예 | |
| W, "2:3" | "about 25 to about 40" | Å/s | 실시예 | |
| 바람직 H2SO4:H2O2 중량비 / 온도 | "12:1 to 6:1" / 약 60~140 °C(바람직 약 100 °C) | - | 본문 | |
| Ti, dilute HF + MTES(silicon precursor) + benzotriazole 용액 | about 120 | Å/min | 실시예 | 같은 용액에서 W, CVD Si, CDO, Si3N4, SiC 0 Å/min; Cu, Al, SiO2는 수치 없이 "suppressed" |
- 비고: DSP+(HF 첨가)가 아닌 SPM 계열. 이 값을 DSP+에 적용 불가.

## 출처 15: Versum Materials, US 11,499,236 B2 "Etching solution for tungsten word line recess" — https://patents.google.com/patent/US11499236B2/en [확인: 앞 100,000자]
| 항목 | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| W 및/또는 TiN 제거율 | "from about 10 Å/min to about 400 Å/min or greater" | Å/min | Summary | 또 다른 범위 "about 2 to about 20 Å/min"(대상 맥락 원문 확인 필요) |
| AlOx(비교) | "less than 50 Å/min" | Å/min | 본문 | |
| 산화제 | "from about 0.5% to about 60%"; H2O2 "about 5% to about 15% by weight" 예 | wt% | 본문 | |
| F계 식각제 | "about 0.01% to about 20%" | wt% | 본문 | |
| 처리 온도/시간 | "about 20-80° C. and more preferably from about 30-60° C."; "1 minute to about 60 minutes" | - | 본문 | |
| 모재 대비 선택비 | "at least 10 or at least 15 or at least 20" | - | 본문 | 대상: glass, silicon, silicon oxide, silicon nitride |
- 원문: "In the recessing process TiN and W should be simultaneously etched with equal thickness."; wet이 W recess 대안으로 제안됨.

## 4. 등방 wet(HF계, 참고)

## 출처 1과 동일 (Williams 2003 Part II) — Table VIII p.771, 같은 논문 Table III/IV/VI [확인: PNG 렌더]
- 조건: 상온 약 20 °C, 단위 nm/min.
| 막질(원문 표기) | 값 | 단위 | 위치 | 비고 |
|---|---|---|---|---|
| Thermal oxide, Conc. HF (49%) | 2300 | nm/min | Table VIII | |
| Thermal oxide, 10:1 HF | 23 | nm/min | Table VIII | |
| Thermal oxide, 25:1 HF | 9.7 | nm/min | Table VIII | |
| Thermal oxide, 100:1 HF | 2.3 | nm/min | Table VIII | |
| Thermal oxide, 5:1 BHF | 100 | nm/min | Table VIII | |
| Thermal oxide, 10:1 BHF | 50 | nm/min | Table VIII | |
| Oxide PECVD Unannealed / Annealed, 5:1 BHF | 490 / 240 | nm/min | Table III | |
| Ann. LTO LPCVD Calogic, 5:1 BHF | 150 | nm/min | Table III | |
| Stoich Si Nit. LPCVD, 10:1 HF / 5:1 BHF | 1.1 / S | nm/min | Table IV | |
| W Sputtered, H2O2 50 °C | 150 | nm/min | Table VI (p.767) | |
| W Sputtered, 10:1 HF / 5:1 BHF | 0 / <2 | nm/min | Table VI | |
| TiN Sputtered, 5:1 BHF | 2.5 | nm/min | Table VI | |
| W Sputtered, Piranha | "-" | - | Table VI | 값 없음(표 공란) |
- SC1 식각률: 이 논문에는 SC1 열이 없음. 채널 hole CD 확대 목적의 DHF/SC1/BOE 식각률 문헌: 못 찾음.
- 참고(검색발췌, 미확인): 채널 hole wet clean이 등방이어 CD가 확대됨을 서술한 특허 US 10,790,297 B2 (nonconformal sacrificial layer) — https://image-ppubs.uspto.gov/dirsearch-public/print/downloadPdf/10790297 [본문 미확인].

## 5. Wafer edge 관점
- 출처 12(Nanja, Semiconductor Engineering 2019)가 유일하게 확인된 직접 서술: nitride exhume 단계의 bevel wet undercut, wet etch의 edge 박막 공격, peeling/particle. 수치(undercut 폭, 속도) 없음.
- ACM Research 보도/제품 페이지 (검색발췌): wet bevel etch로 에지 박막 제거, "bevel etch/cut accuracy 1-7mm", "uniformity +/-0.1mm"(벤더 주장), "very long wet etches can cause residues, roughness, and damage along the wafer edge" — https://www.acmr.com/bevel-etch-cleaning/ , https://semiengineering.com/defect-challenges-grow-at-the-wafer-edge [검색발췌만, 본문 미확인].
- 특허 US 10,580,690 / 10,002,787 (Staircase encapsulation in 3D NAND) — 산화막 계면의 gap 형성으로 식각종이 침투한다는 서술 [검색발췌만].

## 못 찾은 것
- "USN"/"Ultra Selective Nitride" 약칭의 공개 자료 (시도: "ultra selective nitride" OR "USN" wet etch phosphoric acid 3D NAND; Lam 건식 특허만 유사 명칭).
- slit 측면 SiN 제거 깊이·속도(lateral etch depth/rate)의 정량 공개값 (TEL 특허의 층수별 시간/식각률 시뮬레이션만 확인, 실측 lateral 깊이 없음).
- oxide teeth/overhang 및 처마(pattern) collapse 정량 사례: 관련 실측 논문 못 찾음. 검색발췌에서 ONON staircase pull-back 시 collapse 위험 언급만 있고 근거 본문 미확인. (시도: pattern collapse nitride pullback 3D NAND, oxide overhang lateral etch).
- Kim 2020 (Microelectron. Eng. 221, 111191), Zhou 2023 (J. Ind. Eng. Chem. 119, 218), Seo 2014 (Microelectron. Eng. 118, 66)의 본문 표(식각률 nm/min, 선택비): 접근 못함(유료/초록 미확보).
- DSP+의 W/TiN/Ti/Al/Cu 식각률: SSP 314 본문 403, 다른 출처에서도 DSP+ 수치 없음. 검색발췌에 DSP+ Al 식각 "about 25 Å per wafer pass"(2005 산업기사, 단위 per pass)가 있으나 원문 미확인. Entegris 등 maker datasheet에서 DSP+ 수치 못 찾음.
- Entegris/Fujifilm/Stella Chemifa/Soulbrain/Dongwoo/KMG의 고선택 인산 공개 datasheet 수치: 못 찾음 (US 11,421,157 실시예 표는 앞부분 텍스트만 읽어 미확인; patents.google 나머지 25,987자 offset 100000 이후 미조회).
- 채널 hole/WL enlarge용 DHF·SC1·BOE의 3D NAND 구체 식각률(문헌): 못 찾음 (Williams 2003 일반 박막값만 확보).
- Wafer edge lateral undercut/overhang의 수치 사례.
- 검색발췌로만 본 항목(TEL 초록 ">100:1", Chung-Ang "940", SK Materials HSP)은 본문 표 미확인.

## 요약
- 찾은 것: 무첨가 hot H3PO4(85%, 160 °C) 막질별 nm/min(Williams 2003, 표 렌더 확인), 첨가제 인산의 선택비 보고 범위(40:1 fresh, >100:1 TEL, 940 Chung-Ang, 특허 청구 최대 7,000:1, YMTC 기준 30→400 목표), 층수별 silica 농도·식각률 시뮬레이션(TEL), regrowth 메커니즘 문헌(Yonsei, TU Wien, Teng), SPM 계열 W/TiN 식각률(Intel 특허), Versum W/TiN recess 약액 10~400 Å/min, HF/BHF 산화막 식각률. USN 명칭 공개 자료 없음, DSP+는 SSP 314 존재만 확인(금속 식각률 수치 없음).
- 신뢰도: 확인 표시(Williams 2003, Intel/Versum/YMTC/TEL/Entegris 특허 본문 일부, Nanja 기사)는 중간~높음; 초록/검색발췌 표시 항목은 낮음~중간. 특허 수치는 실시예가 아닌 배경·청구 서술이 다수이며 원문 단위(Å/s, Å/min, Å/h) 혼재.
- 비어 있는 부분: USN 명칭, lateral 식각 깊이/속도 실측, oxide teeth·collapse 정량, DSP+ 금속 식각률, 3D NAND hole enlarge용 DHF/SC1/BOE 수치, edge undercut 정량, maker datasheet 수치.
