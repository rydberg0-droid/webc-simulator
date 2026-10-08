# WEBC Edge Simulator v3 — UI 설계안 (ui-spec)

- 대상: `webc_simulator_v3.html` (v2 원본 `webc_simulator_v2_src.html`은 손대지 않는다)
- 작성: designer / 2026-10-08
- 범위: 화면 구조, 정보 위계, 표기, 상호작용. **계산 엔진(`simulate`, `metrics`, `impactOf`, `edgeStatus`의 판정 로직, `parseCmd`)은 바꾸지 않는다.** 바꾸는 것은 DOM 배치, CSS, 렌더링 텍스트뿐이다.
- 유지하는 기존 결정: 엔진 재사용 / 고급 기능은 ⚙ drawer에 숨김 / Excel·클립보드 붙여넣기 제거(보안) / 서술형 입력 우선 / 세로 Layer 스택(FRONT ↑ · Si sub · BACK ↓)

## 0. 제품 목적과 판단 기준

> "간단하게 모델링해서, 지금 Wafer Edge가 어떤 상황인지 직관적으로 파악한다."

이 문서의 모든 판단은 다음 질문 하나로 정했다.
**"화면을 연 엔지니어가 3초 안에 '이 단계 직후 Edge가 괜찮은가, 아니면 무엇이 문제인가'를 읽을 수 있는가?"**

---

## 1. 관찰 근거 (스크린샷)

모든 파일은 `design/_shots/`에 있다. 상태 재현용 `t.html`은 원본을 복사한 뒤 `#hash`로 상태를 주입한 테스트 파일이다(`inject.js`).

| 파일 | 상태 |
|---|---|
| `desk_1440.png` | 첫 화면 1440×1000 (기본 `loadPreset('mold')`, 6단계 선택) |
| `d_mid.png` | `go(1)`: 2단계(PES) 선택, 이후 단계 흐리게 |
| `d_cell.png`, `d_cell_tall.png` | `loadPreset('cell')` 39단계 (1000px / 1800px 높이) |
| `d_empty.png` | `resetRecipe()` 빈 상태 |
| `d_err.png` | 해석 불가 입력 `asdf 123` |
| `d_prev.png` | 미리보기 `BEVEL O2 PLASMA 2mm` |
| `d_ask.png`, `d_askd.png` | 세부값 요청 칸 (`BACKSIDE CLEAN`, Shift+Enter) |
| `d_help.png`, `d_ref.png` | '문법 ?' / 'Gas·약액 표' 펼침 |
| `d_detail.png` | '상세 입력' + '세부 옵션' 펼침 |
| `d_adv.png`, `d_adv2.png` | ⚙ 고급 drawer (기본 / 전부 펼침) |
| `d_tip2.png` | 단면도 hover 툴팁 |
| `d_eecell.png` | cell 레시피 + `EE 3mm` |
| `m375_default.png` | 375px iframe (원본) |
| `m375_ask.png`, `m375_adv.png` | 375px 세부값 요청 칸 / drawer |

---

## 2. 문제점 (사용자 관점, 관찰 근거 포함)

심각도: **H** = Edge 상태 파악을 직접 방해 / **M** = 혼동·느려짐 / **L** = 다듬기

### 2.1 정보 위계·시선 흐름

| # | 문제 | 근거 | 심각도 |
|---|---|---|---|
| A1 | **판정(verdict)이 화면 맨 아래.** 시선 흐름이 입력(270px) → 단면도 → 스택/순서 → 판정 순서라 '답'을 마지막에 본다. | `desk_1440.png`: `#verdict`가 y≈700. `m375_default.png`: 1,400px 가까이 스크롤해야 보임 | H |
| A2 | **긴 레시피에서 Edge 상태가 화면 밖으로 밀려나고 큰 빈 공간이 생긴다.** `.layout`의 grid가 `"cv tl" "st tl"`이어서 오른쪽 `.p-tl`이 길어지면 2·3행이 함께 늘어나 `.p-st`가 아래로 밀린다. | `d_cell_tall.png`: 단면도 아래 y≈780~1300 빈 공간, Edge 상태는 y≈1310. `d_cell.png`(1000px): Edge 상태가 아예 안 보임 | **H (레이아웃 버그)** |
| A3 | 오른쪽 `.p-tl`이 `position:sticky`인데 뷰포트보다 길어서 sticky 효과가 없고 하단의 공정 순서가 잘린다. Layer 스택(`#stack`)에는 높이 제한이 없다. | `d_cell.png`: 스택 17행 때문에 공정 순서가 y≈900부터 시작 | H |
| A4 | '몇 단계 직후'가 세 번 반복된다 (`#cvName` "6. CLN O2 직후", `#stackAt` "— 6단계 직후", `#stAt` "6 / 6 단계 직후"). 정작 한 곳에 묶인 '현재 시점' 표시는 없다. | `desk_1440.png` | M |
| A5 | 판정과 신호등이 같은 정보를 두 번 보여준다. 판정 문장은 빨강/노랑 메시지를 이어 붙인 것이고, 오른쪽 6개 지표도 같은 내용이다. 여기에 `#stepNote`(빨강 긴 문단)까지 더해져 Edge 상태 박스 하나에 빨간 텍스트가 3군데 있다. | `desk_1440.png` 하단 | M |

### 2.2 판정·신호등 가독성

| # | 문제 | 근거 | 심각도 |
|---|---|---|---|
| B1 | 신호등이 8px 점(`.dot`) 하나뿐이고, 색 외에 위험도를 구분할 단서가 없다(색약 대응 불가). 값(`.ind .v`)은 모두 흰색이라 빨간 항목이 눈에 띄지 않는다. | `desk_1440.png`: "-7.20 µm"과 "0 N/m"의 강조가 같음 | M |
| B2 | 해당 없음 항목('Photo 없음' 등 `.ind.na`)이 줄을 차지하고, 빈 상태에서는 5줄 중 4줄이 회색이다. | `d_empty.png` | L |
| B3 | 판정 근거의 기준이 보이지 않는다(EE 몇 mm 기준인지, 허용 step 몇 µm인지). EE는 판정을 바꾸는데 drawer 안 `#eeMm`에만 있다. | `d_adv.png`, `d_eecell.png` | M |

