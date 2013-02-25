""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Hints
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jump to the tag under current cursort with a new window: 
"    ^Wg] or ^W] 


" 在 insert mode 要刪除同一 word 游標前的字元:
"    ^W


" set, setlocal and setglobal 指令的不同處:
" set:         改變全部的 buffer or window 的 global 和 local value
" setlocal:     改變目前的 buffer or window 的 local value, 而不影響 global value
" setglobal: 改變 global value 而不影響各 buffer or window 的 local value

" 在 insert mode 要暫時切到 command mode 時用:
"    ^O

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 定義各種變數
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("win16") || has("win32") || has("win64")
    let g:system = "windows"
else
    let g:system = "linux"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 將 encoding 方式設為 utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 設定成繁體中文
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp950
let $LANG="zh_TW.UTF-8"

if has("gui_running")
    "set langmenu=zh_tw.utf-8
    set langmenu=en_US
    " 要使用新的 encoding 須要重新載入 GVIM menu, 不然會變成亂碼
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load the behavior of windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
" restore the ^Y key to VIM.
unmap <C-Y>
behave mswin

set diffexpr=MyDiff()
func! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Pathogen plugin to manager all plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for Common Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowritebackup
set noswapfile

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set hidden
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
set number
set ruler
set cursorline     " cul <= highlight the current line.
set foldcolumn=2
set nowrap
set wildmenu
set wildignore=*.o,*.obj,*~,*.py[co],*.bak,*.exe,*.swp,*.pyc,*.svn,*.git
set magic            " for regular expressions turn magic on
set background=dark

if g:system == "windows"
    set fileformats=dos,unix
    if $USERDOMAIN == "layan-PC"
        set guifont=Consolas:h11:cANSI
    elseif $USERDOMAIN == "layan-NB"
        set guifont=Consolas:h10:cANSI
    else
        set guifont=Consolas:h12:cANSI
    endif
elseif g:system == "linux"
    set fileformats=unix,dos
    set guifont=Monospace\ 12

    let g:clang_use_library=0
    let g:clang_user_options='-stdlib=libstdc++ -std=c++0x'
endif

set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-

cw 10
if g:system == "windows"
    language message en
endif

"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
 map <M-1>          :set number<CR>
imap <M-1>     <C-O>:set number<CR>
 map <M-2>          :set relativenumber<CR>
imap <M-2>     <C-O>:set relativenumber<CR>
 
 map <C-F2>           :so $VIMRUNTIME/_vimrc<CR>
imap <C-F2>      <C-O>:so $VIMRUNTIME/_vimrc<CR>

" clear the search highlighting
nnoremap <silent> <C-L>         :<C-U>nohlsearch<CR><C-L>

" syntax & color scheme
syntax enable
syntax on
colorscheme candycode

" indent_guides setting
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0

" showmarks setting
let g:showmarks_enable = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for NERDTree Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open and close all the three plugins on the same time 
nmap <C-F8>            :TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
nmap <C-F9>            :TrinityToggleSourceExplorer<CR> 
" Open and close the taglist.vim separately 
nmap <C-F10>           :TrinityToggleTagList<CR> 
" Open and close the NERD_tree.vim separately 
nmap <C-F11>           :TrinityToggleNERDTree<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for Omnicppcomplete plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype detect and pluing and load corresponded indent file.
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for pydiction plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pydiction_location = expand("$USERPROFILE") . "\\vimfiles\\bundle\\pydiction\\complete-dict"
let g:pydiction_menu_height = 15

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common Settings for Programming
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" automaitcally show quickfix window if there are any errors.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" 自動載入上次開啟時的 view, 包含手動建立的 fold.
autocmd BufWinLeave *.h silent mkview
autocmd BufWinEnter *.h silent loadview
autocmd BufWinLeave *.c silent mkview
autocmd BufWinEnter *.c silent loadview
autocmd BufWinLeave *.cpp silent mkview
autocmd BufWinEnter *.cpp silent loadview

" Disable highlight when <leader><cr> is pressed
 map <silent> <leader>cr        :noh<CR>
 
" Useful mappings for managing tabs
 map <leader>tn                 :tabnew<CR>
 map <leader>to                 :tabonly<CR>
 map <leader>tc                 :tabclose<CR>
 map <leader>tm                 :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
 map <leader>te                 :tabedit <C-R>=expand("%:p:h")<CR>/<CR>

" query the word under current cursor in MSDN
 map <silent> <F1>              :call LocalDoc()<CR>
imap <silent> <F1>         <C-O>:call LocalDoc()<CR>

 map <silent> <C-F1>            :call OnlineDoc()<CR>
imap <silent> <C-F1>       <C-O>:call OnlineDoc()<CR>

" 用 F4 , S-F4 來切到下一個或上一個錯誤的位置
" 可以用 :copen 開啟 QuickFix Window
 map <silent> <F4>              :cn<CR>
imap <silent> <F4>         <C-O>:cn<CR>
 map <silent> <S-F4>            :cp<CR>
imap <silent> <S-F4>       <C-O>:cp<CR>

