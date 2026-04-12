PROMPT="%(?:%F{#9ccfd8}%1{➜%} :%F{#ea9a97}%1{➜%} ) %F{#c4a7e7}%d%{$reset_color%}"
PROMPT+='$(git_prompt_info)'
PROMPT+=' %F{#908caa}%(!.#.$)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#3e8fb0}git:(%F{#ea9a97}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{#3e8fb0}) %F{#f6c177}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{#3e8fb0})"
