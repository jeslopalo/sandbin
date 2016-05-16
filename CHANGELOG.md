### v0.45.0 (2016-05-16) - Improve 'gitbox ranking' to save evolution in columns

  * [1644048] Add contributions count in 'gitbox ranking' result
  * [d451ce1] Add spain alterantive ranking
  * [765caab] Add --columnize option in 'gitbox ranking'
  * [031dd2c] Add the possibility to have custom scripts in $HOME/bin


### v0.44.0 (2016-05-15) - Modify several git aliases

  * [14d352b] Add 'sandbin_cosmic' banner
  * [feccd51] Add sandbin_defleppard ascii banner
  * [e93f791] Modify git authoring aliases to prettify the output
  * [19ec5ce] Columnize 'git branches' alias
  * [5bf6b69] Modify 'git push-all' to only push develop, master & tags
  * [63475a2] Modify 'git aliases' to display command in a new line
  * [6be02d1] Update CHANGELOG.md with 0.44.0 changes


### v0.43.0 (2016-05-11) - Fetch before upgrade & other minor changes

  * [eaf7e9b] Add 'cardboard_box.txt' ascii art
  * [f03977b] Add .editorconfig configuration file
  * [32fe428] Modify README.md with more accurate installation instructions
  * [fbd742f] Prettify README.md
  * [9344db6] Fetch from remote repository before upgrade
  * [5591d01] Update CHANGELOG.md with 0.43.0 changes


### v0.42.1 (2016-05-10) - Fix several bugs with sandbin commands

  * [5e30f7d] Fix a bug with a renamed function in sandbin upgrade
  * [a5d138d] Fix 'sandbin version' command to change to SANDBIN_HOME directory
  * [dc772ee] Add a left space in ASCII banners
  * [69de3a5] Update CHANGELOG.md with 0.42.1 changes


### v0.42.0 (2016-05-09) - Add some art to the installation

  * [9fccc7e] Add usage information for errors
  * [eabab75] Add selection of random ASCII arts for sandbin 'version & reload'
  * [2ae53c0] Add function keyword
  * [ad4b3e9] Add ASCII art, sandbin_script
  * [9b736a3] Extract installing functions into sandbin.lib.zsh
  * [c1599be] Update CHANGELOG.md with 0.42.0 changes
  * [20684b8] Add latest version changelog to sandbin version command
  * [8a55c71] Update CHANGELOG.md with 0.42.0 changes


### v0.41.0 (2016-05-08) - Cleaning the code

  * [0595c17] Redirect error messages to stderr
  * [ae17ff3] Remove unused scripts & libs
  * [f01c9b0] Update CHANGELOG.md with 0.41.0 changes


### v0.40.0 (2016-05-07) - Improve documentation of commands

  * [ac7ad6d] Add colors to 'ls' in both Linux & MacOs
  * [0f58aac] Improve sandbin help information
  * [445e3c3] Improve gitbox help information
  * [e1e0a90] Modify error messages in gitbox command
  * [a76567a] Improve 'gitbox init' help information
  * [824a2d6] Fix 'gitbox init' error messages
  * [453b946] Rename 'gitbox init' to 'gitbox initialize'
  * [2521540] Improve 'gitbox ranking' help information
  * [f135a8c] Refactor usage functions to a dedicated lib
  * [a49641a] Improve 'gitbox' help information
  * [6b2a7ca] Update CHANGELOG.md with 0.40.0 changes


### v0.39.0 (2016-05-05) - Add 'gitbox changelog --publish' suboption

  * [0d379d5] Add new 'git changelog --publish <message>' command
  * [30c6e47] Update gitbox changelog completions with --publish options
  * [b1304b9] Update CHANGELOG.md with 0.39.0 changes


### v0.38.0 (2016-05-03) - Add shell aliases to .alias file

  * [9f3a448] New .alias dotfile
  * [6937671] Remove wrong aliases
  * [8173c14] Make zsh know about hosts already accessed by SSH
  * [304c37a] Add -h flag to ls aliases
  * [ad12747] Update CHANGELOG with 0.38.0 changes


### v0.37.1 (2016-04-30) - Fix 'gitbox changelog --all' generation to include the date in the current release

  * [a30904e] Fix to add current date to the current release changelog
  * [5f67d9f] Update CHANGELOG with 0.37.1 changes


