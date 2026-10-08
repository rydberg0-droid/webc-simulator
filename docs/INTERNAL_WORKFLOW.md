# 사내 사용 절차 (외부 → 사내 단방향)

이 저장소는 **외부(public GitHub) → 사내** 방향으로만 흐릅니다. 사내에서 만든 내용은 **어떤 경우에도 외부로 옮기지 않습니다.**

```
[외부] GitHub public ──pull──▶ [사내] 작업 PC ──push──▶ [사내] 사내 git
                                   ✖ 외부 push 차단(remote 설정 + pre-push hook)
```

## 최초 1회
```
git clone https://github.com/rydberg0-droid/webc-simulator
cd webc-simulator
powershell -ExecutionPolicy Bypass -File tools\setup-internal.ps1 <사내 git 주소>
#   (Git Bash) sh tools/setup-internal.sh <사내 git 주소>
git config user.name "<이름>"; git config user.email "<사내 메일>"
git push origin main
```
스크립트를 실행할 수 없으면 아래 명령을 직접 입력합니다.
```
git remote rename origin upstream
git remote set-url --push upstream DISABLED--외부로-push-금지
git remote add origin <사내 git 주소>
git config webc.internalUrl <사내 git 주소>
copy tools\hooks\pre-push .git\hooks\pre-push
```

## 외부 최신 버전 받기
```
powershell -ExecutionPolicy Bypass -File tools\sync-upstream.ps1   # = git fetch upstream + git merge upstream/main
git push origin
```

## 사내 전용 내용
- 사내 실측값·사내 프리셋·사내 규칙은 `internal/` 폴더에만 둡니다(사내 git에만 존재). 외부 업데이트와 충돌하지 않도록 `index.html`은 직접 고치지 않는 것을 원칙으로 합니다.
- (예정) `index.html`이 `internal/overrides.js`가 있으면 읽어 데이터(CLN_DB, SLURRY_DB, 색, 프리셋)를 덮어쓰는 구조를 외부 버전에 추가합니다.

## 금지 사항 체크리스트
- 사내 git 저장소 내용, 사내 데이터, 사내 레시피를 외부 사이트·저장소·AI 서비스에 올리지 않는다.
- `upstream` push 설정과 `.git/hooks/pre-push`를 지우지 않는다.
- 저장 파일(`*.webc.json`) 이름·메모에 제품명·고객사·레시피 번호·설비 ID를 넣지 않는다.
