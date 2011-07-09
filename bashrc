# Test for an interactive shell. There is no need to set anything past this
# point for scp and rcp, and it is important to refrain from outputting anything
# in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive. Be done now
    return
fi

[[ -r /etc/profile ]]                   && source /etc/profile
[[ -r /etc/bash/bashrc ]]               && source /etc/bash/bashrc

[[ -r ~/.keychain/${HOSTNAME}-sh ]]     && source ~/.keychain/${HOSTNAME}-sh
[[ -r ~/.keychain/${HOSTNAME}-sh-gpg ]] && source ~/.keychain/${HOSTNAME}-sh-gpg

# clear screen once
clear

# cdpath <S> <Z> (CDPATH <S>)
# An array (colon-separated list) of directories specifying the search path for
# the cd command.
export CDPATH=.:~:/

# DIRSTACKSIZE
# The maximum size of the directory stack. If the stack gets larger than this,
# it will be truncated automatically. This is useful with the AUTO_PUSHD option.
export DIRSTACKSIZE=8

# FCEDIT
# The default editor for the fc builtin.
if [[ -x /usr/bin/vim ]] ; then
    export FCEDIT=vim
elif [[ -x /usr/bin/vi ]] ; then
    export FCEDIT=vi
fi

# HISTSIZE <S>
# The maximum number of events stored in the internal history list. If you use
# the HIST_EXPIRE_DUPS_FIRST option, setting this value larger than the SAVEHIST
# size will give you the difference as a cushion for saving duplicated history
# events.
export HISTSIZE=1024

# LANG <S>
# This variable determines the locale category for any category not specifically
# selected via a variable starting with `LC_'.
export LANG=en_US.UTF-8

# LC_ALL <S>
# This variable overrides the value of the `LANG' variable and the value of any
# of the other variables starting with `LC_'.
unset LC_ALL

# LC_COLLATE <S>
# This variable determines the locale category for character collation
# information within ranges in glob brackets and for sorting.
export LC_COLLATE=en_US.UTF-8

# LC_CTYPE <S>
# This variable determines the locale category for character handling functions.
export LC_CTYPE=en_US.UTF-8

# LC_MESSAGES <S>
# This variable determines the language in which messages should be written.
# Note that zsh does not use message catalogs.
export LC_MESSAGES=en_US.UTF-8

# LC_NUMERIC <S>
# This variable affects the decimal point character and thousands separator
# character for the formatted input/output functions and string conversion
# functions. Note that zsh ignores this setting when parsing floating point
# mathematical expressions.
export LC_NUMERIC=de_DE.UTF-8

# LC_TIME <S>
# This variable determines the locale category for date and time formatting in
# prompt escape sequences.
export LC_TIME=de_DE.UTF-8

# LINES <S>
# The number of lines for this terminal session. Used for printing select lists
# and for the line editor.
export LINES=128

# MAIL
# If this parameter is set and mailpath is not set, the shell looks for mail in
# the specified file.
unset MAIL

# MAILCHECK
# The interval in seconds between checks for new mail.
unset MAILCHECK

# mailpath <S> <Z> (MAILPATH <S>)
# An array (colon-separated list) of filenames to check for new mail. Each
# filename can be followed by a `?' and a message that will be printed. The
# message will undergo parameter expansion, command substitution and arithmetic
# expansion with the variable $_ defined as the name of the file that has
# changed. The default message is `You have new mail'. If an element is a
# directory instead of a file the shell will recursively check every file in
# every subdirectory of the element.
unset MAILPATH

# TMOUT
# If this parameter is nonzero, the shell will receive an ALRM signal if a
# command is not entered within the specified number of seconds after issuing a
# prompt. If there is a trap on SIGALRM, it will be executed and a new alarm is
# scheduled using the value of the TMOUT parameter after executing the trap. If
# no trap is set, and the idle time of the terminal is not less than the value
# of the TMOUT parameter, zsh terminates. Otherwise a new alarm is scheduled to
# TMOUT seconds after the last keypress.
if [[ ${TERM} = screen* ]] ; then
    unset TMOUT