### 2.3 단면도 판독성

| # | 문제 | 근거 | 심각도 |
|---|---|---|---|
| C1 | **과장 배율 표기가 거의 안 보인다.** "Film·Si손실 수직 ×10 과장"이 10px 회색(`#64748b`)으로 왼쪽 아래 구석에 있다. 같은 레시피라도 폭에 따라 배율이 ×10(데스크톱)에서 ×32(375px)로 바뀌는데, 이를 알아차릴 수 없다. | `desk_1440.png` / `m375_default.png` 비교 | H |
| C2 | X축에 단위와 방향이 없다. "147.0 … 150 (Edge)"만 있어서 R(mm)인지, 왼쪽이 중심 쪽인지 바로 알기 어렵다. | `desk_1440.png` 상단 눈금 | M |
| C3 | 범례(`#legend`)가 '레시피 전체에 쓰인 막질'을 보여준다. 현재 단계에서 이미 제거된 HT-ACL, MT-TEOS도 나오고, `SC 60/50%` 같은 공정 파라미터가 섞여 있다. | `desk_1440.png`: 6단계 단면에는 Mold만 있는데 범례는 5종 | M |
| C4 | Mold 표시(분홍·보라 줄무늬 혼색)가 범례의 SiO2 파랑, SiN 빨강 견본과 다르게 보인다. "Mold = 교번 줄무늬" 텍스트만 있다. | `desk_1440.png`, `d_cell.png` | L |
| C5 | Photo 단계 이후 단면도 위쪽의 보라색 띠(PR barrier 영역 바)에 라벨이 없다. | `d_cell.png` y≈365 | L |
| C6 | Si 라벨 "Bare Si (775µm, 두께 47%로 축소 표시)"가 막이 덮여 있어도 늘 'Bare Si'라고 적힌다. | `d_cell.png` | L |
| C7 | 조작 힌트 줄(`.zhint`)이 상시 노출되어 범례와 경쟁한다. | `desk_1440.png` | L |

### 2.4 Layer 스택과 공정 순서의 관계

| # | 문제 | 근거 | 심각도 |
|---|---|---|---|
| D1 | 스택 헤더 "중심 · Apex"에서 '중심'은 실제로 **R≈145mm(Edge에서 5mm)** 이다(`renderStack(iF,…)`, `near(p.d≈5)`). drawer에는 "Front THK (R=145)", 신호등에는 "Edge 단차 (vs 중심)"로 적혀 있어 '중심 = 웨이퍼 센터'로 오해할 수 있다. | 코드 `draw()`의 `near`, `metrics()`의 `c`(d 4~6mm) | M |
| D2 | Apex 열의 값이 숫자이거나 "edge 없음"(빨강)이어서 헤더 'Apex'와 '없음'의 표기 체계가 다르다. cell 레시피에서는 17행 중 13행이 빨간 "edge 없음"이라 빨강의 의미(위험)가 희석된다. | `d_cell.png` | M |
| D3 | 같은 단계가 위치마다 다른 이름으로 나온다. 6단계: 단면 제목 "CLN O2", 공정 순서 "PLASMA O2", 판정 노트 "[CLN · Plasma] O2 Plasma / Ashing". 2단계: "PES 2.5mm" / "PES" / "[REMOVE] PLASMA EDGE STRIP". `stepShort`, `stepCells`, `stepText` 세 함수가 이름을 각자 만든다. | `desk_1440.png`, `d_mid.png` | M |
| D4 | 공정 순서 테이블의 `thead`가 숨겨져 있어(`.stbl thead{display:none}`) 'Edge', '전면' 열과 점(●) 열의 의미가 설명되지 않는다. | `desk_1440.png` | L |
| D5 | 스택 행에 hover하면 title 툴팁만 뜨고, 단면도의 해당 층이나 공정 순서의 해당 행과 연결되지 않는다. | 코드 `renderStack` | L (P2) |

### 2.5 입력 영역 밀도

| # | 문제 | 근거 | 심각도 |
|---|---|---|---|
| E1 | 입력 박스가 첫 화면의 27%(270/1000px)를 차지한다. 입력창 아래에 긴 안내 문장(`#cmdPrev` 기본 hint), 예시 8개, '문법 ?', 'Gas·약액 표', '상세 입력'이 모두 상시 노출된다. | `desk_1440.png` | M |
| E2 | 입력 경로가 3개다: ① 서술형 Enter ② `⋯ 세부`(Shift+Enter, 세부값 요청 칸) ③ '상세 입력'(`#detailBox`, 구형 폼 전체). ②와 ③은 역할이 겹친다. | `d_detail.png` vs `d_askd.png` | M |
| E3 | 세부값 요청 칸이 열리면 위쪽 미리보기 2줄("Enter → … 입력 칸이 열립니다", "Wet 종류를 고르면…")이 이미 열린 칸 설명을 반복한다. | `d_ask.png` y≈180~205 | L |
| E4 | `초기화` 버튼은 확인 없이 레시피 전체를 지운다(되돌리기 없음). | 코드 `resetRecipe()` | M |
| E5 | 헤더 select "예시 레시피 불러오기…"가 현재 레시피를 덮어쓰는데 경고가 없다. | 코드 `loadPreset` | L |

### 2.6 용어 일관성 (한/영 혼용)

