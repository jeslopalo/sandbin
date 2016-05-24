#!/usr/bin/env bash

# \ls  -l **/**.zsh | tr -s ' ' | cut -d ' ' -f 9 | xargs -n 1 -I {} echo "source {}"
source scripts/bump/lib/bump.lib.zsh
source scripts/bump/lib/bump.version.zsh
source scripts/gitbox/lib/gitbox.changelog.zsh
source scripts/gitbox/lib/gitbox.initialize.zsh
source scripts/gitbox/lib/gitbox.lib.zsh
source scripts/gitbox/lib/gitbox.ranking.zsh
source scripts/gitbox/lib/gitbox.setup.zsh
source scripts/lib/colors.lib.zsh
source scripts/lib/git-functions.lib.zsh
source scripts/lib/lang.lib.zsh
source scripts/lib/maven.lib.zsh
source scripts/lib/moustache.lib.zsh
source scripts/lib/omzsh.lib.zsh
source scripts/lib/output.lib.zsh
source scripts/lib/path.lib.zsh
source scripts/lib/usage.lib.zsh
source scripts/sandbin/lib/sandbin.lib.zsh
source scripts/sandbin/lib/sandbin.reload.zsh
source scripts/sandbin/lib/sandbin.upgrade.zsh
source scripts/sandbin/lib/sandbin.version.zsh