### v0.37.0 (2016-04-30) - Minor fixes and refactorings in 'sandbin' & 'git changelog'

  * [78159e9] Extract sandbin subcommands to a dedicated files
  * [f302e1e] Improve serveral messages
  * [7642fb0] Remove unnecesary zstyle command
  * [3529099] Improve sandbin command completions
  * [eac11a1] Remove unnecesary comment
  * [3ff6637] Add a is_a_git_workspace() method & use it
  * [c43c430] Fix 'git tag-subject' alias matching unwanted tags
  * [d4e41f0] Add git_tag_date() & fix git_tag_subject()
  * [218ddb2] Add 'ellipsis()' method to output.lib.sh
  * [97133fa] Modify 'generate_tag_header()' to add tag creation date
  * [9a77eaa] Update CHANGELOG with 0.37.0 changes


### v0.36.0 (2016-04-27) - Minor fixes and refactorings

  * [5a8daf1] Update README.md
  * [08d856f] Add 'colors.lib.zsh' to 'git-functions.lib.zsh'
  * [6e99130] Simplify serveral git aliases
  * [4a2cbe2] Avoid using aliases in gitbox commands
  * [93520b9] Move sandbin.lib.zsh to sandbin commmand folder
  * [93276e9] Rename to update_path_in_config_file()
  * [b150751] Remove scripts directory from PATH
  * [4871ace] Move zstyle configuration to .completions file
  * [5f58e56] Refactor command libs to a dedicated folders
  * [8b7e659] Update CHANGELOG.md with 0.36.0 changes


### v0.35.1 (2016-04-24) - Fix changelog generation without tags

  * [e74b6c6] Check whether there are tags
  * [5e55d7e] Fix changelog generation
  * [27c1208] Update CHANGELOG with 0.35.1 changes


### v0.35.0 (2016-04-24) - Add 'git changelog ranking' command

  * [fddc641] Modify CHANGELOG.md
  * [49bc55f] Add 'gitbox ranking' to get the position in github ranking
  * [9b91935] Add completion for 'gitbox ranking' command
  * [898ce07] Add the option to ask for both locations --madrid, --spain
  * [3f503ba] Modify changelog headers
  * [0113ae3] Update CHANGELOG with 0.35.0 changes


### v0.34.0 (2016-04-22) - Add new 'gitbox changelog --all' command

  * [c63d808] Add 'strip_color_codes()' function
  * [39054ea] Add basic support to generate a complete changelog (--all)
  * [c43b497] Add 'gitbox changelog --all' release_message & help
  * [ee66fb1] Add new git alias 'git tag-commit'
  * [9d50f94] Add '--to-file' suboption to 'gitbox changelog --all' command
  * [6de4801] Update CHANGELOG for v0.34.0


### v0.33.0 (2016-04-20) - Improve 'gitbox changelog' command

  * [4e8122e] Modify 'git distance-from-tag' to exclude --no-merges
  * [d32fb3d] Add new git alias: git tag-subject
  * [82c0e2c] Improve subject generation in gitbox changelog command
  * [a36c6e8] Update CHANGELOG with 0.33.0 changes


### v0.32.0 (2016-04-20) - New aliases & new 'gitbox changelog [--tag <tagname>]' command

  * [74e78fe] New git alias 'git first-commit-id'
  * [922e1b2] Modify 'git changelog' alias to work with first commits
  * [7e24a9e] New git alias 'git last-tag-subject'
  * [3f9cc8a] New git alias 'git distance-from-tag <tag>'
  * [fd42bbb] New command 'gitbox changelog --header <message>'
  * [ca3271f] Change the subject flag in order to not collide with the help flag
  * [7773d5e] Add gitbox subcommand to generate current 'changelog'
  * [62b92a7] Remove commented code
  * [2bad80f] Add gitbox changelog '--tag <tagname>' option
  * [9b32403] Change 'gitbox changelog' colors
  * [dbb3cfe] Remove -s, --subject autocompletion from gitbox changelog
  * [66560ff] Update CHANGELOG with 0.32.0 changes