| 개념 | 현재 표기(위치) | 통일안 |
|---|---|---|
| 영역 | 전면/후면/베벨/전체, Edge(`stepCells` PES 영역), FRONT/BACK(스택), Front/Back(drawer) | **전면 · 후면 · 베벨 · 전체**. 스택의 섹션 머리만 `FRONT ↑ / BACK ↓` 유지(엑셀식 결정) |
| 기준 위치 | 중심 / center / R=145 | **내측(R145)**. 툴팁에서 처음 한 번만 "Edge에서 5mm"로 설명 |
| Si 손실 | Si 손실 / Si파임 / Si −0.3µm | **Si 손실** |
| 공정 분류 태그 | CLN / PLASMA / WET / [CLN · Plasma] / [REMOVE] | 공정 순서의 `stepCells()[0]` 태그(MOLD, PES, DEPO, ETCH, PLASMA, WET, GAS, CMP, BACK CLN …)를 **모든 곳의 기준**으로 삼는다 |
| 단계 수 | "6 STEPS", "6단계", "6 / 6 단계" | **"6 / 6단계"** |
| Apex 값 없음 | edge 없음 | **"—"** (회색). 빨강은 위험 표시에만 쓴다 |

### 2.7 빈 상태 / 오류 상태

- 빈 상태(`d_empty.png`): 안내가 판정 박스 아래(`#stepNote`)에 작게 있고, 판정 "Bare Si — 공정 전 상태" 옆에 초록 점 하나(Si 손실 0.00)만 켜져 있어 '양호'로 오해할 수 있다. 첫 행동(예시 칩 클릭, 레시피 불러오기)이 강조되지 않는다.
- 오류(`d_err.png`): `#cmdPrev`의 빨간 메시지와 예시는 적절하다. 다만 입력창 테두리는 바뀌지 않는다. → 테두리를 `--danger`로 바꾸는 정도만 추가한다.
- 세부값 오류(`askSubmit`의 `bad`): `.fg.bad` 빨간 테두리가 있어 적절하다. 유지한다.

### 2.8 모바일 375px

| # | 문제 | 근거 |
|---|---|---|
| M1 | 판정이 y≈1,400px에 있어서 확인하려면 화면 3장을 스크롤해야 한다. | `m375_default.png` |
| M2 | 입력창 폭이 약 130px이라 placeholder가 "예: HT-TEOS 8."에서 잘린다. `⋯ 세부`와 `추가` 버튼이 폭의 55%를 차지한다. | `m375_default.png` 상단 |
| M3 | 공정 순서 테이블에 가로 스크롤이 생기고 선택 행의 ✕가 잘린다. | `m375_default.png` y≈1090 |
| M4 | 단면도 높이가 약 200px이라 막이 거의 보이지 않는다(과장 ×32인데도 그렇다). | `m375_default.png` |
| M5 | 세부값 요청 칸이 1열로 펼쳐져 화면 하나를 넘긴다(구분 select는 대부분 자동으로 정해지는 값). | `m375_ask.png` |

### 2.9 참고 (엔진 쪽, 이 설계 범위 밖)

- 같은 레시피에서 Si 손실이 1440px에서는 0.37µm, 375px에서는 0.38µm로 나온다(`render()`의 `ppm`, 즉 화면 폭에 따라 샘플링이 달라짐). 판정 결과가 창 크기에 따라 바뀌면 신뢰도가 떨어진다. backend-dev에게 별도 이슈로 넘긴다.

---

## 3. 목표 레이아웃

### 3.1 원칙

1. **답을 위로**: 판정 줄(Status Bar)을 입력 바로 아래, 단면도 위에 둔다. 서술형 입력 우선 결정은 유지하고, 입력 박스는 1~2줄로 줄인다.
2. **한 곳에 '현재 시점'**: 단계 표시는 Status Bar의 `n / N단계 직후 · 태그 이름` 한 곳에만 둔다.
3. **색은 막질과 위험도에만** 쓴다. "edge 없음"의 빨강, 판정 노트의 빨강 문단 같은 비위험 빨강은 없앤다.
4. **덜어내기**: 상시 노출되는 안내 문장, 범례의 SC 수치, 조작 힌트, 중복 단계 표기, '상세 입력' 폼을 줄인다.

### 3.2 데스크톱 (≥1000px) 와이어프레임

```
┌ header ─────────────────────────────────────────────────────────────────────┐
│ [WEBC] Wafer Edge Simulator                [예시 레시피 ▾] [초기화] [⚙ 고급] │
└─────────────────────────────────────────────────────────────────────────────┘
┌ .p-add (grid-area: add) ────────────────────────────────────────────────────┐
│ 공정 입력  [ 예: HT-TEOS 8.5K 전면만 DEPO                ] [⋯세부] [추가 ↵]  │
│ #cmdPrev: (입력 시에만) ↵ [DEPO] FRONT HT-TEOS 8.5K (0.85µm)                 │
│ 예시 HT-TEOS 8.5K… · PES EE 2.5mm · BEVEL O2 PLASMA 2mm · EE 3mm  [문법?][Gas·약액 표] │
│                                                       6단계 뒤에 삽입(#insAt)│
└─────────────────────────────────────────────────────────────────────────────┘
┌ .p-st  Status Bar (grid-area: st, 전체 폭) ──────────────────────────────────┐
│▌✖ 6 / 6단계 직후 · PLASMA O2 │ Si 0.37µm 손실 · Edge가 내측보다 7.20µm 낮음 · Bare Si 2.5mm 노출 │
│  [✖ Si 손실 0.37µm] [✖ 단차 −7.20µm] [⚠ 막 Bare Si 2.47mm] [● Peeling 0] [● Arcing 낮음]  기준: EE 0mm ✎ │
│  ▸ 이 단계 영향 (#stepNote, 접힘)                                            │
└─────────────────────────────────────────────────────────────────────────────┘
┌ .p-cv (cv) ─────────────────────────────────────┐┌ .p-tl (tl, sticky) ───────┐
│ 단면 (R, mm)          보기 폭 [10][5][3][1][.5]  ││ Layer 스택   내측R145 · Apex│
│┌───────────────────────────────────────────────┐││ FRONT ↑                   │
││ [막 ×10 과장 · Si 47% 축소]          [확대×2 ✕]│││ ▌MOLD ON×48   7.2µm    —  │
││147.0     147.5 ...                 149.5   150 │││ ▌Si sub      775µm        │
││ ← 내측                                  Edge → │││   막 없음                 │
││ ████████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀╮        │││ BACK ↓     (max-height,   │
││ ▒▒ Si (775µm)                         )       │││            내부 스크롤)  │
││ ████████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄╯        │││───────────────────────────│
│└───────────────────────────────────────────────┘││ 공정 순서        6 / 6단계 │
│ 범례(현재 단계에 있는 막만): ■Si ■SiO2 ■SiN     ││ 0 START  Bare Si    775µm │
│                                     드래그 확대 ⓘ││ 1 MOLD   ON×48 7.20µm 전면●│
└─────────────────────────────────────────────────┘│ 2 PES    전 막 제거 2.5mm ✖│
                                                    │ …                         │
                                                    │▶6 PLASMA O2  1500nm 전체 ✖✕│
                                                    └───────────────────────────┘
```

