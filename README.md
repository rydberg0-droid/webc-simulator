# WEBC Wafer Edge Simulator

Wafer Edge 단면에 공정을 쌓아 가며 **지금 Edge가 어떤 상황인지**(막 덮임/노출, Si 손실, 단차, Peeling, Arcing 등)를 직관적으로 보는 단일 HTML 도구입니다.

- 실행: `index.html`을 브라우저로 열기 (외부 의존성·네트워크 없음) · GitHub Pages: https://rydberg0-droid.github.io/webc-simulator/
- 입력 예: `HT-TEOS 8.5K 전면만 DEPO` · `BSN 3K` · `BS LAL 5s` · `PES EE 2.5mm` · `BVO 1K 2mm` · `EE 3mm` · `MOLD 48단`
- 조작: 드래그 ↘ 확대 / ↖ 축소 · Space·우클릭 드래그 이동 · 더블클릭 원래 크기 · 모바일은 두 손가락 핀치/이동
- 표시 방식: 과장(기본) / 실축척 / 단순

## Defect Simulator (프로토타입)
- `defect_simulator/index.html` · https://rydberg0-droid.github.io/webc-simulator/defect_simulator/
- Inner(셀 영역) 패턴 단면에서 Mold flow를 동영상처럼 재생하고, 특정 시점·위치에 결함을 떨어뜨려 이후 공정에서의 형상(hole not-open/blocked 등)을 봅니다.
- **추정 모델 프로토타입**입니다(값은 예시·추정, QA·리뷰 전). 수정 예정 항목이 많습니다.

## 데이터
세정·식각률과 선택비는 공개 논문·특허 값이며, 출처와 추정(*) 여부를 앱의 "Gas·약액 표"와 `research/`에 적어 두었습니다. 실제 양산 설비의 절대값과는 다를 수 있습니다.

## 문서
- 이어받기: `docs/HANDOFF.md` · 사내(외부→사내 단방향) 사용: `docs/INTERNAL_WORKFLOW.md`

## 폴더
- `index.html` — 최신 시뮬레이터 (v3)
- `legacy/webc_simulator_v2.html` — 이전 버전
- `research/` — 문헌 조사·분석 노트
- `CLAUDE.md`, `.claude/agents/` — 개발에 쓴 작업 규칙과 Sub Agent 정의
- `tools/` — 사내 단방향 설정·동기화 스크립트, push 차단 hook
