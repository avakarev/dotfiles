Configuration Files
===================
See http://zsh.sourceforge.net/Intro/intro_3.html

Zsh has several system-wide and user-local configuration files.

System-wide configuration files are installation-dependent but are installed
in */etc* by default.

User-local configuration files have the same name as their global counterparts
but are prefixed with a dot (hidden). Zsh looks for these files in the user\'s home directory
by default. To make it look in another directory, set the parameter ZDOTDIR to where you\'d like zsh to look.

When zsh starts up, the configuration files are read in the following order:
----------------------------------------------------------------------------

1. zshenv:   "/etc/zshenv", "~/.zshenv"
2. zprofile: "/etc/zprofile", "~/.zprofile" # if the shell is a login shell
3. zshrc:    "/etc/zshrc", "~/.zshrc"       # if the shell is interactive
4. zlogin:   "/etc/zlogin", "~/.zlogin"     # if the shell is a login shell

When a user logs out, /etc/zlogout is read, followed by ZDOTDIR/.zlogout.

A login shell is generally one that is spawned at login time.
(IE, by either /bin/login or some other daemon that handles incoming connections).
If you telnet, rlogin, rsh, or ssh to a host, chances are you have a login shell.
An interactive shell is one in which prompts are displayed and the user types
in commands to the shell. (IE, a tty is associated with the shell)

For example, if I run the command

```
    ssh SOME_HOST some_command
```

I will be running (presumably) a non-interactive program called some_command.
This means that zsh will not be an interactive shell, and ignore the corresponding files.
Zsh should, however, be a login shell, and read the appropriate files.

### zshenv

This file is sourced by all instances of Zsh, and thus, it should be kept as
small as possible and should only define environment variables.

### zprofile

This file is similar to zlogin, but it is sourced before zshrc. It was added
for [KornShell][1] fans. See the description of zlogin bellow for what it may
contain.

zprofile and zlogin are not meant to be used concurrently but can be done so.

### zshrc

This file is sourced by interactive shells. It should define aliases,
functions, shell options, and key bindings.

### zlogin

This file is sourced by login shells after zshrc, and thus, it should contain
commands that need to execute at login. It is usually used for messages such as
[fortune][2], [msgs][3], or for the creation of files.

This is not the file to define aliases, functions, shell options, and key
bindings. It should not change the shell environment.

### zlogout

This file is sourced by login shells during logout. It should be used for
displaying messages and the deletion of files.
