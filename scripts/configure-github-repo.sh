#!/usr/bin/env bash
# Apply merge rules and branch protection via GitHub API (requires gh + admin on repo).
# Usage:
#   gh auth login   # once, with a token that can change repo settings
#   ./scripts/configure-github-repo.sh [OWNER/REPO] [BRANCH]
# Defaults: nehasoni27/ziphq and master
set -euo pipefail

REPO="${1:-nehasoni27/ziphq}"
BRANCH="${2:-master}"

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI: https://cli.github.com/  then: gh auth login"
  exit 1
fi

echo "==> Merge buttons: disable merge commits; allow squash and rebase (${REPO})"
gh api "repos/${REPO}" -X PATCH \
  -f allow_merge_commit=false \
  -f allow_squash_merge=true \
  -f allow_rebase_merge=true

echo "==> Branch protection: ${BRANCH} (1 review, CI check, linear history)"
# CI must have run at least once so the 'CI' check exists, or this may return 422.
gh api "repos/${REPO}/branches/${BRANCH}/protection" -X PUT --input - <<EOF
{
  "required_status_checks": {
    "strict": true,
    "checks": [
      {
        "context": "CI",
        "app_id": null
      }
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF

echo "Done. Verify: https://github.com/${REPO}/settings/branches"
