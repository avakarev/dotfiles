## Bash Startup Files ##
See http://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

#### Invoked as an interactive login shell, or with --login ####
1. "/etc/profile"
2. "~/.bash_profile"
3. "~/.bash_login"
4. "~/.profile"

The `--noprofile` option may be used when the shell is started to inhibit this behavior.

When a login shell exits, Bash reads and executes commands from the file `~/.bash_logout`, if it exists.
