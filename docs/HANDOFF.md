# 이어받기 문서 (HANDOFF)

다른 PC/세션에서 이어서 작업할 때 가장 먼저 읽는 문서입니다.

## 무엇인가
Wafer Edge 단면에 공정을 쌓아 "지금 Edge가 어떤 상황인지"를 보는 **단일 HTML 도구**(`index.html`, 외부 의존성·네트워크 없음). 실행: 브라우저로 열기 / GitHub Pages.

## 작업 규칙
- `CLAUDE.md`와 `.claude/agents/`의 Sub Agent 순서를 따릅니다: frontend-dev·backend-dev 구현 → qa-tester → code-reviewer → 피드백 반영. 문헌 조사는 researcher → analyst.
- 테스트: 헤드리스 Edge/Chrome에 테스트 스크립트를 주입해 콘솔 에러 0, 예시 레시피 6종 엔진 결과(스냅샷) 불변, 체크포인트 정합을 확인합니다.

## 지켜야 할 결정 (사용자 확정)
- 보안: Excel/클립보드 붙여넣기 import 금지. 외부 API(임베딩 등) 사용 안 함. 입력·데이터를 외부로 보내지 않음. 문헌 값만 사용하고 기밀 표기 자료는 사용 금지. 사내↔외부는 외부→사내 단방향(`docs/INTERNAL_WORKFLOW.md`).
- 저장: `.webc.json`(format 'webc-recipe', version 3) 로컬 파일 저장/불러오기 + 자동 복구, 저장 창 보안 경고.
- 표시: 표시 방식 과장(기본)/실축척/단순, Mold는 ONON 5~6겹(Oxide 파랑, Nitride 녹색), Carbon 보라, W 은색, Cu 구리색.
- 공정 모델: PECVD 전면 증착은 Apex에서 taper, 편심으로 후면 베벨에 살짝 넘어감(후면 평탄부 X) → PES/BVS로 제거. PES는 plasma slope(끝단 전이 0.5mm), wet edge 0.13mm. CMP는 Oxide·W 우선, 패턴/떡판 밀도 단차.
- 로컬 오타 보정은 넣지 않음.

## 엔진 구조 요약
- 계산은 물리 좌표(µm)만 사용, 화면 변환(과장·축소·확대)은 그리기에서만 → 결과가 화면 폭/보기 폭/모드에 불변.
- 단계별 체크포인트(CK) + 구간 dirty로 편집 이후만 재계산. 단계 입력은 STEP_SCHEMA → validateStep 관문 하나.
- 데이터: CLN_DB(세정, 문헌 출처·추정 표시), SLURRY_DB(CMP), EDGE_PROFILE(끝단), ETCH(가정값 *).

## 남은 작업 (backlog)
- 최종 QA·코드 리뷰 지적 반영(진행 중이던 항목).
- `internal/overrides.js` 선택 로드 구조.
- 재사용 회귀 테스트 `tests/` 정리(현재 테스트 하네스는 저장소 밖).
- 프로토타입: 공정 메커니즘 플레이어 + Inner(셀 영역) 패턴 단면 + 결함 주입 → 검증 후 메인 병합 검토.
- 결함 SEM 이미지 기반 원인 추정(규칙 기반 → 학습형)은 검토 단계.