" search the word under cursor in this file 
" highlight the word and jump to the first position 
 map <M-G>                      *:vimgrep <cword> %<CR>
imap <M-G>                 <C-O>*<C-O>:vimgrep <cword> %<CR>

" use tab and Shift-Tab 做縮排 in normal mode and visual/select mode
nmap <TAB>                      v>
nmap <S-TAB>                    v<
vmap <TAB>                      >gv
vmap <S-TAB>                    <gv

func! LocalDoc()
    let s:word_under_cursor = expand("<cword>")

    let s:browser = "none"
    let s:arguments = ""

    if g:system == "windows"
        if &filetype == "cpp"
            let s:browser = "\"C:\\Program Files\\Common Files\\microsoft shared\\Help 9\\dexplore.exe\""
            let s:arguments = "/helpcol ms-help://MS.W7SDK.1033 /usehelpsettings WindowsSDK.1.0 /LaunchFKeywordTopic " . s:word_under_cursor
        elseif &filetype == "python"
            let s:browser = "hh.exe"
            let s:arguments = "\"C:\\Python27\\Doc\\Python273.chm\""
        else
            let s:browser = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\""
            let s:arguments = "http://www.google.com.tw/search?q=" . s:word_under_cursor
        endif
    endif

    if s:browser != "none"
        let s:cmd = "!start " . s:browser . " " . s:arguments
        silent execute s:cmd
    else
        echo "browser is not set."
    endif
endf

func! OnlineDoc()
    let s:browser = "none"
    if g:system == "windows"
        let s:browser = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\""
    endif
    
    let s:word_under_cursor = expand("<cword>")

    if &filetype == "cpp"
        let s:arguments = "http://social.msdn.microsoft.com/search/en-us?query=" . s:word_under_cursor
    else
        let s:arguments = "http://www.google.com.tw/search?q=" . "python+" . s:word_under_cursor
    endif

    if s:browser != "none"
        let s:cmd = "!start " . s:browser . " " . s:arguments
        silent execute s:cmd
    else
        echo "browser is not set."
    endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings for file type: Python and CPP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType c              call SetupCpp()
autocmd FileType C              call SetupCpp()
autocmd FileType cpp            call SetupCpp()
autocmd FileType CPP            call SetupCpp()
autocmd FileType python         call SetupPython()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! SetupPython()

    "
    " setup hotkeys
    "

    call SetupPythonHotKeys()

    "
    " editor settings
    "
    
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal expandtab
    setlocal nowrap

    "
    " make program settings
    "
    
    setlocal makeprg=python\ %
    setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    
endf

func! SetupPythonHotKeys()

    " comment current line.
     map <buffer> <C-K><C-C>                 I# <ESC>
    imap <buffer> <C-K><C-C>            <C-O>I# 

    " uncomment current line.
     map <buffer> <C-K><C-U>                 ^2x
    imap <buffer> <C-K><C-U>            <C-O>^2x

    " search the word under cursor in this project
    " add option 'j' to not jump to the first position.
     map <buffer> <C-K><C-F>                 :vimgrep /<C-R><C-W>/j **/*.py<CR>
    imap <buffer> <C-K><C-F>            <C-O>:vimgrep /<C-R><C-W>/j **/*.py<CR>
    
    " compile the python file
     map <buffer> <F7>                       :call CompilePythonUnit()<CR><CR>
    imap <buffer> <F7>                  <C-O>:call CompilePythonUnit()<CR><CR>
     map <buffer> <C-F7>                     :call CompilePythonUnit()<CR><CR>
    imap <buffer> <C-F7>                <C-O>:call CompilePythonUnit()<CR><CR>

    " run the script
     map <buffer> <F5>                       :call RunPythonProject()<CR><CR>
    imap <buffer> <F5>                  <C-O>:call RunPythonProject()<CR><CR>
     map <buffer> <C-F5>                     :call RunPythonProject()<CR><CR>
    imap <buffer> <C-F5>                <C-O>:call RunPythonProject()<CR><CR>
     
    " generate tags file
     map <buffer> <C-F12>                    :!ctags -R --languages=python .<CR><CR>
    imap <buffer> <C-F12>               <C-O>:!ctags -R --languages=python .<CR><CR>

endf

func! CompilePythonUnit()
    execute "update"
    execute "make"
endf

func! RunPythonProject()
    let base_name = expand("%")
    let cmd = '!python ' . base_name
    execute "update"
    execute cmd
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common CPP functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! SetupCpp()
    call SetupCppHotKeys()
    call SetupCppCompiler()
endf

