# 외부(public) 최신 버전을 받아 사내 브랜치에 합친다. 충돌 시 멈춘다.
$ErrorActionPreference = 'Stop'
git fetch upstream
git merge --no-edit upstream/main
if ($LASTEXITCODE -ne 0) { Write-Host "충돌: 'git status'로 파일 확인 후 해결하세요. internal/ 폴더는 사내 전용입니다."; exit 1 }
Write-Host "외부 최신 반영 완료. 사내 git으로 올리려면: git push origin"