- `.layout` grid-template-areas: `"add add" "st st" "cv tl"` (columns `minmax(0,1fr) 400px`, 기존 유지)
  - 이렇게 바꾸면 A2 버그가 해결된다. `st`가 `tl`과 행을 공유하지 않으므로, `tl`이 길어져도 `cv` 아래는 비어 있을 뿐이고 판정은 밀리지 않는다.
- `.p-tl`: `max-height: calc(100vh - 24px); display:flex; flex-direction:column; overflow:hidden;`
  - `#stack`: `flex: 0 1 auto; max-height: 45%; overflow:auto;`
  - `#stWrap`: `flex: 1 1 auto; min-height:120px; max-height:none; overflow:auto;`
  - 기존 `.p-tl .stbl-wrap{max-height:calc(100vh - 420px)}` 규칙은 삭제한다.

### 3.3 모바일 (<1000px, 기준 375px) 와이어프레임

```
┌ header ─────────────────────────┐
│ [WEBC] Edge Sim    [예시▾][⚙]  │   ← 초기화는 ⚙ drawer 맨 위로 이동 (P1)
├ Status Bar (sticky top:0) ──────┤
│▌✖ 6/6 PLASMA O2                 │
│ Si 0.37µm 손실 · 단차 −7.20µm…  │   ← 1줄 말줄임, 탭하면 칩 펼침
├─────────────────────────────────┤
│ [예: SiN 300nm        ][⋯][↵]  │   ← 버튼은 아이콘만, 입력창 폭 ≥60%
│ 예시 칩 (가로 스크롤 1줄)        │
├─────────────────────────────────┤
│ 단면 [10][5][3][1][.5]          │
│ ┌─────────────────────────────┐ │
│ │[막 ×32 과장 · Si 47% 축소]   │ │   ← 캔버스 min-height 280px
│ │ ...                         │ │
│ └─────────────────────────────┘ │
│ 범례(현재 단계)                  │
├─────────────────────────────────┤
│ 공정 순서 (# · 태그 · 내용 · 값 · ●) │  ← '영역' 열은 '내용' 아래 small로
│ ◀ 이전   6 / 6   다음 ▶         │   ← 단계 이동 버튼 (P1)
├─────────────────────────────────┤
│ Layer 스택                       │
└─────────────────────────────────┘
```

- 모바일 grid-template-areas: `"st" "add" "cv" "tl"` + `.p-st{position:sticky;top:0;z-index:5}`
  - 모바일에서는 Status Bar를 입력보다 위에 sticky로 둔다. 스크롤해도 판정이 항상 보이게 하기 위해서다.
  - 데스크톱(입력 → 판정 → 단면)과 순서가 다른 것은 의도한 것이다. 모바일에서는 sticky이므로 입력 위에 두어도 입력 흐름을 가리지 않는다.
- 모바일에서는 공정 순서를 Layer 스택보다 위에 둔다. 단계를 넘기며 보는 것이 주 동작이기 때문이다. `.p-tl` 내부 순서는 CSS `order`로 바꾼다(아래 P1-6).

---

## 4. 우선순위

### P0 — 꼭 할 것 (합계 반나절 이내, 대부분 덜어내기와 재배치)

| ID | 내용 | 해결 | 예상 |
|---|---|---|---|
| P0-1 | 레이아웃 재배치: Status Bar를 단면도 위 전체 폭으로 옮기고, `.p-tl` 높이를 제한 | A1, A2, A3, M1 | 45분 |
| P0-2 | Status Bar 압축: 판정 1줄 + 위험 칩, `#stepNote`는 접기, N/A 지표는 숨기기 | A5, B1, B2 | 60분 |
| P0-3 | 단면도 표기: 과장 배율 배지, 축 단위와 방향, 조작 힌트 축소 | C1, C2, C7 | 30분 |
| P0-4 | 범례에서 SC 수치를 빼고 현재 단계에 있는 막만 표시 | C3 | 20분 |
| P0-5 | 용어 통일: 단계 이름 하나로, '중심'을 '내측(R145)'로, "edge 없음"을 "—"로 | D1, D2, D3, 2.6 | 40분 |
| P0-6 | 입력 영역 덜어내기: 기본 hint 문장 숨기기, 예시 5개로 줄이기, 오류 시 테두리 | E1, E3, 2.7 | 20분 |
| P0-7 | `초기화`와 예시 레시피 불러오기 전에 `confirm()` | E4, E5 | 10분 |
| P0-8 | 빈 상태: 판정을 중립 회색으로, 안내를 Status Bar에 표시 | 2.7 | 15분 |

### P1 — 다음 (각 0.5~2시간)

