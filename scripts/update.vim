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
let g:commands = join(sort(keys(g:dict['properties'])), ' ')
let g:options = join(sort(keys(g:dict['properties']['set']['properties'])), ' ')
noswapfile edit syntax/zathurarc.vim
" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
%substitute/syntax keyword .*Command \zs.*/\=trim(g:commands)/
%substitute/syntax keyword .*Option \zs.*/\=trim(g:options)/
" vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
write
quit
