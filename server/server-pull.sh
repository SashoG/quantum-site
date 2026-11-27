#!/bin/sh
# Faculty server deploy script (ARCHITECTURE.md §11.3).
# Runs from cron as the site's own Unix user, never as root.
#
# One-time setup:
#   git clone --bare --single-branch --branch deploy \
#     https://github.com/<org>/quantum-site.git /srv/quantum-site.git
#   git --git-dir=/srv/quantum-site.git config core.symlinks false
#
# Cron (site user):  */5 * * * * /srv/scripts/server-pull.sh
set -eu
GIT_DIR=/srv/quantum-site.git          # outside docroot
WORK_TREE=/var/www/quantum             # docroot (confirm with sysadmin)
export GIT_DIR

# A bare clone has no remote-tracking refs: fetch explicitly into origin/deploy.
# `+` because the deploy branch is force-pushed (one commit per build).
git fetch --quiet origin +refs/heads/deploy:refs/remotes/origin/deploy

# Last commit written to the docroot (empty on first run → full deploy).
STATE="$GIT_DIR/DEPLOYED"
new=$(git rev-parse refs/remotes/origin/deploy)
old=$(cat "$STATE" 2>/dev/null || true)

if [ "$new" != "$old" ]; then
  git --work-tree="$WORK_TREE" reset --hard --quiet "$new"
  # Keep ACME (Let's Encrypt) webroot challenges if the sysadmin uses them.
  git --work-tree="$WORK_TREE" clean -fdq -e /.well-known/
  echo "$new" > "$STATE"
fi
