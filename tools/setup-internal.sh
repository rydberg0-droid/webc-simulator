#!/bin/sh
# 사내 PC 최초 1회 설정 (외부 → 사내 단방향)
# 사용: sh tools/setup-internal.sh <사내 git 주소>
set -e
[ -n "$1" ] || { echo "사용: sh tools/setup-internal.sh <사내 git 주소>"; exit 2; }
INTERNAL="$1"
PUBLIC="https://github.com/rydberg0-droid/webc-simulator.git"
if git remote get-url upstream >/dev/null 2>&1; then git remote set-url upstream "$PUBLIC"; else git remote rename origin upstream 2>/dev/null || git remote add upstream "$PUBLIC"; fi
git remote set-url --push upstream "DISABLED--외부로-push-금지"
if git remote get-url origin >/dev/null 2>&1; then git remote set-url origin "$INTERNAL"; else git remote add origin "$INTERNAL"; fi
git config webc.internalUrl "$INTERNAL"
cp tools/hooks/pre-push .git/hooks/pre-push && chmod +x .git/hooks/pre-push
echo "✔ 설정 완료: origin=사내($INTERNAL), upstream=외부(가져오기 전용, push 차단)"
echo "  커밋 작성자를 사내 계정으로: git config user.name '<이름>'; git config user.email '<사내메일>'"