| ID | 내용 |
|---|---|
| P1-1 | '상세 입력'(`#detailBox`)을 ⚙ drawer의 "직접 입력(고급)" 섹션으로 옮겨 입력 경로를 2개로 줄인다 (E2) |
| P1-2 | EE를 Status Bar의 '기준' 칩으로 노출하고, 클릭 시 인라인 숫자 입력 → `#eeMm`과 동기화 (B3) |
| P1-3 | Layer 스택: 'Apex에 남은 막만' 토글 + 반복 deck 접기(같은 패턴의 연속 그룹을 "×3"으로) (D2, A3) |
| P1-4 | 공정 순서 열 머리를 다시 표시(`#`, 공정, 내용, 값, 영역, 영향)하고 점 범례 툴팁 추가 (D4) |
| P1-5 | Mold 범례 견본을 줄무늬 그라디언트로, Photo 띠에 "PR" 라벨, Si 라벨 문구 수정 (C4, C5, C6) |
| P1-6 | 모바일: 입력 버튼 아이콘화, 공정 순서 '영역' 열 병합, 가로 스크롤 제거, 캔버스 min-height, ◀▶ 단계 이동 (M2~M4) |
| P1-7 | 모바일 세부값 요청 칸 2열 그리드 + 자동 결정된 '구분' select 숨김 (M5) |

### P2 — 나중에

- P2-1 스택 행 hover ↔ 단면도 층 강조 ↔ 공정 순서 행 강조 연동 (D5)
- P2-2 과장 배율을 화면 폭과 무관하게 고정하는 옵션(`#zScale`을 px/µm 대신 '배율'로 지정). `render()`의 표시 변환만 바꾸고 엔진은 그대로 둔다.
- P2-3 두 단계 비교(전/후 단면 겹쳐 보기)
- P2-4 단면도 PNG 저장 (보안 결정과 무관한 다운로드만 허용, 붙여넣기는 계속 금지)
- P2-5 2.9의 폭 의존 계산 이슈는 backend-dev로 넘긴다

---

## 5. P0 구현 지침 (frontend-dev용)

> 모든 id와 함수명은 현재 `webc_simulator_v3.html`에서 Grep으로 확인했다. 엔진 함수 `simulate`, `metrics`, `impactOf`, `parseCmd`, `deposit`, `etch`, `removal`, `cmp`, `arcRisk`, `bondCheck`의 수식과 판정 임계값은 건드리지 않는다.

### P0-1 레이아웃 재배치

**CSS** (`<style>`의 `.layout` 규칙 2개 교체)

```css
.layout{display:grid;grid-template-columns:minmax(0,1fr);
  grid-template-areas:"st" "add" "cv" "tl";gap:12px;padding:12px;max-width:1600px;margin:0 auto}
.p-st{position:sticky;top:0;z-index:5}               /* 모바일: 판정 고정 */
@media(min-width:1000px){
  .layout{grid-template-columns:minmax(0,1fr) 400px;
    grid-template-areas:"add add" "st st" "cv tl";gap:14px;padding:16px;align-items:start}
  .p-st{position:static}
  .p-tl{position:sticky;top:12px;align-self:start;max-height:calc(100vh - 24px);
    display:flex;flex-direction:column;overflow:hidden}
  .p-tl #stack{flex:0 1 auto;max-height:45%;overflow:auto}
  .p-tl .stbl-wrap{flex:1 1 auto;min-height:120px;max-height:none}
}
```

- 기존 `.p-tl .stbl-wrap{max-height:calc(100vh - 420px);min-height:120px}`는 삭제한다.
- DOM 순서는 바꾸지 않아도 된다(grid-area로 배치). 다만 키보드 탭 순서를 위해 HTML에서 `<!-- 단계 추가 -->` 블록(`.p-add`)을 `.layout`의 첫 자식으로, `.p-st`를 두 번째로 옮기는 것을 권장한다.
- `renderTimeline()` 끝의 선택 행 자동 스크롤(`#stWrap.scrollTop`)은 그대로 동작한다.
- 확인: `loadPreset('cell')` 상태의 1440×1000 화면에서 판정이 y<400에 있고, 단면도 아래에 빈 공간이 없어야 한다(`d_cell.png`와 비교).

### P0-2 Status Bar 압축

**마크업** (`.p-st` 내부 교체)

```html
<div class="box p-st">
  <div class="stbar">
    <div class="verdict" id="verdict">-</div>           <!-- 한 줄, 기존 id 유지 -->
    <span class="sub" id="stAt"></span>                 <!-- "6 / 6단계 직후 · PLASMA O2" -->
  </div>
  <div class="chips" id="inds"></div>                   <!-- 기존 id 유지, 칩 렌더 -->
  <details class="stepnote"><summary>이 단계 영향</summary><div class="note-step" id="stepNote"></div></details>
</div>
```

**CSS**

```css
.p-st{padding:.7rem 1rem}
.stbar{display:flex;align-items:center;gap:.8rem;flex-wrap:wrap}
.p-st .verdict{flex:1;margin:0;font-size:1.02rem;padding:.45rem .7rem}
.chips{display:flex;flex-wrap:wrap;gap:.4rem;margin-top:.5rem}
.chip{display:inline-flex;align-items:center;gap:.35rem;padding:.2rem .55rem;border-radius:999px;
  font-size:.78rem;background:var(--bg);border:1px solid var(--line)}
.chip .k{color:var(--muted)} .chip .v{font-weight:700;font-variant-numeric:tabular-nums}
.chip.l1{border-color:var(--warn)} .chip.l1 .v{color:var(--warn)}
.chip.l2{border-color:var(--danger);background:rgba(239,68,68,.08)} .chip.l2 .v{color:var(--danger)}
.chip .ic{font-size:.72rem}                             /* ✖ ⚠ ● : 색 외 단서 */
.stepnote{margin-top:.4rem}
.stepnote>summary{font-size:.74rem;color:var(--muted);cursor:pointer}
.stepnote .note-step{margin-top:.4rem}
@media(max-width:999px){ .chips{display:none} .p-st.open .chips{display:flex}   /* 모바일: 탭으로 펼침 */
  .p-st .verdict{white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:.9rem} }
```

- 삭제: `.p-st .stgrid` 규칙과 `@media(max-width:700px){.p-st .stgrid…}`, 그리고 `.ind` 계열 규칙(사용처가 없어짐).

**JS** (`edgeStatus()`의 렌더 부분만 수정. 판정 로직인 `I` 배열 생성과 `lvl` 계산은 그대로 둔다)

