" lucmult .vimrc, based on bgola .vimrc
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let g:EnhCommentifyTraditionalMode = 'N'
"let g:EnhCommentifyUseAltKeys = 'yes'
let g:EnhCommentifyMultiPartBlocks = 'yes'
vmap <F7> <Plug>VisualComment
vmap <F6> <Plug>VisualDeComment


" Settings from deo's vimrc - http://dtremea.googlepages.com/vimrc
set wildmode=list:full wildmode=longest,list pastetoggle=<c-u>
set visualbell nowrap nojoinspaces ruler magic hidden is aw showcmd

" Map ,a to clean extra endline tabs/spaces
nnoremap <silent> ,a :%s,\s\+$,,<CR>

" Map F8 to Tlist
"nnoremap <silent> <F8> :Tlist<CR>

" Move to left/right of {([
imap <c-l> <esc><right>a
imap <c-h> <esc><left>a

" Auto open/close Tlist
"let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1




" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set ignorecase		" ignore case sensitive in searching

" Don't use Ex mode, use Q for formatting
map Q gq


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

imap <F7> <c-n>
"imap <F8> <c-x><c-n>

cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q
cab X  x
cab Tabe tabe

au BufRead,BufNewFile *.rest, *.rst set filetype=rest
au BufRead,BufNewFile *.kss set filetype=css

au FileType rest set linebreak wrap nolist
au FileType rest syn on
au FileType rest set syntax=rest

au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript

if has("gui_macvim")
	let macvim_hig_shift_movement = 1
	set transparency=0
	set gfn=Lucida\ Sans\ Typewriter:h12
endif


au BufRead,BufNewFile *.zcml set filetype=xml
" colore os tabs - Python
"au FileType python syn match pythonTAB '    '   "'\t\+'
"au FileType python hi pythonTAB ctermbg=blue 
" colore ruby Ruby

"au FileType python syn match keyword 'self'
"au FileType python syn match keyword 'None'
"au FileType python hi pythonString ctermfg=darkred
"au FileType python hi pythonRawString ctermbg=gray
let python_highlight_all = 1
let python_highlight_indent_errors = 0  " não exibir os erros de identação (na cor vermelha)
let python_highlight_space_errors = 0   " não exibir os erros espaço excedente (na cor vermelha)
au FileType python set encoding=utf-8
"autocmd FileType python setlocal textwidth=78

au FileType ruby syn match rubyTAB '  '   "'\t\+'
au FileType ruby hi rubyTAB ctermbg=red

command! -nargs=+ Calc :r! python -c "from math import *; print <args>"
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab " Python
autocmd FileType doctest set tabstop=4|set shiftwidth=4|set expandtab " Python
autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab|set omnifunc=phpcomplete#CompletePHP " PHP
autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab " Ruby
"au FileType python hi pythonString ctermfg=darkgreen
autocmd FileType html set tabstop=4|set shiftwidth=4|set expandtab " HTML 
autocmd FileType xhtml set tabstop=4|set shiftwidth=4|set expandtab " HTML 
autocmd FileType htmldjango set tabstop=4|set shiftwidth=4|set expandtab " HTML 

" Zope
" dtml (zope dynamic template markup language), pt (zope page template),
" cpt (zope form controller page template)
" http://vim.cybermirror.org/runtime/filetype.vim
au BufNewFile,BufRead *.dtml,*.pt,*.cpt,*.zpt		call s:FThtml()
" HTML (.shtml and .stm for server side)
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call s:FThtml()

func! s:FThtml()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
      setf xhtml
      return
    endif
    if getline(n) =~ '{%\s*\(extends\|block\)\>'
      setf htmldjango
      return
    endif
    let n = n + 1
  endwhile
  setf html
endfunc

set smarttab
" Bind <f2> key to running the python interpreter on the currently active
" file.  (curtesy of Steve Howell from email dated 1 Feb 2006).
autocmd FileType python map <F2> :w\|!python -i %<cr>
"autocmd VimEnter * source ~/.vim/snipper/snipper.vim
autocmd FileType python map <F3> :w\|!/opt/local/bin/python2.5 -i %<cr>

autocmd FileType scheme map <F2> :w\|!csi -sx %<cr>

"if has("autocmd") 
"autocmd FileType python set complete+=k/Users/lucianopacheco/.vim/pydiction-0.5/pydiction isk+=.,( 
"endif "has(autocmd) 

set statusline=%F%m%r%h%w\ [FORMATO=%{&ff}]\ [TIPO=%Y]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [ASCII=\%03.3b]\ [linha=%04l,%04v][%p%%]\ [LINHAS=%L]
hi StatusLine   ctermbg=darkgray ctermfg=darkgreen "configura a cor da barra de status
hi StatusLineNC ctermbg=darkblue ctermfg=darkgreen "configura a cor da barra de status da janela não atual (Not Curent)
set laststatus=2 " Sempre exibe a barra de status

"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r'set path+=%s' % (p.replace(' ', r'\ ')))
"EOF

map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

autocmd FileType python set omnifunc=pythoncomplete#Complete
colorscheme slate 


" http://blog.dispatched.ch/2009/05/24/vim-as-python-ide/
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplMapCTabSwitchWindows = 1
"let g:miniBufExplModSelTarget = 1
"set showtabline=1

" http://www.vim.org/scripts/script.php?script_id=273
"let Tlist_Ctags_Cmd='/opt/local/bin/ctags'


"nnoremap T :TaskList<CR>
"map P :TlistToggle<CR>
"nnoremap <F8> <script> <Plug>TaskList :TaskList<CR>
inoremap <C-D> <C-O>:Tlist<CR>
nnoremap <silent> <C-d> :Tlist<CR>

let Tlist_Use_Right_Window = 1


autocmd FileType python set omnifunc=pythoncomplete#Complete


filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins


" http://www.vim.org/scripts/script.php?script_id=1658
" http://www.akitaonrails.com/2009/1/4/rails-on-vim-in-english
map <silent> <C-p> :NERDTreeToggle<CR>
let NERDTreeHijackNetrw = 0

if ! has("gui_running")
    set t_Co=256
endif
" set background=light gives a different style, feel free to choose between them.
set background=dark
"colors peaksea 


" http://www.vim.org/scripts/script.php?script_id=1984
map <silent> <C-k> :FuzzyFinderBuffer<CR>
map <silent> <C-j> :FuzzyFinderMruFile<CR>
"map <silent> <C-c> :FuzzyFinderMruFile<CR>
"nnoremap <silent> <C-c> :FuzzyFinderMruCmd<CR>


"http://github.com/akitaonrails/vimfiles/blob/0f4f1ede9b11cd465490d889d2994aa3bb4f2681/vimrc`
"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>


set wildmode=list:longest "make cmdline tab completion similar to bash
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=3 "deepest fold is 3 levels
set nofoldenable "dont fold by default
 
set ignorecase  " pode usar o set nogignorecase
" opção de ignorar o case sensitive por busca
" /\Clero  \C case sensitive
" /\clero  \c case insensitive
if has("gui_macvim")
  let macvim_hig_shift_movement = 1
  colorscheme slate
endif
set tabstop=4|set shiftwidth=4|set expandtab 