### v0.31.0 (2016-04-14) - Git server initialization & minor refactoring

  * [66f6f80] Refactor gitbox subcommands to independent files
  * [3d993b3] Apply minor changes in gitbox init
  * [8d26313] Add new 'gitbox init --server' to start a bare shared repository
  * [ea8c572] Update CHANGELOG with 0.31.0 changes


### v0.30.0 (2016-04-12) - New 'gitbox setup attributes' command

  * [c9a8a0e] Add return codes to 'new_alias()' function
  * [ce7a3e1] Fix error codes in gitbox
  * [dac36f5] Add new 'gitbox setup attributes <prefix>' command
  * [387db68] Fix 'gitbox setup attributes --to-dir' bad directory
  * [1f2a160] Add 'gitbox setup attributes' completions
  * [1a2d321] FIX: Update CHANGELOG with 0.29.1 changes
  * [081bab4] Update CHANGELOG with 0.30.0 changes


### v0.29.1 (2016-04-12) - Fix 'gitbox-setup-attibute()' control of errors

  * [29a7802] Fix 'gitbox-setup-attribute()' control of errors


### v0.29.0 (2016-04-11) - Fix git aliases, New git aliases & new gitbox command

  * [2b0e4f9] Modify sandbin.lib extension from bash to zsh
  * [2734d26] Rename colors.lib extension to zsh
  * [3e80675] Modify output.lib extension from bash to zsh
  * [4b759fd] Modify lib extensions from bash to zsh
  * [f1a0e80] Add a WARNING, because replace() function is duplicated
  * [1ea1e44] Fix aliases & author git alias
  * [b151386] Add new git aliases: 'today' & 'today-all'
  * [fe5bfbf] Add git alias to list commits since last pull: 'git commits-since-pull-in'
  * [28202d6] Modify 'history-*' git aliases
  * [7385438] Modify git-setup-aliases usage() message
  * [4dca2ef] Add command 'gitbox init' to initialize git flow repository
  * [f07adc8] Remove 'git' directory from path
  * [840ce81] Add gitbox setup command
  * [d7e89a4] Add new command 'gitbox setup user' to setup user.name in a git repository
  * [8633077] Add new command 'gitbox setup email' to setup user.email in a git repository
  * [f505bfd] Delete exits from new_alias method
  * [c132450] Add scope parameter to new_alias function
  * [34cccec] Add new git alias 'amend-author-since-commit' to amend wrong author
  * [0b9c2e2] Add comment to 'amend-author-since' git alias
  * [a669d14] Remove 'set -e' in sandbash launcher
  * [7d9f21d] Add 'gitbox setup aliases' command
  * [4d00214] Modify 'git changelog' alias to use less -FRX
  * [026bb33] Update CHANGELOG with 0.29.0 changes


### v0.28.0 (2016-04-08) - Automatic load of autocompletion scripts & install from local directory

  * [07e7dd0] Load all of autocompletion files in SANDBIN_HOME/scripts
  * [2a72cf7] Add a feature to install from a local directory (development mode)
  * [ae3075a] Update CHANGELOG with 0.28.0 changes


### v0.27.0 (2016-04-07) - Command completions

  * [06d1a1f] Add color to an error message
  * [d0d0b41] Remove SANDBIN_HOME of the dinamically calculated value. Export is in sandbin.conf
  * [02fab28] Add new colors to scripts
  * [eaefb69] ADd 'sandbin reload' command
  * [c6babe5] Switch from bash to zsh in shebangs
  * [cc2002e] Bootstrap zsh completions
  * [8f553f6] Add sandbin command completions
  * [bb06b6b] Update CHANGELOG with 0.27.0 changes


