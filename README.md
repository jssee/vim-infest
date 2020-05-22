# vim-infest
vim-infest is a simple set of functions that allow you to debug your code
[lickity-split](https://www.merriam-webster.com/dictionary/lickety-split).

## Installation
you can install the colorscheme using whatever package/plugin manager you want, here
is an example using [minpac](https://github.com/k-takata/minpac):
```vim
call minpac#add('jssee/vim-infest')
```

This plugin is really specifically made with javascript coding in mind so optionally,
you can take a more _involved_ approach and choose to only load the plugin for
javascript and its different variants:
```vim
" only load infest for javascript files and its various flavors
call minpac#add('jssee/vim-infest', {'type': 'opt'})
augroup infest_file
  autocmd!
  autocmd FileType *.js,*.ts,*.jsx,*.tsx packadd vim-infest
augroup END
```

## Usage
There are 3 functions and 1 command included. Default mappings are intentionally not provided.

### InfestStatement
Places a `debugger` statement in the line below the current line.
```vim
nmap <key> <Plug>(infest_statement)
```

### InfestCword
take the word under the cursor, wrap it in a `console.debug` statement, place it on the line below.
```vim
nmap <key> <Plug>(infest_cword)
```

### InfestPrompt
prompts for a message, wrap that message in a `console.debug()` statement, place
it on the line below.
```vim
nmap <key> <Plug>(infest_prompt)
```

### InfestRaid(!)
this command is meant to cleanup all the `debugger` and`console.debug` statements
in the current buffer. You have to confirm this action unless you invoke it
with a `!`
```vim
:InfestRaid(!)
```

