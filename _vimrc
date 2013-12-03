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

let g:system = "linux"
let g:processor_architecture = "x86"
let g:pc_name = "unknown"
let g:load_default_cscope_files = 0

if !exists("g:cpp_compiler")
    let g:cpp_compiler = "none"
endif
if !exists("g:make_proj")
    let g:make_proj   = ""
endif
if !exists("g:make_target")
    let g:make_target = "build"
endif
if !exists("g:make_config")
    let g:make_config = "debug"
endif
if !exists("g:make_output")
    let g:make_output = ""
endif

if !exists("g:python_version")
    let g:python_version = "27"
endif

if has("win16") || has("win32") || has("win64")
    let g:system = "windows"
    if exists("$PROCESSOR_ARCHITECTURE")
        if $PROCESSOR_ARCHITECTURE == "AMD64"
            let g:processor_architecture = "x64"
        endif
    endif
    if exists("$USERDOMAIN")
        let g:pc_name = $USERDOMAIN
    endif
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

set cindent
set cinoptions=:0,g0,p0,t0,(0,W4

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
set laststatus=2
"set spell
set previewheight=4

if has("gui_running")
    " don't show toolbar
    set guioptions-=T 
    " don't show menu
    " set guioptions-=m
endif

if g:system == "windows"
    set fileformats=dos,unix
    if g:pc_name == "layan-PC"
        set guifont=Consolas:h11:cANSI
    elseif g:pc_name == "layan-nb"
        set guifont=Consolas:h12:cANSI
    else
        set guifont=Consolas:h12:cANSI
    endif
elseif g:system == "linux"
    set fileformats=unix,dos
    set guifont=Monospace\ 12

    let g:clang_use_library=0
    let g:clang_user_options='-stdlib=libstdc++ -std=c++11'
endif

cw 10
if g:system == "windows"
    language message en
endif

" syntax & color scheme
syntax enable
syntax on
colorscheme candycode


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All Plugins Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" cscope 
"

set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-

"
" indent_guides
"

let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0

"
" EasyBuffer
"

let g:easybuffer_toggle_position = 'HorizontalBelow'
let g:easybuffer_horizontal_height = '&lines/5'

" 
" PyDoc
"

let g:pydoc_cmd = 'python -m pydoc'
" let g:pydoc_open_cmd = 'vsplit'
" let g:pydoc_open_cmd = 'tabnew'

" 
" Tagbar
"

let g:tagbar_left = 1


"
" clang_complete
"

" no longer use clang_complete plugin.
"
"if g:system == "windows"
"    let g:clang_complete_auto = 1
"    let g:clang_complete_copen = 1
"    let g:clang_auto_user_options = 'path, .clang_complete'
"    let g:clang_use_library = 1
"    let g:clang_snippets = 1
"    let g:clang_snippets_engine = 'clang_complete'
"    let g:clang_hi_errors = 1
"endif

"
" netrw
"

let g:netrw_cygwin = 0
let g:netrw_scp_cmd = "pscp.exe -q"
let g:netrw_sftp_cmd = "psftp"

"
" NERDTree
" 

" N/A

"
" Omnicppcomplete
"

" N/A

" enable filetype detect and plugin and load corresponded indent file.
filetype plugin indent on

"
" YouCompleteMe
"

" enable this may slow the code complete and increase system memory usage.
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = $HOME . "\\vimfiles\\misc\\YouCompleteMe\\global_ycm_extra_conf.py"
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_max_diagnostics_to_display = 30

"
" SnipMate
"

" N/A

"
" MatchTagAlways 
" 

let g:mta_use_matchparen_group = 1

"
" rainbow_parentheses
"

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"
" ProtoDef
" 

let g:protodefctagsexe = $VIM . '\ctags.exe'
let g:protodefprotogetter = $HOME . "\\vimfiles\\bundle\\vim-protodef\\pullproto.pl"

"
" YankRing
"

" don't use default key because <C-P> should be reserved for Ctrl-P plugin.
let g:yankring_replace_n_pkey = '<C-Up>'
let g:yankring_replace_n_nkey = '<C-Down>'

"
" Gundo
"

" N/A

"
" python-mode
"

let g:pymode_lint_write = 0
let g:pymode_lint = 1
let g:pymode_lint_ignore = "C0303"
let g:pymode_folding = 1

"
" airline
"

let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_whitespace = 0

"
" Doxygen-support
"

let g:Doxy_LoadMenus = "no"

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
" set viminfo^=%

" 自動載入上次開啟時的 view, 包含手動建立的 fold.
" autocmd BufWinLeave *.h silent mkview
" autocmd BufWinEnter *.h silent loadview
" autocmd BufWinLeave *.c silent mkview
" autocmd BufWinEnter *.c silent loadview
" autocmd BufWinLeave *.cpp silent mkview
" autocmd BufWinEnter *.cpp silent loadview


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All Hot Keys Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" <leader> mappings
"

let mapleader = "\\"

" clear the search highlighting
     map <silent> <leader>l          :noh<CR>
 
" Useful mappings for managing tabs
     map <leader>tn                  :tabnew<CR>
     map <leader>to                  :tabonly<CR>
     map <leader>tc                  :tabclose<CR>
     map <leader>tm                  :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
     map <leader>te                  :tabedit <C-R>=expand("%:p:h")<CR>/<CR>

nnoremap <leader>jd                  :YcmCompleter GoToDefinitionElseDeclaration<CR>

 noremap <leader>yy                  "+y
 noremap <leader>pp                  "+p

     nmap <leader>w                  :set wrap!<CR>

 noremap <leader>sp                  :set spell!<CR>

" 
" Function Keys ( F1 ~ F12 ) mappings
"

" query the word under current cursor from local document.
     map <silent> <F1>               :call LocalDoc()<CR>
    imap <silent> <F1>          <C-O>:call LocalDoc()<CR>

" query the word under current cursor from online document.
     map <silent> <C-F1>             :call OnlineDoc()<CR>
    imap <silent> <C-F1>        <C-O>:call OnlineDoc()<CR>

" reload vim rc file.
     map <C-F2>                      :so $VIMRUNTIME/_vimrc<CR>
    imap <C-F2>                 <C-O>:so $VIMRUNTIME/_vimrc<CR>

" 用 F4 , S-F4 來切到下一個或上一個錯誤的位置
" 可以用 :copen 開啟 QuickFix Window
     map <silent> <F4>               :cn<CR>
    imap <silent> <F4>          <C-O>:cn<CR>
     map <silent> <S-F4>             :cp<CR>
    imap <silent> <S-F4>        <C-O>:cp<CR>

" Open and close all the three plugins (srcexpl, taglist, NERDTree) on the same time 
    nmap <C-F8>                      :TrinityToggleAll<CR> 
    nmap <C-F9>                      :TrinityToggleSourceExplorer<CR> 
    nmap <C-F10>                     :TrinityToggleTagList<CR> 
    nmap <C-F11>                     :TrinityToggleNERDTree<CR> 

" Toggle the Tagbar plugin, better than taglist plugin.
nnoremap <silent> <F10>              :TagbarToggle<CR>

" 
" ATL Keys mappings.
"

" use ATL-0 to toggle relatvienumber
     map <silent> <M-0>              :set relativenumber!<CR>
    imap <silent> <M-0>         <C-O>:set relativenumber!<CR>

" use ALT-1 to toggle the quickfix window.
     map <silent> <M-1>              :QFix<CR>
    imap <silent> <M-1>         <C-O>:QFix<CR>

" use ATL-2 to toggle EasyBuffer window
     map <silent> <M-2>              :EasyBufferToggle<CR>
    imap <silent> <M-2>         <C-O>:EasyBufferToggle<CR>

" use ATL-3 to toggle YankRing window.
nnoremap <silent> <M-3>              :YRShow<CR>

" use ATL-4 to toggle Gundo window.
nnoremap <silent> <M-4>              :GundoToggle<CR>

" search the word under cursor in this file 
" highlight the word and jump to the first position 
     map          <M-g>             *:vimgrep <cword> %<CR>
    imap          <M-g>   <C-O>*<C-O>:vimgrep <cword> %<CR>

" because YouCompleteMe has taken TAB key, we need to use another key for SnipMate plugin
    imap          <A-j>              <esc>a<Plug>snipMateNextOrTrigger
    smap          <A-j>              <Plug>snipMateNextOrTrigger

" use Atl-Up Atl-Down to swap two lines.
    nmap <silent> <M-Up>             :.m.-2<CR>
    nmap <silent> <M-Down>           :.m.+1<CR>
    imap <silent> <M-Up>        <C-O>:.m.-2<CR>
    imap <silent> <M-Down>      <C-O>:.m.+1<CR>

" use Atl-Left Atl-Right to switch to previous or next buffer.
    nmap <silent> <M-Left>           :bp<CR>
    nmap <silent> <M-Right>          :bn<CR>
    imap <silent> <M-Left>      <C-O>:bp<CR>
    imap <silent> <M-Right>     <C-O>:bn<CR>

" 
" Tab Keys mappings.
"

" use tab and Shift-Tab 做縮排 in normal mode and visual/select mode
    nmap <TAB>                      v>
    nmap <S-TAB>                    v<
    vmap <TAB>                      >gv
    vmap <S-TAB>                    <gv

"
" CTRL Keys Mapping
"

" easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" restore vim's C-i function
" CTRL-O: 回到前一個 jump 前的位置
" CTRL-I: 回到剛 jump 後的位置 
" help jump-motions
unmap <C-i>

" restore vim's c-a
nunmap <C-a>

nmap <HOME> ^
imap <HOME> <C-O>^

nnoremap Y y$

nnoremap / /\v
vnoremap / /\v

" easy align plugin hotkeys.
vnoremap <silent> <Enter> :EasyAlign<CR>

" vim-signature plugin hotkeys.
noremap <silent> <leader>mt :SignatureToggle<CR>

nnoremap & :&&<CR>
xnoremap & :&&<CR>

ab #i" #include "
ab #i< #include <
ab #i- //--------------------------------------------------------------------------------------------------
ab #i= //==================================================================================================
ab #i/ ////////////////////////////////////////////////////////////////////////////////////////////////////
ab dowhile do<CR>{<CR><CR>} while( 0 );

" highlight the redundant space.
match ErrorMsg '\s\+$'

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

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
            let s:arguments = "\"C:\\Python27\\Doc\\Python275.chm\""
        else
            let s:browser = "chrome"
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
    let s:browser = "chrome"
    let s:word_under_cursor = expand("<cword>")

    if &filetype == "cpp"
        let s:query_url = "http://social.msdn.microsoft.com/search/en-us?query="
    elseif &filetype == "python"
        let s:query_url = "http://www.google.com.tw/search?q=python+"
    else
        let s:query_url = "http://www.google.com.tw/search?q="
    endif

    let s:cmd = "!cmd /C start " . s:browser . " " . s:query_url . s:word_under_cursor
    silent execute s:cmd
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings for file type: Python and CPP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType c              call SetupCpp()
autocmd FileType C              call SetupCpp()
autocmd FileType cpp            call SetupCpp()
autocmd FileType CPP            call SetupCpp()

autocmd FileType python         call SetupPython()

autocmd FileType help           call SetupHelp()

autocmd FileType xml                exe ":silent 1,$!tidy --input-xml true --indent yes -q"
autocmd FileType html,html,xhtml    exe ":silent 1,$!tidy --indent yes -q"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! SetupPython()
    if exists( "s:setup_python_flag" ) && s:setup_python_flag == 1
        return
    endif

    let s:setup_python_flag = 1

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
    setlocal spell
 
    " note: python2 default encoding is ascii, python3 is utf-8
    ab pyencoding # -*- encoding: utf-8 -*-
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
    let cmd = '!C:\\Python' . g:python_version . '\\python.exe ' . base_name
    execute "update"
    execute cmd
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common CPP functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! AppendHomeTagsFiles(tags_file_list)
    let home_tags_dir = $HOME . "\\vimfiles\\tags\\"
    let append_tags_path = ""
    for tags_file in a:tags_file_list
        let append_tags_path = append_tags_path . home_tags_dir . tags_file . ","
    endfor
    let append_tags_path = escape(append_tags_path, ' ')
    execute "setlocal tags+=" . append_tags_path
endf

func! AppendHomePaths(lib_name_list)
    let home_path_dir = $HOME . "\\vimfiles\\path\\"
    let append_path = ""
    for lib_name in a:lib_name_list
        let append_path = append_path . home_path_dir . lib_name . ","
    endfor
    let append_path = escape(append_path, ' ')
    execute "setlocal path+=" . append_path
endf

func! AppendHomeCScopeFiles(lib_name_list)
    if g:load_default_cscope_files == 0
        return
    endif

    let home_cscope_dir = $HOME . "\\vimfiles\\cscope"
    execute "set nocscopeverbose"
    for lib_name in a:lib_name_list
        let append_cscope_path = home_cscope_dir . "\\" . lib_name . ".out"
        execute "cscope add " . append_cscope_path . " " . home_cscope_dir
    endfor
    execute "set cscopeverbose"
endf

func! SetupCpp()
    if exists( "s:setup_cpp_flag" ) && s:setup_cpp_flag == 1
        return
    endif

    let s:setup_cpp_flag = 1

    setlocal spell

    call SetupCppHotKeys()
    call SetupCppCompiler()
endf

func! GenerateCppCTagsFile()
    " generate ctags
    execute "!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q ."
endf

func! UpdateSingleCppCTagsFile()
    " update ctags
    let f = expand("%:p")
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    execute "!ctags -a -f " . tagfilename . " --c++-kinds=+p --fields=+liaS --extra=+q " . "\"" . f . "\""
endf

func! GenerateCppCScopeFile()
    " generate cscope
    if filereadable( "cscope.out" )
        execute "set nocscopeverbose"
        execute "cscope kill cscope.out"
        execute "set cscopeverbose"
    endif

    execute "!cscope -Rbk"
    if filereadable( "cscope.out" )
        execute "cscope add cscope.out"
    endif
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

    " use clang to check error
     map <buffer> <F6>                       :call g:ClangUpdateQuickFix()<CR>
    imap <buffer> <F6>                  <C-O>:call g:ClangUpdateQuickFix()<CR>
     map <buffer> <C-F6>                     :call g:ClangUpdateQuickFix()<CR>
    imap <buffer> <C-F6>                <C-O>:call g:ClangUpdateQuickFix()<CR>

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
     map <buffer> <F12>                      :call UpdateSingleCppCTagsFile()<CR><CR>
    imap <buffer> <F12>                 <C-O>:call UpdateSingleCppCTagsFile()<CR><CR>
     map <buffer> <C-F12>                    :call GenerateCppCTagsFile()<CR><CR>
    imap <buffer> <C-F12>               <C-O>:call GenerateCppCTagsFile()<CR><CR>
     map <buffer> <M-F12>                    :call GenerateCppCScopeFile()<CR><CR>
    imap <buffer> <M-F12>               <C-O>:call GenerateCppCScopeFile()<CR><CR>

endf

func! SetupCppCompiler()
    " determine the cpp compiler name according to current environment.
    if g:system == "windows"
        if stridx($VSINSTALLDIR, "Microsoft Visual Studio 9.0") >= 0
            let g:cpp_compiler = "vc9"
        elseif stridx($VSINSTALLDIR, "Microsoft Visual Studio 10.0") >= 0
            let g:cpp_compiler = "vc10"
        elseif stridx($VSINSTALLDIR, "Microsoft Visual Studio 11.0") >= 0
            let g:cpp_compiler = "vc11"
        else
            let g:cpp_compiler = "mingw"
        endif
    elseif g:system == "linux"
        let g:cpp_compiler = "gcc"
    endif

    if g:make_output == ""
        if g:system == "windows"
            let g:make_output = expand("%:r") . '.exe'
        elseif g:system == "linux"
            let g:make_output = './a.out'
        endif
    endif

    " reset path and tags
    setlocal path=.
    setlocal tags=./tags,./TAGS,tags,TAGS

    if g:system == "windows"
        " append the common path file.
        let lib_name_list = [ "stl", "wtl81" ]
        call AppendHomePaths(lib_name_list)
        " append the common tags file.
        let tags_file_list = [ "stl", "baseclasses", "wtl81" ]
        call AppendHomeTagsFiles(tags_file_list)
        " append the common cscope file.
        let cscope_file_list = [ "stl", "baseclasses", "wtl81" ]
        call AppendHomeCScopeFiles(cscope_file_list)
    endif

    " call the corresponded setup cpp compiler function.
    let compiler_list = [ 
        \[ "gcc", "SetupGCCCompiler" ],
        \[ "vc9", "SetupVC9Compiler" ],
        \[ "vc10", "SetupVC10Compiler" ],
        \[ "vc11", "SetupVC11Compiler" ],
        \[ "mingw", "SetupMinGWCompiler" ] 
        \ ]
    for [ compiler_name, setup_func_name ] in compiler_list
        if g:cpp_compiler == compiler_name
            execute 'call ' . setup_func_name . '()'
            break
        endif
    endfor
endf

func! MakeCppProject()
    if g:cpp_compiler == "gcc"
        call GCCMakeCppProject()
    elseif g:cpp_compiler == "vc9"
        call VC9MakeCppProject()
    elseif g:cpp_compiler == "vc10"
        call VC10MakeCppProject()
    elseif g:cpp_compiler == "vc11"
        call VC11MakeCppProject()
    elseif g:cpp_compiler == "mingw"
        call MinGWMakeCppProject()
    else
        echo "There is No Cpp Compiler"
    endif
endf

func! CompileCppUnit()
    if g:cpp_compiler == "gcc"
        call GCCCompileCppUnit()
    elseif g:cpp_compiler == "vc9"
        call VC9CompileCppUnit()
    elseif g:cpp_compiler == "vc10"
        call VC10CompileCppUnit()
    elseif g:cpp_compiler == "vc11"
        call VC11CompileCppUnit()
    elseif g:cpp_compiler == "mingw"
        call MinGWCompileCppUnit()
    else
        echo "There is No Cpp Compiler"
    endif
endf

func! RunCppProject()
    silent execute '!start ' . g:make_output
endf

"
" GCC functions.
"

func! SetupGCCCompiler()
    compiler gcc

    " add include folders to path
    setlocal path+=/usr/include/,
                \/usr/include/c++/4.6/,
                \/usr/include/boost/

    setlocal tags+=/usr/include/c++/4.6.3/tags,/usr/include/tags
endf

func! GCCMakeCppProject()
    setlocal makeprg=make
    execute "update"
    execute "make"
endf

func! GCCCompileCppUnit()
    setlocal makeprg=g++\ -std=c++11\ %
    execute "update"
    execute "make"
endf

"
" VC9 functions
"

func! SetupVC9Compiler()
    " set errorformat.
    setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m,
                        \%f(%l)\ :\ fatal\ error\ C%n:\ %m,
                        \%f(%l):\ error\ C%n:\ %m,
                        \%f(%l):\ fatal\ error\ C%n:\ %m

    " use $INCLUDE environment variable value and replace ';' to ',' and need
    " to escape ' ' and '\' before we set to path.
    let l:inc = substitute($INCLUDE, ';', ',', 'g')
    let l:inc = escape(l:inc, '\')
    let l:inc = substitute(l:inc, ' ', '\\\\\\ ', 'g')
    " disable set path to avoid reducing the performance of tab complete function.
    "execute "setlocal path+=" . l:inc

    call AppendHomePaths( ["vc9_crt"] )
    let tags_file_list = [ "vc9_crt", "vc9_atlmfc", "winsdk70" ]
    call AppendHomeTagsFiles(tags_file_list)
    call AppendHomeCScopeFiles(tags_file_list)
endf

func! VC9MakeCppProject()
    let exe = "C:\\Windows\\Microsoft.NET\\Framework\\v3.5\\MSBuild.exe"
    let args = " /nologo /v:m /t:" . g:make_target . " /p:configuration=" . g:make_config . " /clp:NoSummary"
    if g:make_proj != ""
        let args = args . " " . g:make_proj
    endif
    execute "setlocal makeprg=" . exe . escape(args, ' ')
    execute "update"
    execute "make"
endf

func! VC9CompileCppUnit()
    setlocal makeprg=cl\ /nologo\ /EHsc\ %
    execute "update"
    execute "make"
endf

"
" VC10 functions
"

func! SetupVC10Compiler()
    " set errorformat.
    setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m,
                        \%f(%l)\ :\ fatal\ error\ C%n:\ %m,
                        \%f(%l):\ error\ C%n:\ %m,
                        \%f(%l):\ fatal\ error\ C%n:\ %m

    " use $INCLUDE environment variable value and replace ';' to ',' and need
    " to escape ' ' and '\' before we set to path.
    let l:inc = substitute($INCLUDE, ';', ',', 'g')
    let l:inc = escape(l:inc, '\')
    let l:inc = substitute(l:inc, ' ', '\\\\\\ ', 'g')
    " disable set path to avoid reducing the performance of tab complete function.
    "execute "setlocal path+=" . l:inc

    call AppendHomePaths( ["vc10_crt"] )

    let tags_file_list = [ "vc10_crt", "vc10_atlmfc", "winsdk70a" ]
    call AppendHomeTagsFiles(tags_file_list)
    call AppendHomeCScopeFiles(tags_file_list)
endf

func! VC10MakeCppProject()
    let exe = "MSBuild.exe"
    let args = " /nologo /v:m /t:" . g:make_target . " /p:configuration=" . g:make_config . " /clp:NoSummary"
    if g:make_proj != ""
        let args = args . " " . g:make_proj
    endif
    execute "setlocal makeprg=" . exe . escape(args, ' ')
    execute "update"
    execute "make"
endf

func! VC10CompileCppUnit()
    setlocal makeprg=cl\ /EHsc\ /nologo\ %
    execute "update"
    execute "make"
endf


"
" VC11 functions
"


func! SetupVC11Compiler()
    " set errorformat.
    setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m,
                        \%f(%l)\ :\ fatal\ error\ C%n:\ %m,
                        \%f(%l):\ error\ C%n:\ %m,
                        \%f(%l):\ fatal\ error\ C%n:\ %m
    
    " use $INCLUDE environment variable value and replace ';' to ',' and need
    " to escape ' ' and '\' before we set to path.
    let l:inc = substitute($INCLUDE, ';', ',', 'g')
    let l:inc = escape(l:inc, '\')
    let l:inc = substitute(l:inc, ' ', '\\\\\\ ', 'g')
    " disable set path to avoid reducing the performance of tab complete function.
    "execute "setlocal path+=" . l:inc

    call AppendHomePaths( ["vc11_crt"] )

    let tags_file_list = [ "vc11_crt", "vc11_atlmfc", "winsdk80_shared", "winsdk80_um" ]
    call AppendHomeTagsFiles(tags_file_list)
    call AppendHomeCScopeFiles(tags_file_list)
endf

func! VC11MakeCppProject()
    let exe = "MSBuild.exe"
    let args = " /nologo /v:m /t:" . g:make_target . " /p:configuration=" . g:make_config . " /clp:NoSummary"
    if g:make_proj != ""
        let args = args . " " . g:make_proj
    endif
    execute "setlocal makeprg=" . exe . escape(args, ' ')
    execute "update"
    execute "make"
endf

func! VC11CompileCppUnit()
    setlocal makeprg=cl\ /EHsc\ /nologo\ %
    execute "update"
    execute "make"
endf

"
" MinGW functions.
"

func! SetupMinGWCompiler()
    compiler gcc

    " add include folders to path
    "setlocal path+=C:\\MinGW\\lib\\gcc\\mingw32\\4.7.0\\include\\c++,
    "            \C:\\MinGW\\include
endf

func! MinGWMakeCppProject()
    setlocal makeprg=mingw32-make.exe
    execute "update"
    execute "make"
endf

func! MinGWCompileCppUnit()
    let cmd = "g++.exe -std=c++11 -msse2 " . expand("%") . " -o " . expand("%:t:r") . ".exe"
    execute "setlocal makeprg=" . escape(cmd, ' ')
    execute "update"
    execute "make"
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HELP functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! SetupHelp()
    " navigate to the link via ENTER key and get back via BACK key.
    nmap <buffer> <CR> <C-]>
    nmap <buffer> <BS> <C-T>
endf