else
    export TMOUT=3600
fi

################################################################################
# Aliases
################################################################################
# alias [ {+|-}gmrsL ] [ name[=value] ... ]
# For each name with a corresponding value, define an alias with that value. A
# trailing space in value causes the next word to be checked for alias
# expansion. If the -g flag is present, define a global alias; global aliases
# are expanded even if they do not occur in command position.
#
# If the -s flags is present, define a suffix alias: if the command word on a
# command line is in the form `text.name', where text is any non-empty string,
# it is replaced by the text `value text.name'. Note that name is treated as a
# literal string, not a pattern. A trailing space in value is not special in
# this case. For example,
#
#   alias -s ps=gv
#
# will cause the command `*.ps' to be expanded to `gv *.ps'. As alias expansion
# is carried out earlier than globbing, the `*.ps' will then be expanded. Suffix
# aliases constitute a different name space from other aliases (so in the above
# example it is still possible to create an alias for the command ps) and the
# two sets are never listed together.
#
# For each name with no value, print the value of name, if any. With no
# arguments, print all currently defined aliases other than suffix aliases. If
# the -m flag is given the arguments are taken as patterns (they should be
# quoted to preserve them from being interpreted as glob patterns), and the
# aliases matching these patterns are printed. When printing aliases and one of
# the -g, -r or -s flags is present, restrict the printing to global, regular or
# suffix aliases, respectively; a regular alias is one which is neither a global
# nor a suffix alias. Using `+' instead of `-', or ending the option list with a
# single `+', prevents the values of the aliases from being printed.
#
# If the -L flag is present, then print each alias in a manner suitable for
# putting in a startup script. The exit status is nonzero if a name (with no
# value) is given for which no alias has been defined.

# resetting aliases
unalias -a

###############################################################################
# ulimit
###############################################################################
# ulimit [ -SHacdflmnpstv [ limit ] ... ]
# Set or display resource limits of the shell and the processes started by the
# shell. The value of limit can be a number in the unit specified below or the
# value `unlimited'. By default, only soft limits are manipulated. If the -H
# flag is given use hard limits instead of soft limits. If the -S flag is given
# together with the -H flag set both hard and soft limits. If no options are
# used, the file size limit (-f) is assumed. If limit is omitted the current
# value of the specified resources are printed. When more than one resource
# values are printed the limit name and unit is printed before each value.
#   -a
#       Lists all of the current resource limits.
#   -c
#       512-byte blocks on the size of core dumps.
#   -d
#       K-bytes on the size of the data segment.
#   -f
#       512-byte blocks on the size of files written.
#   -l
#       K-bytes on the size of locked-in memory.
#   -m
#       K-bytes on the size of physical memory.
#   -n
#       open file descriptors.
#   -s
#       K-bytes on the size of the stack.
#   -t
#       CPU seconds to be used.
#   -u
#       processes available to the user.
#   -v
#       K-bytes on the size of virtual memory. On some systems this refers to
#       the limit called `address space'.
ulimit -c 0
ulimit -s 8192

###############################################################################
# umask
###############################################################################
# umask [ -S ] [ mask ]
# The umask is set to mask. mask can be either an octal number or a symbolic
# value as described in man page chmod(1). If mask is omitted, the current value
# is printed. The -S option causes the mask to be printed as a symbolic value.
# Otherwise, the mask is printed as an octal number. Note that in the symbolic
# form the permissions you specify are those which are to be allowed (not
# denied) to the users specified.
umask 077

cd

# load none ZSH components and/or configurations for all shells
for sh in .shell/*.sh; do
    [[ -r ${sh} ]] && source ${sh}
done

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

# vim:filetype=sh textwidth=80
