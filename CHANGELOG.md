## 0.25.1
  * [480de7c] Fix a bug in SANDBIN_HOME resolution

## 0.25.0
  * [541a526] Split PATH declaration
  * [4fb9990] Add system commands to PATH
  * [4a6c3a4] Source '.functions' utility functions
  * [640730c] Extract path exports to .paths file
  * [c06030b] Break up sandbin configuration and sandbin bootstrap
  * [f772dd3] Fix a typo in the name of sandbin configuration file
  * [2e45231] Fix a typo in the name of sandbin configuration file
  * [bfa1ec8] Fix a typo in the name of sandbin configuration file
  * [6a62ae8] Fix an issue writing sandbin bootstrap in .zshrc & .bashrc
  
## 0.24.0
  * [fe4d24a] Modify 'git status-short' to add untracked & ignored
  * [eaec94f] Modify sandbash to add output.lib.bash
  * [e78f22c] Add new git-functions.lib.bash library
  * [3f2f778] Extract git alias definitions to a file in dotfiles

## 0.23.0
  * [2481f1d] Add new git alias: 'git status-short'
  * [1cb3b44] Add new git alias: 'git workspace'
  * [e30ea6d] Add new git alias: 'git committers' & 'git mergers'
  * [27e4f37] Add new git alias: 'git author'
  * [235c932] Add new git alias: 'git conflicts'
  * [36192d0] Add new git alias: 'git history-fuller' & 'git history-all-fuller'
  * [85d41b2] Add new git alias: 'git commit --verbose'

## 0.22.0
  * [6464f1b] Move colors configuration at the top of the script
  * [b887a81] Add revision in installation banner
  * [f9aafd0] Modify '.sandbinrc' to add comments
  * [7ff8686] Add *.template as text to default.gitattributes
  * [3f34089] Modified repository .gitattributes file
  * [fd5d699] Extract sandbinrc to a template
  * [58117aa] Modify .gitignore to add sandbinrc
  * [9b13952] Clean up the installation sandbin banner
  * [5fdc02c] Remove the bootstrapping of sandbin when sandbin_home changes

## 0.21.0
  * [c2d38ba] Modify attribution to https://github.com/Danimoth/gitattributes
  * [ad68ffd] Modify git-init colors
  * [f2321ff] Modify colors for git-setup-aliases
  * [5227d05] Modify colors & delete unnecesary code in sandbin-upgrade

## 0.20.2
  * [e27712c] Fix 'sandbash' bug when passing parameters with spaces
  
## 0.20.1
  * [dfd1c92] Modify .gitignore to include .sandbinrc
  * [2fbe817] Fix sandbash parameters calculation

## 0.20.0
  * [7c7e8ce] Add default.gitattributes
  * [67cf982] Modify usage() in git scripts
  * [188ba93] Add command 'git-setup-attributes' to setup .gitattributes in a git repository
  * [e3dcde9] Improve target file calculation in git-setup-attributes
  * [327a428] Fix target_file calculation in git-setup-attributes
  * [4a1573a] Improve git-setup-attributes messages
  * [b6ab3b0] Extract color definitions to colors.lib.bash
  * [ed22dd0] Extract sourcing of colors.lib.sh to .sandbinrc
  * [3b5e59f] Fix GREEN color in colors.lib.bash
  * [d91c0b5] Create a custom launcher 'sandbash' to include custom libs
  * [6e1a8dd] Update scripts to use sandbash
  * [e582390] Add colors.lib.bash to sandbash launcher
  * [7084ea0] Add '.sandbinrc' to '.gitignore' to allow user editions
  * [b3fcab3] Add .gitattributes to avoid problems with crlf
  
## 0.19.0
  * [69bc095] Modify README.md
  * [6588599] Modify README.md
  * [fae5151] Add --sandbin-home & --force-reinstall options in install.sh
  * [4917acf] Fix install.sh min arguments
  * [efbec5e] Extract install_omzsh_plugins() from install.sh
  * [c2fb889] Comment out oh-my-zsh plugins installation
  * [bbf7496] Reveme unnecesary colors in install.sh
  * [b1aba3d] Add .sandbinrc generation
  * [603b68b] Add --revision to install.sh
  * [276f79b] Add a trace in configure_sandbin_bootstrap()
  * [eb31855] Edit .sandbinrc when is not edited yet
  * [b9c6887] Add .sandbinrc final new line
  * [3ee315b] Fix .sandbinrc sandbin home perl substitution
  * [3c88f47] Fix .sandbinrc sandbin home perl substitution
  * [d1c721b] Fix .bashrc location
  * [cfdc78b] Fix bug with .zshrc and .bashrc locations

## 0.18.0
  * [501d28b] Change format in 'history' git aliases
  * [a5f0212] Move 'kill-by-port' & 'system-update' to system directory
  * [5eb7ce2] Move & rename 'upgrade.sh' to 'scripts/sandbin-upgrade'