### v0.26.0 (2016-04-06) - Refactor 'sandbin' commands

  * [9127f23] Update .functions doc
  * [420742e] New command 'sandbin upgrade'
  * [574855c] Add execution rights to sandbin command
  * [c8bb6a8] Add sandbin commands in path & add sandbin args control
  * [903e862] Modify error message
  * [38066f9] Add sandbin_version() function
  * [66acc7c] Fix sandbin branch calculation
  * [8d0a61e] Improve some messages
  * [d50bea6] Move SANDBIN_HOME definition to sandbin.conf
  * [cdf409c] Modify sandbinrc sourcing paths
  * [ccf6e38] Modify sandbinrc sourcing paths
  * [dcfa8eb] Modify sandbinrc sourcing paths
  * [be6f640] Modify a trace message
  * [54fcff3] Calculate branch to upgrade in sandbin_upgrade()
  * [2def4ef] Remove print_sandbin_banner() invocation in sandbin_reload()
  * [075dedd] Fix infinite loop in sandbin command with unknown command
  * [374f846] Delay command execution until all arguments are read
  * [25f0389] Fix sandbin command execution
  * [7b7e898] Fix sandbin command execution
  * [88da07d] Fix sandbin command execution
  * [483b808] Fix sandbin command execution
  * [3d209e1] Fix sandbin command execution
  * [da735de] Fix sandbin command execution
  * [99ce888] Update CHANGELOG with 0.26.0 changes


### v0.25.1 (2016-04-05) - Fix a bug in SANDBIN_HOME resolution

  * [480de7c] Fix a bug in SANDBIN_HOME resolution
  * [0cd8e32] Update CHANGELOG with 0.25.1 changes


### v0.25.0 (2016-04-05) - Break up sandbin configuration and sandbin bootstrap

  * [541a526] Split PATH declaration
  * [4fb9990] Add system commands to PATH
  * [4a6c3a4] Source '.functions' utility functions
  * [640730c] Extract path exports to .paths file
  * [c06030b] Break up sandbin configuration and sandbin bootstrap
  * [f772dd3] Fix a typo in the name of sandbin configuration file
  * [2e45231] Fix a typo in the name of sandbin configuration file
  * [bfa1ec8] Fix a typo in the name of sandbin configuration file
  * [6a62ae8] Fix an issue writing sandbin bootstrap in .zshrc & .bashrc
  * [f328d9e] Update CHANGELOG with 0.25.0 changes


### v0.24.0 (2016-04-04) - Extract git alias definitions to a dotfile

  * [fe4d24a] Modify 'git status-short' to add untracked & ignored
  * [eaec94f] Modify sandbash to add output.lib.bash
  * [e78f22c] Add new git-functions.lib.bash library
  * [3f2f778] Extract git alias definitions to a file in dotfiles
  * [9dd8f64] Update CHANGELOG with 0.24.0 changes


### v0.23.0 (2016-04-03) - New git aliases

  * [2481f1d] Add new git alias: 'git status-short'
  * [1cb3b44] Add new git alias: 'git workspace'
  * [e30ea6d] Add new git alias: 'git committers' & 'git mergers'
  * [27e4f37] Add new git alias: 'git author'
  * [235c932] Add new git alias: 'git conflicts'
  * [36192d0] Add new git alias: 'git history-fuller' & 'git history-all-fuller'
  * [85d41b2] Add new git alias: 'git commit --verbose'
  * [cace34f] Update CHANGELOG with 0.23.0 changes


### v0.22.0 (2016-04-03) - Revision in banner, sandbinrc.template & clean/update sandbin bootstrap from shells

  * [6464f1b] Move colors configuration at the top of the script
  * [b887a81] Add revision in installation banner
  * [f9aafd0] Modify '.sandbinrc' to add comments
  * [7ff8686] Add *.template as text to default.gitattributes
  * [3f34089] Modified repository .gitattributes file
  * [fd5d699] Extract sandbinrc to a template
  * [58117aa] Modify .gitignore to add sandbinrc
  * [9b13952] Clean up the installation sandbin banner
  * [5fdc02c] Remove the bootstrapping of sandbin when sandbin_home changes
  * [6388fde] Update CHANGELOG with 0.22.0 changes


### v0.21.0 (2016-04-02) - Improve the colors of messages in scripts

  * [c2d38ba] Modify attribution to https://github.com/Danimoth/gitattributes
  * [ad68ffd] Modify git-init colors
  * [f2321ff] Modify colors for git-setup-aliases
  * [5227d05] Modify colors & delete unnecesary code in sandbin-upgrade
  * [b8e461b] Update CHANGELOG with 0.21.0 changes


### v0.20.2 (2016-04-02) - Fix 'sandbash' bug with parameters

  * [e27712c] Fix 'sandbash' bug when passing parameters with spaces
  * [6b352a1] Update CHANGELOG with 0.20.2 changes


