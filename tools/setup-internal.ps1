# 사내 PC 최초 1회 설정 (외부 -> 사내 단방향)
# 사용: powershell -ExecutionPolicy Bypass -File tools\setup-internal.ps1 <사내 git 주소>
param([Parameter(Mandatory=$true)][string]$Internal)
$ErrorActionPreference = 'Stop'
$Public = 'https://github.com/rydberg0-droid/webc-simulator.git'
$remotes = git remote
if ($remotes -contains 'upstream') { git remote set-url upstream $Public }
elseif ($remotes -contains 'origin') { git remote rename origin upstream }
else { git remote add upstream $Public }
git remote set-url --push upstream 'DISABLED--외부로-push-금지'
if ((git remote) -contains 'origin') { git remote set-url origin $Internal } else { git remote add origin $Internal }
git config webc.internalUrl $Internal
Copy-Item tools\hooks\pre-push .git\hooks\pre-push -Force
Write-Host "설정 완료: origin=사내($Internal), upstream=외부(가져오기 전용, push 차단)"
Write-Host "커밋 작성자를 사내 계정으로: git config user.name '<이름>'; git config user.email '<사내메일>'"
