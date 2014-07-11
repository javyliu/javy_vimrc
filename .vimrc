" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" BundleInstall
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#rc()


call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'
" My Bundles here:

"Plugin 'Align'
Plugin 'tpope/vim-rails'
"git.vim
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

"Plugin 'mattn/zencoding-vim.git'
"Plugin 'vim-scripts/ZenCoding.vim'
"Plugin "mattn/emmet-vim" => https://github.com/mattn/emmet-vim.git
Plugin 'mattn/emmet-vim'

Plugin 'The-NERD-Commenter'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'motemen/git-vim'
"ack
"Plugin 'mileszs/ack.vim'

"Plugin 'msanders/snipmate.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
"Optional:
Plugin 'honza/vim-snippets'

"Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'hallison/vim-markdown'
"Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-surround'
"Plugin 'bbommarito/vim-slim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
"代码格式化插件；
Plugin 'jsbeautify'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
"字典
Plugin 'asins/vim-dict'
"easy motion
Plugin 'Lokaltog/vim-easymotion'
Plugin 'justinmk/vim-sneak'

"for angularjs
Plugin 'burnettk/vim-angular'
Plugin 'matthewsimo/angular-vim-snippets'
"
""making your unit testing experience more excellent
Plugin 'claco/jasmine.vim'
"
"Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'

call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = ";"
nmap <space> :
" source .vimrc
nmap <leader>s :source $HOME/.vimrc<cr>
nmap <leader>e :sp $HOME/.vimrc<cr>
" round by <%=%>
vmap <leader>r di<% <C-R>" %><esc>
vmap <leader>re di<%= <C-R>" %><esc>

nmap <leader>b :ls<cr>:e #
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
autocmd! filetypedetect BufRead,BufNewFile *.json setf json
autocmd! filetypedetect BufEnter,BufRead,BufNewFile *.html.erb setf eruby.html

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

nnoremap <silent> <F9> :TagbarToggle<CR>

"1 : Enable the clever-s feature (similar to the clever-f plugin[3]).
"let g:sneak#s_next = 0
" Prevent vim from trying to connect to the X server when connecting
"
" " from home, which causes a startup delay of about 14 seconds. I
"
" " usually connect from home via screen.
"
"
"set clipboard=autoselect,exclude:cons\\\|linux\\\|screen
"
" "
"
" " Using $DISPLAY instead of &#39term' should be more reliable. It avoids
"
" " the problem of starting vim without first starting screen and allows
"
" " screen to be used locally without losing vim&#39s X features.
"
" "
"
if $DISPLAY =~ '\(\(cos\|scs\)\d\+nai\d\+\)\|\(spkpc\d\+\)\|\(tc-garyjohn\)' "
  set clipboard=autoselect,exclude:.*
endif


