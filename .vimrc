" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" BundleInstall
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#rc()
"不再使用git协议来安装插件
"let g:vundle_default_git_proto = 'git'

call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'
" My Bundles here:

"Plugin 'Align'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
"vim +ruby后已自带[]该功能
"Plugin 'vim-ruby/vim-ruby'
"git.vim
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

"Plugin 'mattn/zencoding-vim.git'
"Plugin 'vim-scripts/ZenCoding.vim'
"Plugin "mattn/emmet-vim" => https://github.com/mattn/emmet-vim.git
Plugin 'mattn/emmet-vim'

Plugin 'The-NERD-Commenter'
"need patyon 2.0
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'motemen/git-vim'
"change to javyliu git
"Plugin 'javyliu/git-vim'
"ack
"Plugin 'mileszs/ack.vim'

"Plugin 'msanders/snipmate.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
"Optional:
Plugin 'honza/vim-snippets'

"Plugin 'Shougo/neocomplete'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'

"Plugin 'scrooloose/nerdtree'
"
"
"is in vim-snippets/coffee
Plugin 'kchmck/vim-coffee-script'
"Plugin 'hallison/vim-markdown'
"Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-surround'
"Plugin 'bbommarito/vim-slim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
"代码格式化插件；
Plugin 'pangloss/vim-javascript'
"Plugin 'maksimr/vim-jsbeautify'
"Json hightlight
"Plugin 'elzr/vim-json'
Plugin 'othree/javascript-libraries-syntax.vim'
"jsx syntax highlighting and indenting for jsx
Plugin 'mxw/vim-jsx'
"react snippets
"Plugin 'justinj/vim-react-snippets'
"es6
Plugin 'isRuslan/vim-es6'
"for node js
Plugin 'moll/vim-node'
"字典
Plugin 'asins/vim-dict'
"easy motion
"Plugin 'Lokaltog/vim-easymotion'
Plugin 'easymotion/vim-easymotion'
"Plugin 'justinmk/vim-sneak'

"for angularjs
"Plugin 'burnettk/vim-angular'
"Plugin 'matthewsimo/angular-vim-snippets'
"
""making your unit testing experience more excellent
Plugin 'claco/jasmine.vim'
"
"Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
" my custom snippets

Plugin 'javyliu/custom_snippets'

"for nginx
Plugin 'chr4/nginx.vim'

"for log
Plugin 'vim-scripts/TailMinusF'
"for ack search
Plugin 'mileszs/ack.vim'
"vim-multiple-cursors deprecated
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'mg979/vim-visual-multi'
"gist-vim
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

"indentLine
"Plugin 'Yggdroot/indentLine'

call vundle#end()            " required
filetype plugin indent on    " required

"indentLine color
"let g:indentLine_color_term = 239
"let g:indentLine_color_dark = 1
"let g:indentLine_char = ''

let mapleader = ';'
set nobackup
set nowritebackup
set backupcopy=yes

"set tags=tags,.
set tags=.git/tags
nmap <F8> :TagbarToggle<CR>

"keyword
"set dictionary+=/usr/share/dict/words
autocmd filetype javascript set dictionary+=$HOME/.vim/bundle/vim-dict/dict/javascript.dic
autocmd filetype javascript set dictionary+=$HOME/.vim/bundle/vim-dict/dict/node.dic
"autocmd filetype javascript set dictionary+=$HOME/javy_vimrc/angularjs.dic
autocmd filetype css set dictionary+=$HOME/.vim/bundle/vim-dict/dict/css.dic
"autocmd filetype html set dictionary+=$HOME/javy_vimrc/angular_html.dic
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
set softtabstop=2
set shiftwidth=2
set sw=2
set expandtab

set smarttab
"set list
"set listchars=tab:-,eol:,trail:-

set showcmd             " display incomplete commands
set ambiwidth=double
set ruler
set nu
"set hls
" Display extra whitespace
"set list listchars=tab:»·,trail:·
"Syntax highlighting and indenting for JSX in .js files
let g:jsx_ext_required = 0

autocmd FileType make     set noexpandtab
autocmd FileType python   set noexpandtab
"autocmd FileType eruby  set tabstop=2 shiftwidth=2
"autocmd FileType ruby,rdoc set tabstop=2 shiftwidth=2
"autocmd FileType html set tabstop=2 shiftwidth=2
"autocmd FileType javascript set tabstop=2 shiftwidth=2
"autocmd FileType coffee set tabstop=2 shiftwidth=2
autocmd! filetypedetect BufEnter,BufRead,BufNewFile *.coffee setf coffee
autocmd! filetypedetect BufEnter,BufRead,BufNewFile *.json setf json.javascript
autocmd! filetypedetect BufEnter,BufRead,BufNewFile *.rb setf ruby.rails
autocmd! filetypedetect BufEnter,BufRead,BufNewFile *.erb setf eruby.html
"删除重复行
:command! Td :sort|:g/^\(.\+\)$\n\1/d
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
hi! StatusLineNC cterm=none ctermfg=7 ctermbg=0
hi! StatusLine cterm=none ctermfg=15 ctermbg=0
hi! VertSplit cterm=none


