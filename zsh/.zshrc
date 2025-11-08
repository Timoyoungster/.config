###########
# Globals #
###########

export WWW_HOME=www.duckduckgo.com
export SEMESTER=v

##############
# Completion #
##############

# autocomplete dots
setopt globdots

# case insensitive completion
autoload -Uz +X compinit && compinit

WORDCHARS=${WORDCHARS//\/[&.;]}

## case insensitive path-completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
setopt MENU_COMPLETE
setopt DVORAK # spelling mistakes wrt. dvorak layout
setopt no_list_ambiguous

############
# Bindings #
############

# disable software flow control thingy
stty -ixon

# nvim editor but no zsh-vi mode
export VISUAL=nvim
export EDITOR=$VISUAL
bindkey -e

# fzf
source ~/.config/zsh/fzf-stuff

# vim-style completion navigation
bindkey '^N' expand-or-complete
bindkey '^P' reverse-menu-complete
bindkey '^Y' accept-line

##########
# Prompt #
##########

# setopt promptsubst
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git:*' check-for-changes false
# zstyle ':vcs_info:git:*' unstagedstr '?'
# zstyle ':vcs_info:git:*' stagedstr '+'
# zstyle ':vcs_info:git:*' formats '(%b%c%u) '
# PROMPT='%F{yellow}%(1j.(%j jobs) .)%f%. %F{red}$vcs_info_msg_0_%f%% '
PROMPT='%F{yellow}%(1j.(%j jobs) .)%f%. %f%% '

########
# PATH #
########

export PATH=$PATH:/home/timo/.cargo/env
export PATH=$PATH:/home/timo/.cargo/bin
export PATH=$PATH:/home/timo/go/bin
# export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:~/.volta/bin
export PATH=~/.config/scripts:$PATH
export PATH=~/.local/bin:$PATH

# texlive paths
export PATH=$PATH:/usr/local/texlive/2025/bin/x86_64-linux
export MANPATH=$MANPATH:/usr/local/texlive/2025/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2025/texmf-dist/doc/info

###########
# Aliases #
###########

alias sudo='sudo ' # make aliases work with sudo http://www.linuxcommand.org/lc3_man_pages/aliash.html
alias ll="ls -a -h -l --color=always -v --group-directories-first"
alias lx="ls -a -h --color=always -v --group-directories-first"
alias lxs="ls -a -h -l --color=always --group-directories-first -v | less -R"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gb="git branch -a"
alias gp="git push"
alias gpull="git pull"
alias gwt="git worktree "
alias gwta="git worktree add "
alias gwtr="git worktree remove "
alias gor="go run ."
alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="cd ~/.config/nvim"
alias dotfiles="cd ~/.config"
alias res="fg"
alias hl='Hyprland'
alias imgcat='img2sixel' // better: viu
alias clock='tclock' # cargo install clock-tui
alias weather='curl wttr.in/48.11,14.19'
alias hextobin='python3 ~/.config/scripts/hex_to_bin.py $@'
alias wm='w3m -v www.duckduckgo.com'
alias duck='cat ~/.config/zsh/duck'
alias cpoeu='wl-copy Ö'
alias cpaeu='wl-copy Ä'
alias cpueu='wl-copy Ü'
alias cpoe='wl-copy ö'
alias cpae='wl-copy ä'
alias cpue='wl-copy ü'
alias cpss='wl-copy ß'
alias gcc-arm='arm-none-eabi-gcc'
alias gcc-arm-no='arm-none-eabi-gcc -static -nostdlib'
alias gdb-arm='arm-none-eabi-gdb'
alias objdump='objdump -M intel --no-show-raw-insn'
alias objdump-arm='arm-none-eabi-objdump --no-show-raw-insn'
alias draw='lorien'
alias sshot='hyprshot -m region --clipboard-only'
alias txmisc='tmux new -As "misc" nchat ";" splitw -h tclock ";" splitw -v'
alias zb='zig build'
alias zbr='zig build run'
alias zbt='zig build test'
alias zat='zathura '
alias tts='piper-tts --model "/usr/share/piper-voices/en/en_US/ryan/high/en_US-ryan-high.onnx" --output-raw | aplay -r 22050 -f S16_LE -t raw -'
alias xopen='xdg-open '
alias cal='cal -m '
alias tsenable='source /usr/share/nvm/init-nvm.sh '

eval $(thefuck --alias)

function uni () {
  cd ~/github/jku
  git pull
  cd -

  DIR=""
  if [ $# -eq 1 ]
  then
    DIR=~/github/jku/$SEMESTER/$1/*(/om[1])
  else
    DIR=~/github/jku
  fi
  if [[ -z $TMUX ]]; then
    tmux new -As uni -c $~DIR
  else
    tmux new -ds uni -c $~DIR 2> /dev/null
    tmux switch-client -t uni
  fi
}

function create-submission () {
  if [[ $PWD == *"/$SEMESTER/spv/a"* ]]
  then
    NUM=${${PWD:(-2)}//[^0-9]/}
    cp a${NUM}_jukit.ipynb Assignment_${NUM}_TimoPrömer_k12005204.ipynb
    mv a${NUM}_jukit.pdf Assignment_${NUM}_TimoPrömer_k12005204.pdf
  elif [[ $PWD == *"/$SEMESTER/ai/a"* ]]
  then
    NUM=${${PWD:(-2)}//[^0-9]/}
    a=(*_jukit.ipynb)
    if [[ ${#a} -eq 1 ]]
    then
      cp *_jukit.ipynb a${NUM}_k12005204.ipynb
      mv *_jukit.pdf a${NUM}_k12005204.pdf
    else
      echo "${#a} files found!"
    fi
  elif [[ $PWD == *"/$SEMESTER/algodat/a"* ]]
  then
    for file in *.md
    do
      mdpdf $file
    done
    zip k12005204.zip [[:lower:]]*.pdf(N) *.py(N)
  fi
}

function tx () {
  if [ $# -eq 0 ]
  then
    tmux list-sessions
  else
    if [[ -z $TMUX ]]; then
      tmux new -As $@
   else
      tmux new -ds $1 2> /dev/null
      tmux switch-client -t $@
    fi
  fi
}

function venv () {
  source ~/.pythonvenv/$1/bin/activate || return
  echo "Activated python venv '$1'!"
}

function Rrender () {
  if [ $# -eq 0 ]
  then
    echo "No file specified"
  else
    Rscript -e "rmarkdown::render('$1')"
  fi
}

function vtanim () {
  SPEED=75
  if [ $# -eq 2 ]
  then
    SPEED=$2
  fi
  cat $1 | pv --quiet --line-mode --rate-limit ${SPEED}
}

function zmk_build_both () {
  cd ~/github/zmk-config
  git pull
  cd -
  if [[ "$VIRTUAL_ENV" == "" ]]
  then
    venv zmk
  fi
  west build -d build/left -b nice_nano_v2 -- -DSHIELD=cradio_left -DZMK_CONFIG="/home/timo/github/zmk-config/config" -DZMK_EXTRA_MODULES="/home/timo/github/zmk-config/"
  west build -d build/right -b nice_nano_v2 -- -DSHIELD=cradio_right -DZMK_CONFIG="/home/timo/github/zmk-config/config" -DZMK_EXTRA_MODULES="/home/timo/github/zmk-config/"
}

##########
# SOURCE #
##########

if [[ -f ~/.config/zsh/ssh-stuff ]]
then
  source ~/.config/zsh/ssh-stuff
fi

if [[ -f ~/.config/scripts/set_brightness ]]
then
  source ~/.config/scripts/set_brightness
fi
