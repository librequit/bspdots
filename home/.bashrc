# bashrc
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# draw horiz line under prompt
draw_line() {
  local COLUMNS="$COLUMNS"
  while ((COLUMNS-- > 0)); do
    printf '\e[30m\u2500'
  done
}

# my prompt
PS1="\[\033[32m\]  \[\033[37m\]\[\033[34m\]\w \[\033[0m\]"
PS2="\[\033[32m\]  > \[\033[0m\]"

PATH=$PATH:~/.local/bin
PATH=$PATH:~/.node_modules/bin
PATH=$PATH:~/.volta/bin
PATH=$PATH:~/.cargo/bin

# bash history
HISTSIZE=
HISTFILESIZE=

# pacman cmds
alias \
    pi="yay -S" \
    pr="doas pacman -Rsn" \
    pu="yay -Syyyu --devel" \
    pq="yay -Ss"

# verbosity and settings
alias \
    cp="cp -iv" \
    mv="mv -iv" \
    rm="rm -vI" \
    mkdir="mkdir -pv" \
    yt="yt-dlp" \
    yta="yt -x -f bestaudio/best" \
    ffmpeg="ffmpeg -hide_banner"

# colorize cmds when possible
alias \
    grep="grep --color=auto" \
    diff="diff --color=auto" \
    ip="ip -color=auto" \
    ncdu="ncdu --color dark"

# progs
alias \
    kek='killall mpd ncmpcpp ncmpcpp_cover_art.sh' \
    mpd='mpd && ~/.ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug' \
    mpdd='kek && mpd' \
    e='nvim -O' \
    wal='feh --bg-fill --no-fehbg' \
    lf='lfub' \
    nsxiv='nsxiv-rifle' \
    ls='exa --group-directories-first --group --icons' \
    la='ls --all' \
    ll='ls --long' \
    lla='ls --long --all' \
    lt='ls --tree' \
    lta='ls --tree --all' \
    prename='perl-rename' \
    gl='git clone'
