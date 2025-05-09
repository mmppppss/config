if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

PROMPT='%{$fg[cyan]%}%c/ %{$fg[$NCOLOR]%}% %{$fg_bold[NCOLOR]%}% $ %{$reset_color%}'
RPROMPT='%{$fg[$NCOLOR]%} $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=":)"

# See https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;00:ln=35;00:so=32;00:pi=33;00:ex=31;00:bd=31;00:cd=31;00:su=31;00:sg=31;00:tw=31;00:ow=31;00:"