```js
// 기존 $('inds').innerHTML=I.map(...ind...) 대체
const IC=['●','⚠','✖'];
$('inds').innerHTML=I.filter(x=>x.lvl!==null)            // N/A 숨김 (B2)
  .sort((a,b)=>b.lvl-a.lvl)                               // 위험한 것부터
  .map(x=>`<span class="chip l${x.lvl}" title="${x.k}"><span class="ic">${IC[x.lvl]}</span><span class="k">${CHIP_K[x.k]||x.k}</span><span class="v">${x.v}</span></span>`).join('');
```

- `CHIP_K`는 칩용 짧은 이름표다: `{'Edge 막 상태':'막','Si 손실':'Si 손실','Edge 단차 (vs 중심)':'단차','Peeling 지수 (bevel)':'Peeling','Photo edge pattern':'Photo','Arcing (이 단계)':'Arcing'}`. (P0-5에서 `add()`의 라벨을 바꾸면 키도 함께 맞춘다.)
- 판정 문장(`v.innerText`)은 그대로 둔다. 기존 접두어 `✖ ` / `⚠ ` / `✔ `가 색 외 단서 역할을 한다.
- `$('stAt').innerText`는 `sel<0?'공정 전':`${sel+1} / ${steps.length}단계 직후 · ${태그} ${이름}``로 바꾼다. 태그와 이름은 P0-5의 `stepLabel(st)`를 쓴다.
- 모바일 펼침: `.p-st`에 `onclick="this.classList.toggle('open')"`를 단다(데스크톱에서는 효과 없음).
- `#stepNote`의 내용 생성(`renderTimeline()` 안)은 유지한다. 단, `<div>${stepText(st)}</div>` 줄은 제목과 중복되므로 삭제하고 `⚑ impact`, `⚡ arc` 줄만 남긴다. `.imp` 색은 그대로 둔다(위험도 색이므로 허용).
- 중복 제거(A4): `#stackAt`의 텍스트 출력과 `#cvName`의 "n. … 직후"를 없앤다. `#cvName`은 "단면 <span class=sub>R (mm)</span>"로 고정하고, `#stackAt`은 빈 문자열로 두거나 요소를 삭제한다(`renderStack` 마지막 줄 수정).

### P0-3 단면도 표기 (`draw()`의 라벨 부분만)

1. **과장 배율 배지**: 기존 `ctx.fillText(\`Film·Si손실 수직 ×… 과장\`,8,H-6)`을 삭제하고 DOM 배지로 바꾼다. 캔버스 위에 겹치는 HTML이므로 크기와 대비를 확보할 수 있다.
   - 마크업: `.cvwrap` 안에 `<div id="scaleBadge"></div>` 추가 (`#zbadge`와 대칭인 왼쪽 위)
   - CSS: `#scaleBadge{position:absolute;top:6px;left:8px;background:rgba(15,23,42,.85);border:1px solid var(--warn);color:var(--warn);border-radius:6px;padding:.15rem .45rem;font-size:.72rem;font-weight:600;pointer-events:none}`
   - JS (`draw()` 안 `zbadge` 갱신 옆): `$('scaleBadge').textContent=\`막 두께 ×${Math.round(Z*1000/ppm)} 과장 · Si ${pct}% 축소\``. `pct<100`이 아니면 뒤쪽 문구를 생략한다.
   - 노랑을 쓰는 이유: '실제와 다르다'는 주의 신호이기 때문이다(위험도 색 체계 안에서의 의미). 눈금 텍스트보다 눈에 잘 띄어야 한다.
   - 배지와 겹치지 않도록 눈금 라벨의 y를 12에서 유지하되, 배지 아래 시작선을 고려해 x<배지폭 구간의 첫 라벨은 생략해도 된다(선택).
2. **Si 라벨**: `Bare Si (${T0um}µm…)`를 `Si (${T0um}µm)`로 줄인다. 축소 정보는 배지로 옮겼다. (C6)
3. **축 단위와 방향**: 눈금 루프는 그대로 둔다. 루프 뒤에 `ctx.fillText('← 내측', 4, H-6)`와 오른쪽 끝 `'Edge →'`(우측 정렬)를 `#94a3b8`, 10px로 그린다. 기존 "150 (Edge)" 라벨은 "150"으로 바꾼다. 단위 "R (mm)"은 `#cvName`(P0-2)에 둔다.
4. **조작 힌트(`.zhint`)**: 상시 문장을 삭제하고 `#cvName` 옆에 `<span class="sub" title="드래그 ↘ 확대 · ↖ 축소(한 단계 뒤로) · 더블클릭 원래 크기">ⓘ 확대</span>`로 대체한다. 모바일에서는 드래그가 `touch-action:pan-y`와 충돌하므로 이 ⓘ도 숨긴다(`@media(max-width:999px)`).
5. 보기 폭 seg(`#spanSeg`) 앞에 `<span class="sub">보기 폭</span>` 라벨을 붙인다(`renderTimeline()`의 `spanSeg` 생성 줄).

### P0-4 범례 (`renderLegend()`)

- `<span class="sub">SC …%</span>`와 `planar …%` 출력을 삭제한다. 해당 수치는 drawer의 '막질별 Step Coverage' 표에 이미 있다.
- '현재 단계에 실제로 있는 막만' 표시: `renderLegend()`를 `updateUI()`가 아니라 `draw()` 끝(`renderStack` 호출 근처)에서 호출하고, `used` 계산을 `layers.filter(l=>l.h.some(v=>v>1e-4)).map(l=>l.mat)`의 중복 제거로 바꾼다. `layers`는 `simulate()`가 이미 계산해 둔 결과이므로 엔진은 건드리지 않는다.
  - Mold 줄무늬 안내는 `layers.some(l=>l.thin)`일 때만, Photo 범례는 `PHOTO`가 있을 때만 표시한다.
- `setMat()` 안의 `renderLegend()` 호출은 그대로 두어도 된다(`render()`가 다시 그린다).

### P0-5 용어 통일

