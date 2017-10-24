PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`[\u@\h:\w]\\$"

#standerd commands for use. 
alias ll='ls -al'

#connects to servers.
alias s.p='ssh root@172.16.43.10'
#alias stt='screen /dev/tty.usbserial-A400BZJB 115200 8N1'
alias s.r='ssh -X root@172.16.40.63'
alias s.j='ssh root@172.16.40.1'
alias s.k='ssh root@172.16.40.135'
alias s.b3='ssh anyman@build3.digecor.com'

#cool commands.
alias tm='/usr/bin/textme.py'
alias pg='/bin/ps aux | grep'
