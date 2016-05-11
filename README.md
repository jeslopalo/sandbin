# sandbin

Just my own shell scripts for everyday work

# Changelog

See version changes in [CHANGELOG.md](CHANGELOG.md)

# Installation

Download and execute ```install.sh``` from repository
```zsh
» wget --no-check-certificate https://raw.githubusercontent.com/jeslopalo/sandbin/master/install.sh -O - | zsh
```

Then the latests version will be installed
```zsh
» wget --no-check-certificate https://raw.githubusercontent.com/jeslopalo/sandbin/master/install.sh -O - | zsh
--2016-05-11 17:13:16--  https://raw.githubusercontent.com/jeslopalo/sandbin/master/install.sh
Resolving raw.githubusercontent.com... 185.31.17.133
Connecting to raw.githubusercontent.com|185.31.17.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2175 (2.1K) [text/plain]
Saving to: 'STDOUT'

- 100%[==============================================================================================>]   2.12K  --.-KB/s    in 0s

2016-05-11 17:13:17 (17.3 MB/s) - written to stdout [2175/2175]

Installing sandbin in '/Users/jeslopalo/.sandbin' directory...
Cloning sandbin...
Cloning into '/Users/jeslopalo/.sandbin'...
remote: Counting objects: 2001, done.
remote: Compressing objects: 100% (247/247), done.
remote: Total 2001 (delta 131), reused 8 (delta 8), pack-reused 1741
Receiving objects: 100% (2001/2001), 274.87 KiB | 155.00 KiB/s, done.
Resolving deltas: 100% (1195/1195), done.
Checking connectivity... done.
Copying sandbin.conf file to '/Users/jeslopalo/.sandbin'...
Replacing 'sandbinhome' with '/Users/jeslopalo/.sandbin' in '/Users/jeslopalo/.sandbin/sandbin.conf' file
The sandbin bootstrap is already configured in '/Users/jeslopalo/.zshrc'

                                              oooo oooo       o88
     oooooooo8    ooooooo   oo oooooo    ooooo888   888ooooo  oooo  oo oooooo
    888ooooooo    ooooo888   888   888 888    888   888    888 888   888   888
            888 888    888   888   888 888    888   888    888 888   888   888
    88oooooo88   88ooo88 8o o888o o888o  88ooo888o o888ooo88  o888o o888o o888o

                                                               revision: 0.42.1
Hooray! Sandbin has been installed.
Please, reload your shell session!
```
