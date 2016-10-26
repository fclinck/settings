set nu
set autoindent
set tabstop=2
set shiftwidth =2
set expandtab
autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType yaml execute
      \'syn match yamlBlockMappingKey /^\s*\zs.*\ze\s*:\%(\s\|$\)/'