## 0.17.0
  * [531c2c2] Remove original scripts
  * [6c61027] Change message in install.sh script
  * [710502b] Modify usage instructions in git-init script
  * [d19ce40] Improve git-init result message
  * [ed1355e] Prettify git 'aliases' alias with bold alias name in list
  * [5fbffd8] Update install.sh script
  * [785c81a] Fix & prettify install.sh script

## 0.16.0
  * [95489eb] New 'changed-words' & 'changed-files' aliases
  * [8cc8eb7] New 'changes-staged' alias
  * [3591b4b] New 'assume' alias
  * [26e851a] New 'unassume' alias
  * [6849454] New 'assumed' alias
  * [6a6d472] New 'unassume-all' alias
  * [1851136] New 'assume-all' alias
  * [e65a506] New 'rename-branch' alias
  * [8611148] New 'branch-name' alias
  * [d1c4bf7] Rename to 'branch-rename' alias
  * [a27a784] New 'branch-delete' alias
  * [5090fe3] New 'branch-publish' alias
  * [e1a32a9] New 'branch-unpublish' alias

## 0.15.0
  * [41f2833] Refactor of 'refs' aliases
  * [00bd5be] Change history messages separator
  * [e349b6e] Format code
  * [95ff3f3] Simplify & update 'branches' alias with colors
  
## 0.14.1
  * [cb4183e] Fix 'last-commit' alias

## 0.14.0
  * [ea441bb] Add/modify 'last-tag-id' & 'last-tag' alias
  * [7e6ac0e] Rewrite 'tags' alias to show the subject
  * [04d74ec] Fix 'changelog' alias
  * [1e71f5f] Refactor printing to say method

## 0.13.1
  * [880ce32] Rename from git-aliases to gti-setup-aliases

## 0.13.0
  * [2ed71d7] Add new alias 'history-refs'
  * [275b75b] Add new alias 'history-all-refs'
  * [c1f9e1a] Add new alias 'tags'

## 0.12.0
  * [cb6335d] Add aliases to manage filemode setting
  * [d77cf29] New alias 'history-of <brach|tag|ref>'
  * [abf7784] Add alias 'distance-from-tags'
  * [90ea34d] Fix tab character
  * [020994f] Rename 'alias' alias to 'aliases'
  * [b3b26cc] Modfiy 'history' colors
  * [6a90b83] Add new alais 'first-commit'
  * [4a7ed96] Fix 'last-tag' alias
  * [ac55d00] Modify colors of 'authors' alias
  * [2c765ed] Modify colors of 'changelog' alias
  * [add00b1] Add new 'stage' alias
  * [b3d20de] Change 'last-commit' alias behavior

## 0.11.0
  * [95cd210] Move branch aliases to a new script section
  * [88a6c3f] Add alias to show branch-last-commit

## 0.10.0
  * [5abaad9] Add 'git history-all' alias
  * [ee8eeef] Refactor creation of new aliases in a bash function: 'new_alias'

## 0.9.0
  * [d53b354] Rename git alias 'aliases' to 'list-alias' to fix cygwin bug
  * [79fc53b] Rename git alias 'aliases' to 'list-alias' to fix cygwin bug
  * [4fb34ef] Remove commented dead code
  * [68d497f] Add new upgrade script
  * [6746d20] Modify ASCII art in upgrade.sh script
  * [7a9b63c] Add 'git show-origin-info' alias
  * [1ba72b2] New command 'git branch-activity'
  * [2a35367] Refactor & clean aliases
  * [5105618] New 'git clean-alias' alias

## 0.8.0
  * [c36fb7b] New alias: git push-all
  
## 0.7.0
  * [b352e08] Rename 'create-git-repository' to 'git-create-repository'
  * [1f7f638] New alias: 'git aliases' to list alias
  * [d3f0156] Add new command 'git last-commit' alias

## 0.6.0
  * [eff64ec] New diff aliases: diffstat & changes
  * [e604fe0] Separate git-init into two scripts
  * [44207e0] Modify git-aliases to be executable
  * [ee6986d] Modify 'unstage' alias
  * [5026281] New alias 'git last-tag'
  * [3b48a27] Rename 'git lol' -> 'git history' alias
  * [d002e9b] Modify 'git history' alias colors
  * [2f22d2c] Fix 'git changelog' alias

### 0.5.1
  * [50ae328] Update 'git lol' alias to show author and date
  * [a02fd4d] Revmove '--left-right' flag from alias.lol
  * [eaedc93] Add missing echo message in git init script

### 0.5.0
  * [f68fca3] Add 'Thanks' section in README.md
  * [b6ab90b] Rename 'create-repository' script
  * [e4d091e] Rename 'init' script
  * [942756f] Add scope modifier (ie system, global or local configuration)

### 0.4.0
  * [f4415ac] Move git scripts to a new folder
