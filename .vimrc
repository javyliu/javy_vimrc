" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" BundleInstall

set nocompatible               " be iMproved
filetype off                   " required!

let mapleader = ";"
nmap <space> :
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:

Bundle 'Align'
Bundle 'tpope/vim-rails'

Bundle 'vim-scripts/ZenCoding.vim'
Bundle 'The-NERD-Commenter'
"Bundle 'Valloric/YouCompleteMe'
"git.vim
Bundle 'motemen/git-vim'
"ack
Bundle 'mileszs/ack.vim'

Bundle 'msanders/snipmate.vim'
"Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'hallison/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-surround'
"Bundle 'bbommarito/vim-slim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
"代码格式化插件；
Bundle 'jsbeautify'
Bundle "pangloss/vim-javascript"
Bundle "othree/javascript-libraries-syntax.vim"
"字典
Bundle 'asins/vim-dict'

set guifont=monaco\ 10

set nobackup
set nowritebackup


set tags=tags,gem_tags

"keyword
"set dictionary+=/usr/share/dict/words
autocmd filetype javascript set dictionary+=$HOME/.vim/bundle/vim-dict/dict/javascript.dic
autocmd filetype javascript set dictionary+=$HOME/.vim/bundle/vim-dict/dict/node.dic
autocmd filetype javascript set dictionary+=$HOME/javy_vimrc/angularjs.dic
autocmd filetype css set dictionary+=$HOME/.vim/bundle/vim-dict/dict/css.dic
autocmd filetype html set dictionary+=$HOME/javy_vimrc/angular_html.dic
set isk+=-

"语法高亮
syntax on

"打开命令行补全菜单
set wildmenu
"关闭响铃，闪屏
set vb t_vb=
"显示行号
"set nu
"马上跳到搜索匹配
set incsearch
set hls

"根据文件格式载入插件和缩进
filetype plugin indent on
set autoindent

"打开鼠标功能
"set mouse=a

"指标符宽度
set tabstop=2
set shiftwidth=2
set sw=2
set expandtab
set smarttab

set showcmd             " display incomplete commands
set ambiwidth=double
set ruler
"set hls
" Display extra whitespace
"set list listchars=tab:»·,trail:·

autocmd FileType make     set noexpandtab
autocmd FileType python   set noexpandtab
autocmd FileType eruby  set tabstop=2 shiftwidth=2
autocmd FileType ruby,rdoc set tabstop=2 shiftwidth=2
autocmd FileType html set tabstop=2 shiftwidth=2
autocmd FileType javascript set tabstop=2 shiftwidth=2
autocmd FileType coffee set tabstop=2 shiftwidth=2
au! BufRead,BufNewFile *.json setfiletype json

fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" 快捷键
nmap <Up> <c-w>k
nmap <Down> <c-w>j
nmap <Right> <c-w>l
nmap <Left> <c-w>h


inoremap <c-l> <right>
inoremap <c-h> <left>
"inoremap <c-j> <down>
"inoremap <c-k> <up>
inoremap <c-j> <esc>o
map Y y$
vmap // y/<c-r>"<cr>

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" 打开javascript折叠
"let b:javascript_fold=1
" " 打开javascript对dom、html和css的支持
"let javascript_enable_domhtmlcss=1

nmap <F2> :w<cr>
nmap <F3> :wa<cr>
nmap <F4> :q<cr>
nmap <F6> :cp<cr>
nmap <F7> :cn<cr>
nmap <F11> gg=G<C-o>
nnoremap <leader>gf :e <cfile><cr>

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['html','scss', 'slim','javascript'] }

"CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
"let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

nmap <A-up> :lprev<cr>
nmap <A-down> :lnext<cr>
nmap <A-right> :ll<cr>