let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" 打开javascript折叠
"let b:javascript_fold=1
" " 打开javascript对dom、html和css的支持
"let javascript_enable_domhtmlcss=1

"nmap <F2> :w<cr>
"nmap <F3> :wa<cr>
"nmap <F4> :q<cr>
"nmap <F6> :cp<cr>
"nmap <F7> :cn<cr>
"nmap <F11> gg=G<C-o>


" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_highlighting = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_mode_map = { 'passive_filetypes': ['html','scss', 'slim','javascript'] }

"CtrlP
" Ignore some folders and files for CtrlP indexing
" enable per-project .vimrc files
set exrc
" Only execute safe per-project vimrc commands
set secure
" now you can add following to you private project's folder .vimrc
"-----------------------------
" set wildignore+=tags
" set wildignore+=*/tmp/*
" set wildignore+=*/vendor/*
" set wildignore+=*/spec/vcr/*
" set wildignore+=*/public/*
" set wildignore+=*/chef/*
" set wildignore+=*/coverage/*
" set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig
"-----------------------------
"tells ctrlp to persist the cache in the configured location, so when you
"launch vim again, it will read from there and load the cache (much faster)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.sql,*.png,*.jpg,*.JPG*.otf,*.woff,*.jpeg,*.orig
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$\|node_modules'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
"let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_max_files=0
let g:ctrlp_follow_symlinks=1
"don't clear cache
let g:ctrlp_clear_cache_on_exit = 0

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

let g:snipMate = { 'snippet_version' : 1 }
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rspec'

"搜入执行命令后的值
function! InsertCommand(command)
    redir => output
    silent execute a:command
    redir END
    call feedkeys('i'.substitute(output, '^[\n]*\(.\{-}\)[\n]*$', '\1', 'gm'))
endfunction

command! -nargs=+ Iruby  call InsertCommand("ruby puts " . <q-args>)

set guifont=monaco\ 10
"inoremap <C-R>] <esc>:call InsertCommand("
inoremap <C-R>] <esc>:Iruby
nmap Y y$
vnoremap // y/<c-r>"<cr>

"easymotion----------------------------
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


nmap s <Plug>(easymotion-s)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1

nmap <space> :
" source .vimrc
nmap <leader>lv :source $HOME/.vimrc<cr>
" round by <%=%>
vmap <leader>r di<% <C-R>" %><esc>
vmap <leader>re di<%= <C-R>" %><esc>

nmap <leader>b :ls<cr>:sp #
"clear ctrlp cache
nmap <leader>cd :CtrlPClearAllCaches<cr>
nmap <leader>ww :close<cr>
nmap <leader>wf :cclose<cr>
nmap <leader>fw :copen<cr>

"set current path
nmap <leader>cp :lcd %:h<cr>
"vim-fugitive
nmap <leader>gc :Git commit -a<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gp :Git pull --rebase<cr>
nmap <leader>gP :Git push<cr>
nmap <leader>gl :Glog --pretty=oneline --graph  --decorate<cr>

"inoremap { {}<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap " ""<left>
"inoremap ' ''<left>
inoremap <leader>p <C-O>"*p


nmap <leader>v :call SetColorColumn()<CR>
nmap <leader>cv :set cc=<CR>

nmap <A-up> :lprev<cr>
nmap <A-down> :lnext<cr>
nmap <A-right> :ll<cr>

"for vim-sneak
"nmap \ <Plug>SneakNext
"xmap \ <Plug>SneakNext


"打开当前光标文件名的文件
nnoremap <leader>gf :sp <cfile><cr>
"nmap <leader>ggd :GitDiffAlter <cWORD><cr>
"按空格打把一行打散成多行
nmap <leader>bl V:s!\s\+!\r!g<cr>:noh<cr>
"列出gist
map <leader>gi :Gist
map <leader>gil :Gist -l<cr>
map <leader>gie :Gist -e

nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>


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




"set the column color
fun! SetColorColumn()
  let col_num = virtcol(".")
  let cc_list = split(&cc, ',')
  if count(cc_list, string(col_num)) <= 0
    execute "set cc+=".col_num
  else
    execute "set cc-=".col_num
  endif
endf

"用于选择区域执行记录的动作
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