func! SetupCppHotKeys()

    " comment current line.
     map <buffer> <C-K><C-C>                 I// <ESC>
    imap <buffer> <C-K><C-C>            <C-O>I// 

    " uncomment current line.
     map <buffer> <C-K><C-U>                 ^3x<ESC>
    imap <buffer> <C-K><C-U>            <C-O>^3x

    " search the word under cursor in this project.
    " add option 'j' to not jump to the first position.
     map <buffer> <C-K><C-F>                 :vimgrep /<C-R><C-W>/j **/*.cpp **/*.h<CR>
    imap <buffer> <C-K><C-F>            <C-O>:vimgrep /<C-R><C-W>/j **/*.cpp **/*.h<CR>

    " compile the cpp project or file
     map <buffer> <F7>                       :call MakeCppProject()<CR><CR>
    imap <buffer> <F7>                  <C-O>:call MakeCppProject()<CR><CR>
     map <buffer> <C-F7>                     :call CompileCppUnit()<CR><CR>
    imap <buffer> <C-F7>                <C-O>:call CompileCppUnit()<CR><CR>

    " run the cpp project
     map <buffer> <F5>                       :call RunCppProject()<CR><CR>
    imap <buffer> <F5>                  <C-O>:call RunCppProject()<CR><CR>
     map <buffer> <C-F5>                     :call RunCppProject()<CR>
    imap <buffer> <C-F5>                <C-O>:call RunCppProject()<CR>

    " generate tags file
     map <buffer> <C-F12>                    :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C++ .<CR><CR>
    imap <buffer> <C-F12>               <C-O>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C++ .<CR><CR>

endf

func! SetupCppCompiler()
    if g:system == "windows"
        if $VSINSTALLDIR == "C:\\Program Files\\Microsoft Visual Studio 9.0\\"
            let g:cpp_compiler = "vc90"
        elseif $VSINSTALLDIR == "C:\\Program Files\\Microsoft Visual Studio 11.0\\"
            let g:cpp_compiler = "vc11"
        endif
    elseif g:system == "linux"
        let g:cpp_compiler = "gcc"
    endif

    if has("g:cpp_compiler")
        if g:cpp_compiler == "gcc"
            call SetupGCCCompiler()
        elseif g:cpp_compiler == "vc90"
            call SetupVC90Compiler()
        elseif g:cpp_compiler == "vc11"
            call SetupVC11Compiler()
        endif
    endif
endf

func! MakeCppProject()
    if has("g:cpp_compiler")
        if g:cpp_compiler == "gcc"
            call GCCMakeCppProject()
        elseif g:cpp_compiler == "vc90"
            call VC90MakeCppProject()
        elseif g:cpp_compiler == "vc11"
            call VC11MakeCppProject()
        endif
    else
        echo "cpp compiler is not set."
    endif
endf

func! CompileCppUnit()
    if has("g:cpp_compiler")
        if g:cpp_compiler == "gcc"
            call GCCCompileCppUnit()
        elseif g:cpp_compiler == "vc90"
            call VC90CompileCppUnit()
        elseif g:cpp_compiler == "vc11"
            call VC11CompileCppUnit()
        endif
    else
        echo "cpp compiler is not set."
    endif
endf

func! RunCppProject()
    if has("g:cpp_compiler")
        if g:cpp_compiler == "gcc"
            let exe_name = './a.out'
        else
            let exe_name = expand("%:r") . '.exe'
        endif
        silent execute '!' . exe_name
    else
        echo "cpp compiler is not set."
    endif
endf

"
" GCC functions.
"

func! SetupGCCCompiler()
    compiler gcc

    " add include folders to path
    setlocal path=.,
                \/usr/include/,
                \/usr/include/c++/4.6/,
                \/usr/include/boost/

    setlocal tags=/usr/include/c++/4.6.3/tags,/usr/include/tags,./tags,./TAGS,tags,TAGS
endf

func! GCCMakeCppProject()
    setlocal makeprg=make
    execute "update"
    execute "make"
endf

func! GCCCompileCppUnit()
    setlocal makeprg=g++\ -std=c++0x\ %
    execute "update"
    execute "make"
endf

"
" VC90 functions
"

func! SetupVC90Compiler()
    setlocal path=.,
                  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\\VC\include,
                  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\\VC\\atlmfc\\include,
                  \C:\\Program\\\ Files\\Microsoft\\\ SDKs\\Windows\\v7.0\\Include
endf

func! VC90MakeCppProject()
    setlocal makeprg=C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe\ /nologo\ /v:q\ /t:build\ /p:configuration=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    setlocal errorformat=%f(%l):\ error\ C%n:\ %m
    execute "update"
    execute "make"
endf

func! VC90CompileCppUnit()
    setlocal makeprg=cl\ /EHsc\ %
    setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m
    execute "update"
    execute "make"
endf

"
" VC11 functions
"

func! SetupVC11Compiler()
    setlocal path=.,
                  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 11.0\\VC\include,
                  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 11.0\\VC\\atlmfc\\include,
                  \C:\\Program\\\ Files\\Windows\\\ Kits\\8.0\\Include\\um
endf

func! VC11MakeCppProject()
    setlocal makeprg=MSBuild.exe\ /nologo\ /v:q\ /t:build\ /p:configuration=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    setlocal errorformat=%f(%l):\ error\ C%n:\ %m
    execute "update"
    execute "make"
endf

func! VC11CompileCppUnit()
    setlocal makeprg=cl\ /EHsc\ %
    setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m
    execute "update"
    execute "make"
endf

