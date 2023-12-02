#!/usr/bin/env -S nvim --headless -u
" Update syntax/zathurarc.vim
if argc() != 1
  echohl WarningMsg
  echomsg 'Please input json path, such as /usr/lib/python3.X/site-packages/zathura-language-server/assets/json/zathurarc.json'
  echohl None
  quit
endif
let g:filename = argv(0)
let g:dict = json_decode(join(readfile(g:filename), ''))
let g:commands = []
let g:options = []
for [g:k, g:v] in items(g:dict)
  if g:v[0] == ':'
    let g:options += [g:k]
  else
    let g:commands += [g:k]
  endif
endfor
let g:commands = join(sort(g:commands), ' ')
let g:options = join(sort(g:options), ' ')
noswapfile edit syntax/zathurarc.vim
" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
%substitute/syntax keyword .*Command \zs.*/\=trim(g:commands)/
%substitute/syntax keyword .*Option \zs.*/\=trim(g:options)/
" vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
write
quit
