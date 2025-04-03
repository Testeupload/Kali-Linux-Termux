# ~/.bashrc: executado pelo bash(1) para shells que não são de login.
# veja /usr/share/doc/bash/examples/startup-files (no pacote bash-doc)
# para exemplos

# Se não estiver rodando interativamente, não faça nada
case $- in
    *i*) ;;
      *) return;;
esac

# não colocar linhas duplicadas ou linhas começando com espaço no histórico.
# Veja bash(1) para mais opções
HISTCONTROL=ignoreboth

# adicionar ao arquivo de histórico, não sobrescrevê-lo
shopt -s histappend

# para definir o tamanho do histórico veja HISTSIZE e HISTFILESIZE no bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# verificar o tamanho da janela após cada comando e, se necessário,
# atualizar os valores de LINES e COLUMNS.
shopt -s checkwinsize

# Se definido, o padrão "**" usado em uma expansão de caminho irá
# corresponder a todos os arquivos e a zero ou mais diretórios e subdiretórios.
#shopt -s globstar

# tornar o 'less' mais amigável para arquivos de entrada não textuais, veja lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# definir a variável identificando o chroot em que você está trabalhando (usado no prompt abaixo)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# definir um prompt elegante (sem cor, a menos que saibamos que queremos cor)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# descomente para um prompt colorido, se o terminal tiver essa capacidade;
# desativado por padrão para não distrair o usuário
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # Suporte a cores disponível
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Configuração específica do Kali Linux
# INÍCIO DAS VARIÁVEIS DE CONFIGURAÇÃO DO KALI
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# FIM DAS VARIÁVEIS DE CONFIGURAÇÃO DO KALI

if [ "$color_prompt" = yes ]; then
    # substituir o indicador padrão do virtualenv no prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\033[;32m'
    info_color='\033[1;34m'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Mudar cores do prompt para usuário root
        prompt_color='\033[;94m'
        info_color='\033[1;31m'
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
user=kali
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\033[0;1m$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'$user'$prompt_color')-[\033[0;1m\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\033[0m ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\033[00m:'$prompt_color'\033[01m\w\033[00m\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\033[01;31m\u@\h\033[00m:\033[01;34m\w\033[00m\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Se for um xterm, definir o título para usuário@host:diretório
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a$PS1"
    ;;
*)
    ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# habilitar suporte a cores no ls, less e man, e adicionar aliases úteis
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # corrigir cores do ls para pastas com permissão 777

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # início do piscar
    export LESS_TERMCAP_md=$'\E[1;36m'     # início do negrito
    export LESS_TERMCAP_me=$'\E[0m'        # reset negrito/piscar
    export LESS_TERMCAP_so=$'\E[01;33m'    # início do vídeo reverso
    export LESS_TERMCAP_se=$'\E[0m'        # reset vídeo reverso
    export LESS_TERMCAP_us=$'\E[1;32m'     # início do sublinhado
    export LESS_TERMCAP_ue=$'\E[0m'        # reset sublinhado
fi

# mensagens de erro e aviso do GCC coloridas
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# mais alguns aliases do ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Definições de alias.
# Você pode colocar suas adições em um arquivo separado como ~/.bash_aliases
# em vez de adicioná-las diretamente aqui.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ativar recursos de conclusão programável (se ainda não estiver ativado)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# By TX - Tradução e adaptação por TX.