### v0.20.1 (2016-04-02) - Fix a problem with parameters calculation in sandbash launcher

  * [dfd1c92] Modify .gitignore to include .sandbinrc
  * [2fbe817] Fix sandbash parameters calculation
  * [889b6ef] Update CHANGELOG with 0.20.1 changes


### v0.20.0 (2016-04-02) - .gitattributes, git-setup-attributes command, script colors, ignore .sandbinrc & sandbash launcher

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
  * [ba6d5c5] Update CHANGELOG with 0.20.0 changes


### v0.19.0 (2016-04-01) - sandbin settings

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
  * [84cd561] Update CHANGELOG with 0.19.0 changes


### v0.18.0 (2016-03-29) - Minor changes & new system commands group

  * [501d28b] Change format in 'history' git aliases
  * [a5f0212] Move 'kill-by-port' & 'system-update' to system directory
  * [5eb7ce2] Move & rename 'upgrade.sh' to 'scripts/sandbin-upgrade'
  * [6e3d8af] Update CHANGELOG for v0.18.0


### v0.17.0 (2016-03-29) - Prettifying things

  * [531c2c2] Remove original scripts
  * [6c61027] Change message in install.sh script
  * [710502b] Modify usage instructions in git-init script
  * [d19ce40] Improve git-init result message
  * [ed1355e] Prettify git 'aliases' alias with bold alias name in list
  * [5fbffd8] Update install.sh script
  * [785c81a] Fix & prettify install.sh script
  * [2b40032] Update changelog for v0.17.0


### v0.16.0 (2016-03-25) - New aliases for diff, assume-unchanged & branches operations

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
  * [d291621] Edit CHANGELOG.md with 0.16.0 changes


### v0.15.0 (2016-03-24) - New 'refs' git aliases & changes in 'branches' & 'history'

  * [41f2833] Refactor of 'refs' aliases
  * [00bd5be] Change history messages separator
  * [e349b6e] Format code
  * [95ff3f3] Simplify & update 'branches' alias with colors
  * [f542eb0] Update changelog for v0.15.0


### v0.14.1 (2016-03-23) - Fix 'last-commit' git alias

  * [cb4183e] Fix 'last-commit' alias


### v0.14.0 (2016-03-22) - New alias 'last-tag-id' and bug fixes

  * [ea441bb] Add/modify 'last-tag-id' & 'last-tag' alias
  * [7e6ac0e] Rewrite 'tags' alias to show the subject
  * [04d74ec] Fix 'changelog' alias
  * [1e71f5f] Refactor printing to say method
  * [b612be5] Edit CHANGELOG.md with 0.14.0 changes


### v0.13.1 (2016-03-21) - Rename 'git-alias' script

  * [880ce32] Rename from git-aliases to gti-setup-aliases
  * [fe08898] Modify CHANGELOG.md to complente version changes


### v0.13.0 (2016-03-20) - Alias for tags and refs

  * [2ed71d7] Add new alias 'history-refs'
  * [275b75b] Add new alias 'history-all-refs'
  * [c1f9e1a] Add new alias 'tags'
  * [d7bb227] Modify CHANGELOG.md for the new version


### v0.12.0 (2016-03-18) - New aliases

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
  * [4b922d7] Update changelog for v0.12.0


### v0.11.0 (2015-11-05) - New 'git branch-last-commit' alias

  * [95cd210] Move branch aliases to a new script section
  * [88a6c3f] Add alias to show branch-last-commit
  * [cf1d8b4] Update changelog


### v0.10.0 (2015-10-26) - New history-all alias

  * [5abaad9] Add 'git history-all' alias
  * [ee8eeef] Refactor creation of new aliases in a bash function: 'new_alias'
  * [d6dfadb] Update CHANGELOG.md