1. **단계 이름 하나로**: `stepLabel(st)` 헬퍼를 추가한다. 반환값은 `stepCells(st)[0]`(태그 HTML) + 공백 + `stepCells(st)[1]`(내용)이다.
   - `#cvName`에서 `stepShort(st)` 사용을 없애고(P0-2에 따라 cvName은 '단면' 고정), `#stAt`과 `#stepNote` 제목에 `stepLabel`을 쓴다.
   - `stepText()`는 툴팁(`title`)과 `#cmdPrev` 미리보기에만 남긴다. 단, 앞머리 `[CLN · Plasma]`, `[REMOVE]`는 `stepCells` 태그와 같은 단어로 바꾼다: `[CLN · …]`를 `[PLASMA]/[WET]/[GAS]`로, `[REMOVE] PLASMA EDGE STRIP`을 `[PES]`로.
   - `stepShort()` 사용처 3곳(`renderTimeline`의 `#cvName`, `renderStack`의 행 title, `tipHtml`의 툴팁 단계 줄)을 모두 `stepLabel()`로 바꾼 뒤 `stepShort()`를 삭제한다. title과 툴팁에서는 기존처럼 `.replace(/<[^>]+>/g,'')`로 태그를 벗긴다.
2. **'중심'을 '내측(R145)'로**:
   - `.p-tl` 첫 `.title`의 `<span class="sub">중심 · Apex</span>`를 `내측 R145 · Apex`로 바꾼다.
   - `edgeStatus()`의 `add('Edge 단차 (vs 중심)'…)` 라벨을 `'Edge 단차 (vs 내측)'`로, 메시지 `Edge가 중심보다 …`를 `Edge가 내측보다 …`로 바꾼다(문자열만 변경, 수치와 임계값은 그대로).
   - `impactOf()`의 `· 중심 …`, `중심 영향 없음`도 `내측`으로 바꾼다(문자열만).
   - drawer `측정값 상세`의 "Front THK (R=145)"는 이미 정확하므로 유지한다.
3. **Apex 값 없음**: `renderStack()`의 `'<span class="e x">edge 없음</span>'`를 `'<span class="e">—</span>'`로 바꾼다. `.ly .e.x` 빨강 규칙은 삭제한다(위험이 아닌 정보에 빨강을 쓰지 않는다).
4. **Si 손실**: `stepText()`의 `Si파임`을 `Si 손실`로 바꾼다. drawer `#gPesAdv` 라벨 "Si 파임 (µm, 직접 입력)"도 "Si 손실 (µm, 직접 입력)"로 바꾼다.
5. **단계 수**: `#stepCount`를 `${steps.length}단계`로 바꾼다(현재 "6 steps", CSS uppercase로 "6 STEPS"). '공정 순서' 제목의 부제 "— 누르면 그 시점 (↑↓ 키)"는 유지한다(유용한 조작 안내).
6. **영역 표기**: `stepCells()`의 PES 영역 `'Edge'`를 `'베벨~2.5mm'` 대신 `'Edge'`로 둘지 결정이 필요하다. → **`'Edge'`를 그대로 둔다**. 공정 엔지니어에게는 'Edge'가 PES의 정확한 영역명이다. 나머지는 이미 한국어(전면/후면/베벨/전체)다.

### P0-6 입력 영역 덜어내기

- `cmdPreview()`에서 `!r`(빈 입력)일 때 긴 hint를 지우고 `el.innerHTML=''`로 둔다. `.cmdprev{min-height:1.6em}`는 레이아웃 흔들림 방지를 위해 유지하되, 데스크톱에서는 `min-height:0`으로 바꿔도 된다. 안내 문장의 내용은 `#cmd`의 `title` 속성으로 옮긴다.
- 세부값 칸이 열린 동안(`openAsk` 이후 `#ask` 표시 상태)에는 `#cmdPrev`를 비운다. `openAsk()` 끝에 `$('cmdPrev').innerHTML=''`를 추가하고, `askClose()`에서는 `cmdPreview()`를 다시 호출한다. (E3)
- 예시 칩(`cmdInit()`의 `#exList` 배열)을 5개로 줄인다: `'HT-TEOS 8.5K 전면만 DEPO','MOLD 48단','PES EE 2.5mm','BEVEL O2 PLASMA 2mm','EE 3mm'`. 나머지는 '문법 ?' 안에 이미 있다.
- '상세 입력(모든 파라미터 직접 지정)' `<details id="detailBox">`의 summary 글자를 `.sub` 크기로 줄이고 `예시` 줄 끝으로 옮긴다. 완전 이동은 P1-1에서 한다.
- 오류 표시: `cmdPreview()`에서 `r.err`일 때 `$('cmd').classList.add('bad')`, 그 외에는 `remove('bad')`. CSS `#cmd.bad{border-color:var(--danger)}`.

### P0-7 파괴적 동작 확인

- `resetRecipe()` 맨 앞: `if(steps.length&&!confirm(\`공정 ${steps.length}단계를 모두 지울까요?\`))return;`
- 헤더 `#presetSel`의 `onchange`: `if(steps.length&&!confirm('현재 레시피를 예시로 바꿀까요?')){this.value='';return;}`를 `loadPreset` 앞에 넣는다. 초기 로드(스크립트 끝의 `loadPreset('mold')`)는 함수를 직접 호출하므로 영향이 없다.

### P0-8 빈 상태

- `edgeStatus()`에서 `sel<0`이고 `steps.length===0`일 때:
  - `v.className='verdict l-1'`(이미 회색 테두리)를 유지하고 문구를 `'공정 없음 — 위에 공정을 입력하거나 예시 레시피를 불러오세요'`로 바꾼다.
  - 칩은 렌더하지 않는다(`$('inds').innerHTML=''`). Si 손실 0.00의 초록 점 때문에 '양호'로 오해하는 문제를 없앤다.
- `sel<0`이지만 `steps.length>0`이면(START 행 선택) 문구는 `'공정 전 (Bare Si)'`로 하고 칩은 숨긴다.
- `renderTimeline()`의 `#stepNote` 빈 상태 문구는 Status Bar로 옮겼으므로 `''`로 둔다.

