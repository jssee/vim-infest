" Drop a debugger or `console.debug` statement in your code, keep telling
" yourself your are good at your job...
" =========================================================
" Maintainer:	Jesse <jesse@mojotech.com>
" Version:	0.0.1
" License:	MIT License
" Location:	plugin/infest.vim
" Website:	https://github.com/jssee/vim-infest

if exists('g:loaded_debug')
  finish
endif
let g:loaded_debug = 1
let g:debugger_statement = 'debugger'

function! s:InfestStatement() abort
  let curpos = getcurpos()
  silent exe 'normal! o '.g:debugger_statement
  silent norm! '[=']
  call setpos('.', curpos)
endfunction

function! s:InfestCword() abort
  let curpos = getcurpos()
  silent exe 'norm! o console.debug('.expand("<cword>").');'
  silent norm! '[=']
  call setpos('.', curpos)
endfunction

function! s:InfestPrompt() abort
  let curpos = getcurpos()
  call inputsave()
  let msg = input('Message: ')
  call inputrestore()
  silent exe 'norm! o console.debug('.msg.');'
  silent norm! '[=']
  call setpos('.', curpos)
endfunction

function! s:InfestRaid(bang) abort
  let curpos = getcurpos()
  if a:bang == '!'
    exe '%s/console.debug(.*);\|'.g:debugger_statement.'//g'
  else
    let conf = confirm("Remove all debugs?", "&OK\n&Cancel", 1)
    if conf == 1
      exe '%s/console.debug(.*);//g'
    else
      echohl WarningMsg | echo 'cleanup aborted!' | echohl None
    endif
  endif
  call setpos('.', curpos)
endfunction

command! -nargs=0 -bang InfestRaid call s:InfestRaid(<q-bang>)

nnoremap <silent> <Plug>(infest_statement) :<C-U>call <SID>InfestStatement()<CR>
nnoremap <silent> <Plug>(infest_cword) :<C-U>call  <SID>InfestCword()<CR>
nnoremap <silent> <Plug>(infest_prompt) :<C-U>call  <SID>InfestPrompt()<CR>

" Usage
" nmap <key> <Plug>(infest_statement)
" nmap <key> <Plug>(infest_cword)
" nmap <key> <Plug>(infest_prompt)
"
" infest_statement: place a 'debugger' statement on the line below
"
" infest_cword: take the word under the cursor, wrap it in a console.debug()
" statement, place it on the line below
"
" infest_prompt: prompts for a message, wrap that message in a console.debug()
" statement, place it on the line below
"
" :InfestRaid(!): perform
