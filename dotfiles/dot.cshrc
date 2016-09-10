
alias	a	alias


# ------------------------------------------------------------------
#			common setting
# ------------------------------------------------------------------
umask 022
setenv	BLOCKSIZE	K
set history=1000
set savehist=1000
set noclobber
set filec
set autolist
set autocorrect
unset autologout
set notify
setenv PAGER less
set nobeep

# ------------------------------------------------------------------
#		    Linux only
# ------------------------------------------------------------------
limit coredumpsize 0	
setenv LANG en_GB.UTF-8

set path = (. ~/bin ~/bin/depot_tools /usr/local/bin /bin /usr/bin /usr/sbin /sbin)
setenv EDITOR vi

#set prompt = "<<`hostname -s`>>\[`id -nu`\]\:"
#30:black, 31:red, 32:green, 33:yellow, 34:blue, 35:magenta, 36:cyan
##original##
#set prompt = "[`id -nu`@%B`hostname -s`%b %c \!] "

##e.g foreground:red, background:blue (http://uguisu.skr.jp/Windows/cshrc.html)
## $ PS1="\[\033[44;1;31m\][\u@\h:\W]$ "   <-41:red, 44:blue
## 
set prompt = "[%{\e[46;1;30m%}`id -nu`@%B`hostname -s`%b  %{\e[42;1;30m%}%c%{\e[0m%} \!]%{\e[0m%} "
   

a chp 'set prompt = "%{\e[01;0m%}<<`id -nu`@`hostname -s`>>%{\e[0m%}"'

# ------------------------------------------------------------------
#			key bind change
# ------------------------------------------------------------------
bindkey '' backward-delete-word   # C-w: del word before cursor
bindkey '' backward-kill-line	    # C-u: del line before cursor
bindkey '' i-search-back			# C-r: incremental search history

bindkey -k up history-search-backward
bindkey -k down history-search-forward

bindkey "^p"  history-search-backward
bindkey "^n"  history-search-forward
bindkey "^w"  spell-line


# ------------------------------------------------------------------
#			proxy
# ------------------------------------------------------------------
set proxy = "proxy"
setenv http_proxy $proxy
setenv https_proxy $proxy
setenv ftp_proxy $proxy
setenv HTTP_PROXY $proxy
setenv HTTPS_PROXY $proxy
setenv FTP_PROXY $proxy


# ------------------------------------------------------------------
#			aliases
# ------------------------------------------------------------------

a   dc          cd
a   ls		ls -F
a   la		ls -a
a   ll		ls -lah
a   unshar	"sed '1,/^#/d' \!:* | sh"
a   push	'pushd .'
a   rgrep       "find . -name '*' -exec egrep \!* {} /dev/null \;"
a   rfgrep      "find . -name '*.[c|cc|h|hh]' -exec egrep \!* {} /dev/null \;"
a   ff          "find . -name \!* -print"
a   mf          "find . -name '[Mm]akefile' -exec egrep \!* {} /dev/null \;"
a  sou 'source ~/.cshrc'
a  s	'source'
a  e    'emacs'
a  en   'emacs -nw'
a  j		jobs -l

#for complete
#if ( -f ~/.env/complete ) then
#      source ~/.env/complete
#endif


# ------------------------------------------------------------------
#			build setting
# ------------------------------------------------------------------
setenv CROSS_C_NR_CPUS 10
setenv CCACHE_NODIRECT 1

setenv GIT_PROXY_COMMAND /usr/local/bin/git-proxy.sh