---

## 6. P1 구현 지침 (요약)

- **P1-1** `#detailBox` 전체(`<details class="more" id="detailBox">…</details>`)를 `<aside id="drawer">`의 마지막 `<details>`로 옮기고 summary를 "직접 입력 (모든 파라미터)"로 바꾼다. `addStep()`이 `ins()`를 호출한 뒤 `toggleAdv(false)`를 실행해 결과를 바로 보여준다. `switchTab`과 `#stepType` 등 내부 id는 그대로 쓸 수 있다.
- **P1-2** Status Bar 오른쪽 끝에 `<button class="chip" id="eeChip">EE ${ee}mm ✎</button>`를 둔다. 클릭하면 `<input type=number>`로 바뀌고, change 시 `$('eeMm').value=v; render();`를 실행한다. `cmdEnter()`의 `EE n` 경로와 같은 값을 공유한다.
- **P1-3** `renderStack()`의 그룹 `g`에서 Apex 값(`sum(G,iA)`)이 0인 행에 `.ly.gone{opacity:.45}`를 적용한다. 스택 제목 옆 토글 `[Apex만]`이 켜지면 이 행들을 숨긴다. 반복 deck 접기는 연속된 `(mat,thin)` 시퀀스 해시를 비교해 같은 블록이 반복되면 "×n"으로 접는다(표시 전용).
- **P1-4** `.stbl thead{display:none}`를 제거하고 열 이름을 `# · 공정 · 내용 · 값 · 영역 · 영향 · (빈칸)`으로 한다. 영향 점의 `title`에 `impact.t`를 넣는다.
- **P1-5** `renderLegend()`의 Mold 항목 견본을 `background:repeating-linear-gradient(90deg,#38bdf8 0 3px,#f43f5e 3px 6px)`로 그린다. `drawPhoto()`의 상단 띠 왼쪽에 'PR' 텍스트를 그린다.
- **P1-6** 모바일(`max-width:999px`):
  - `⋯ 세부`와 `추가 ↵` 버튼을 `⋯`, `↵`(width 44px)로 줄이고, 짧은 placeholder `예: SiN 300nm`을 JS로 설정한다(`matchMedia`).
  - `stepCells` 출력의 '영역'(4번째 셀)을 3번째 셀 아래 `<small>`로 합치는 모바일 전용 클래스를 쓴다. `.stbl td{white-space:normal}`로 가로 스크롤을 없앤다.
  - `.p-tl`을 `display:flex;flex-direction:column`으로 하고, 공정 순서 블록(제목 + `#stWrap`)에 `order:-1`을 준다.
  - 단면도 `render()`의 `H` 하한을 모바일에서 280으로 한다(`Math.max(240,…)`의 240 → `innerWidth<1000?280:240`). 표시 높이만 바뀌고 계산에는 영향이 없다.
  - `.p-cv` 아래에 `◀ 이전 / n / N / 다음 ▶` 버튼(`go(sel-1)`, `go(sel+1)`)을 추가한다.
- **P1-7** `.askgrid`에서 `grid-template-columns:repeat(2,minmax(0,1fr))`를 쓴다(≤600px). `ASK.clean`의 'cat'(구분) 필드는 `ASKNEED`에 없고 약액에서 자동으로 정해지면 `.fg.auto{display:none}`로 숨긴다.

---

## 7. 상태별 동작 표 (P0 적용 후)

| 상태 | Status Bar | 단면도 | 스택/순서 | 입력 |
|---|---|---|---|---|
| 공정 없음 | 회색 테두리, "공정 없음 — …", 칩 없음 | Si만, 배지 "Si 47% 축소" | FRONT/BACK "막 없음", START 행만 | 예시 칩 5개, hint 없음 |
| START 선택(공정 있음) | "공정 전 (Bare Si)", 칩 없음 | Si만 | START 행 강조, 나머지 흐리게(`tr.after`) | "맨 앞에 삽입" |
| 단계 선택 · 양호 | 초록 테두리 "✔ Edge 양호 — 특이 위험 없음", 칩 모두 ● | 현재 막, 범례는 현재 막만 | 선택 행 강조 | "n단계 뒤에 삽입" |
| 단계 선택 · 경고/위험 | 노랑/빨강 테두리, 판정 문장, 위험 칩이 앞으로 | 동일 | 행의 ●/⚠/✖ | 동일 |
| 입력 해석 실패 | 변화 없음 | – | – | 빨간 테두리 + `✖ …` 메시지 |
| 값 누락 | 변화 없음 | – | – | `#ask` 열림, 위 미리보기는 비움 |
| 긴 레시피(39단계) | 판정 위치 고정(y<400) | 빈 공간 없음 | 스택은 45% 높이에서 내부 스크롤, 순서도 내부 스크롤 | – |

---

## 8. 검증 방법 (qa-tester용)

1. `design/_shots/t.html#<state>`(원본 + 상태 주입)를 구현 후 원본 기준으로 다시 생성한 뒤, 같은 명령으로 1440×1000과 375 iframe 스크린샷을 찍어 1장의 표와 비교한다.
2. 합격 기준
   - `#cell` 1440×1000: 판정(`#verdict`)과 칩이 첫 화면 안에 보이고 단면도 아래 빈 공간이 100px 미만이다.
   - 375px: 스크롤 위치와 상관없이 판정 줄이 보인다(sticky).
   - 6단계 선택 시 단계 이름이 화면 전체에서 'PLASMA O2' 하나로만 표기된다.
   - 빨간색은 위험 칩, 판정 테두리, `.imp.l2`, 막질 색(SiN, PR)에만 나타난다("edge 없음" 빨강 없음).
   - 과장 배율 배지가 데스크톱과 모바일 모두에서 11px 이상, 노란 테두리로 보인다.
   - `초기화`에서 취소를 누르면 레시피가 유지된다.
3. 엔진 회귀: 같은 레시피에서 `#sSi`, `#sF`, `#sE`, `#sW` 값이 구현 전후로 같아야 한다(같은 창 폭 기준).
