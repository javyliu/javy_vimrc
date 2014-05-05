set vb t_vb= "关闭响铃和闪屏
set guioptions-=T "gui的工具栏
set guioptions-=r "gui的右边的滑动条
set guioptions-=L "gui的左边的滑动条
set guioptions-=m "gui的菜单

set cul
colorscheme desert

let g:skip_loading_mswin = 1
let g:html_indent_inctags = "html,body,head,tbody" 

let mapleader = ";"
nmap <space> :
set tabstop=2
set shiftwidth=2
set sw=2
set expandtab
set smarttab

set showcmd             " display incomplete commands
set ambiwidth=double
set ruler

inoremap <c-l> <right>
inoremap <c-h> <left>
"inoremap <c-j> <down>
"inoremap <c-k> <up>
inoremap <c-j> <esc>o
map Y y$
vmap // y/<c-r>"<cr>


" 在浏览器预览 for win32
function! ViewInBrowser(name)
    let file = expand("%:p")
    exec ":update " . file
    let l:browsers = {
        \"cr":"D:/WebDevelopment/Browser/Chrome/Chrome.exe",
        \"ff":"D:/WebDevelopment/Browser/Firefox/Firefox.exe",
        \"op":"D:/WebDevelopment/Browser/Opera/opera.exe",
        \"ie":"C:/progra~1/intern~1/iexplore.exe",
        \"ie6":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie6",
        \"ie7":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie7",
        \"ie8":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie8",
        \"ie9":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie9",
        \"iea":"D:/WebDevelopment/Browser/IETester/IETester.exe -all"
    \}
    let htdocs='E:\\apmxe\\htdocs\\'
    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
    if strpos == -1
       exec ":silent !start ". l:browsers[a:name] ." file://" . file
    else
        let file=substitute(file, htdocs, "http://127.0.0.1:8090/", "g")
        let file=substitute(file, '\\', '/', "g")
        exec ":silent !start ". l:browsers[a:name] file
    endif
endfunction
nmap <leader>p :call ViewInBrowser("cr")<cr>
nmap <f4>cr :call ViewInBrowser("cr")<cr>
nmap <f4>ff :call ViewInBrowser("ff")<cr>
nmap <f4>op :call ViewInBrowser("op")<cr>
nmap <f4>ie :call ViewInBrowser("ie")<cr>
nmap <f4>ie6 :call ViewInBrowser("ie6")<cr>