### v0.9.0 (2015-10-21) - New aliases & refactorings

  * [d53b354] Rename git alias 'aliases' to 'list-alias' to fix cygwin bug
  * [79fc53b] Rename git alias 'aliases' to 'list-alias' to fix cygwin bug
  * [4fb34ef] Remove commented dead code
  * [68d497f] Add new upgrade script
  * [6746d20] Modify ASCII art in upgrade.sh script
  * [7a9b63c] Add 'git show-origin-info' alias
  * [1ba72b2] New command 'git branch-activity'
  * [2a35367] Refactor & clean aliases
  * [5105618] New 'git clean-alias' alias
  * [c7f5f8d] Add changelog info for 0.9.0 version


### v0.8.0 (2015-10-19) - New aliase

  * [c36fb7b] New alias: git push-all
  * [45264c5] Complete 0.8.0 changelog


### v0.7.0 (2015-10-19) - New aliases

  * [b352e08] Rename 'create-git-repository' to 'git-create-repository'
  * [1f7f638] New alias: 'git aliases' to list alias
  * [d3f0156] Add new command 'git last-commit' alias
  * [bc18e4f] Modify changelog to README.md
  * [049011d] Extract changelog section to a dedicated file: CHANGELOG.md


### v0.6.0 (2015-10-18) - New aliases and fixes

  * [eff64ec] New diff aliases: diffstat & changes
  * [e604fe0] Separate git-init into two scripts
  * [44207e0] Modify git-aliases to be executable
  * [ee6986d] Modify 'unstage' alias
  * [5026281] New alias 'git last-tag'
  * [3b48a27] Rename 'git lol' -> 'git history' alias
  * [d002e9b] Modify 'git history' alias colors
  * [2f22d2c] Fix 'git changelog' alias
  * [ba4805a] Complete README.md with changelog


### v0.5.1 (2015-10-15) - Minor fixes and changes

  * [50ae328] Update 'git lol' alias to show author and date
  * [a02fd4d] Revmove '--left-right' flag from alias.lol
  * [eaedc93] Add missing echo message in git init script
  * [c5d9ebb] Add 0.5.1 commits to changelog


### v0.5.0 (2015-10-14) - Scripts renaming & scope definition

  * [f68fca3] Add 'Thanks' section in README.md
  * [b6ab90b] Rename 'create-repository' script
  * [e4d091e] Rename 'init' script
  * [942756f] Add scope modifier (ie system, global or local configuration)
  * [229cbcd] Complete changelog in README


### v0.4.0 (2015-10-06) - Refactored git scripts

  * [f4415ac] Move git scripts to a new folder
  * [390f975] Add version changelog


### v0.3.0 (2015-10-06) - git authors & git changelog aliases

  * [ae1d3d8] Remove unused git-changelog script
  * [d4f560c] Update version in README.md
  * [cb7647a] Add --decorate --color to 'git changelog' alias
  * [fad6049] Add new alias: 'git authors'
  * [735229c] Modify 'git changelog' alias to show commit hashes and exclude merge commits
  * [509caa9] Add version 0.3.0 changelog to README.md


### v0.2.0 (2015-10-06) - New Git & system scripts

  * [135208c] Next development version 0.2.0-snapshot
  * [3c5639b] .gitignore and install.sh
  * [1185065] Nuevo oneliner para generar changelog. Estudiar
  * [5abd147] New actualiza command
  * [af5d145] actualiza is renamed to system-update
  * [d7985c5] Intellij project files should be ignored
  * [7616921] New script to create GIT repositories
  * [56f0059] New script to kill processes by port
  * [f238302] Add a script to initialize properties and aliases in Git repositories
  * [9001f32] Add 'git changelog' alias
  * [f83d111] Add new version and changelog to README.md


### v0.1.0 (2015-03-04) - Initial version 0.1.0

  * [ce8f728] Original scripts to be migrated
  * [4529873] Original oh-my-zsh plugins to be migrated
  * [8b83c67] Deleted some lines
  * [6854539] First oh-my-zsh plugin
  * [c56d094] New install script
  * [082dbef] Installer renaming
  * [bd0ccff] Installer renaming
  * [5328b94] Renaming
  * [1fd4276] Installing oh-my-zsh plugins
  * [2cace3b] Install instructions
  * [8bf5b2a] Install script is a zsh script
  * [54a55f5] Ignoring *~ files
  * [e310929] New iteration
  * [b8dde9b] New improvement
  * [1c4f702] Git changelog script
  * [2d40dbb] New release 0.1.0


