# ~/.zshrc - Arquivo de configuração para shells interativos do Zsh.
# Consulte /usr/share/doc/zsh/examples/zshrc para exemplos.

# BY GUIZINTX BYPASS BASTANTE

# Opções do Zsh
setopt autocd              # Mudar de diretório apenas digitando seu nome
#setopt correct            # Corrigir erros automaticamente
setopt interactivecomments # Permitir comentários no modo interativo
setopt magicequalsubst     # Expansão de nome de arquivo para argumentos no formato 'qualquer_coisa=expressão'
setopt nonomatch           # Ocultar mensagens de erro quando não houver correspondência para o padrão
setopt notify              # Exibir status de processos em segundo plano imediatamente
setopt numericglobsort     # Ordenar nomes de arquivos numericamente quando fizer sentido
setopt promptsubst         # Habilitar substituição de comandos no prompt

WORDCHARS=${WORDCHARS//\/} # Evitar que certos caracteres sejam considerados parte de uma palavra

# Ocultar o caractere de fim de linha ('%')
PROMPT_EOL_MARK=""

# Configuração de atalhos de teclado
bindkey -e                                        # Atalhos no estilo Emacs
bindkey ' ' magic-space                           # Expandir histórico ao pressionar espaço
bindkey '^U' backward-kill-line                   # Ctrl + U
bindkey '^[[3;5~' kill-word                       # Ctrl + Delete
bindkey '^[[3~' delete-char                       # Delete
bindkey '^[[1;5C' forward-word                    # Ctrl + →
bindkey '^[[1;5D' backward-word                   # Ctrl + ←
bindkey '^[[5~' beginning-of-buffer-or-history    # Page Up
bindkey '^[[6~' end-of-buffer-or-history          # Page Down
bindkey '^[[H' beginning-of-line                  # Home
bindkey '^[[F' end-of-line                        # End
bindkey '^[[Z' undo                               # Shift + Tab desfaz última ação

# Ativar recursos de autocompletar
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'especificar: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completando %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SNo %p: Pressione TAB para mais opções, ou insira o caractere%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SSeleção ativa: seleção atual em %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Configurações do histórico
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # Excluir duplicatas primeiro quando HISTFILE exceder HISTSIZE
setopt hist_ignore_dups       # Ignorar comandos duplicados no histórico
setopt hist_ignore_space      # Ignorar comandos iniciados com espaço
setopt hist_verify            # Exibir comando antes de executá-lo

# Mostrar todo o histórico de comandos
alias history="history 0"

# Configuração de formato do comando `time`
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# Tornar `less` mais amigável para arquivos não-texto
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Identificar o ambiente chroot (se houver)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Configurar o prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol=㉿
    case "$PROMPT_ALTERNATIVE" in
        twoline)
user=kali
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'$user%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            ;;
        oneline)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
    esac
    unset prompt_symbol
}

# INÍCIO DAS CONFIGURAÇÕES DO KALI LINUX
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# FIM DAS CONFIGURAÇÕES DO KALI LINUX

if [ "$color_prompt" = yes ]; then
    VIRTUAL_ENV_DISABLE_PROMPT=1
    configure_prompt

    # Ativar realce de sintaxe
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}

# BY GUIZINTX BYPASS BASTANTE
