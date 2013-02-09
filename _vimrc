""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Hints
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jump to the tag under current cursort with a new window: 
"    ^Wg] or ^W] 


" 在 insert mode 要刪除同一 word 游標前的字元:
"    ^W


" set, setlocal and setglobal 指令的不同處:
" set:	     改變全部的 buffer or window 的 global 和 local value
" setlocal:	 改變目前的 buffer or window 的 local value, 而不影響 global value
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

if g:system == "windows"
	let g:cpp_compiler = $BDS != "" ? "bcb" : "vc90"
elseif g:system == "linux"
	let g:cpp_compiler = "gcc"
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
set magic			" for regular expressions turn magic on
set background=dark

if g:system == "windows"
    set fileformats=dos,unix
    set guifont=Consolas:h10:cANSI
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

" syntax & color scheme
syntax enable
syntax on
colorscheme wombat

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
nmap <C-F8>			:TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
nmap <C-F9>			:TrinityToggleSourceExplorer<CR> 
" Open and close the taglist.vim separately 
nmap <C-F10>		:TrinityToggleTagList<CR> 
" Open and close the NERD_tree.vim separately 
nmap <C-F11>		:TrinityToggleNERDTree<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for Omnicppcomplete plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype detect and pluing and load corresponded indent file.
filetype plugin indent on

" see :h omnicppcomplete
 map <C-F12>			 :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C++ .<CR><CR>
imap <C-F12>		<C-O>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C++ .<CR><CR>

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

" Disable highlight when <leader><cr> is pressed
 map <silent> <leader>cr         :noh<CR>
 
" Useful mappings for managing tabs
 map <leader>tn :tabnew<CR>
 map <leader>to :tabonly<CR>
 map <leader>tc :tabclose<CR>
 map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
 map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/<CR>

" query the word under current cursor in MSDN
 map <silent> <F1>				 :call LocalDoc()<CR>
imap <silent> <F1>			<C-O>:call LocalDoc()<CR>

 map <silent> <C-F1>             :call OnlineDoc()<CR>
imap <silent> <C-F1>		<C-O>:call OnlineDoc()<CR>

" 用 F4 , S-F4 來切到下一個或上一個錯誤的位置
" 可以用 :copen 開啟 QuickFix Window
 map <silent> <F4>			     :cn<CR>
imap <silent> <F4>			<C-O>:cn<CR>
 map <silent> <S-F4>		     :cp<CR>
imap <silent> <S-F4>		<C-O>:cp<CR>

 map <M-g>                       *:vimgrep <cword> %<CR>
imap <M-g>                  <C-O>*<C-O>:vimgrep <cword> %<CR>

func! LocalDoc()
	let s:dexplore = "\"C:\\Program Files\\Common Files\\microsoft shared\\Help 9\\dexplore.exe\""
	let s:word_under_cursor = expand("<cword>")
	let s:arguments = "/helpcol ms-help://MS.W7SDK.1033 /usehelpsettings WindowsSDK.1.0 /LaunchFKeywordTopic " . s:word_under_cursor
	let s:cmd = "silent !start " . s:dexplore . " " . s:arguments
	execute s:cmd
endf

func! OnlineDoc()
	let s:browser = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\""
	let s:word_under_cursor = expand("<cword>")
	let s:url = "http://social.msdn.microsoft.com/search/en-us?query=" . s:word_under_cursor
	let s:cmd = "silent !start " . s:browser . " " . s:url
	execute s:cmd
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings for file type: Python and CPP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType c			call SetupCpp()
autocmd FileType C			call SetupCpp()
autocmd FileType cpp		call SetupCpp()
autocmd FileType CPP		call SetupCpp()
autocmd FileType python		call SetupPython()

func! SetupPython()
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

	"
	" hotkeys
	"
	
	" run the script
	 map <buffer> <silent> <F5>			     :!python %<CR><CR>
	imap <buffer> <silent> <F5>			<C-O>:!python %<CR><CR>
	 map <buffer> <silent> <C-F5>		     :!python %<CR><CR>
	imap <buffer> <silent> <C-F5>		<C-O>:!python %<CR><CR>

	" comment current line.
	 map <buffer> <C-K><C-C>				 I# <ESC>
	imap <buffer> <C-K><C-C>			<ESC>I# 

	" uncomment current line.
	 map <buffer> <C-K><C-U>		         ^2x<ESC>
	imap <buffer> <C-K><C-U>			<ESC>^2xi

endf

func! SetupCpp()
	call SetupCppHotKeys()
	if g:cpp_compiler == "gcc"
		call SetupGCC()
	elseif g:cpp_compiler == "bcb"
		call SetupBCB()
	elseif g:cpp_compiler == "vc90"
		call SetupVC90()
	endif
endf


func! SetupCppHotKeys()
	" comment this line.
	 map <C-K><C-C>							 I// <ESC>
	imap <C-K><C-C>						<ESC>I// 

	" uncomment this line.
	 map <C-K><C-U>							 ^3x<ESC>
	imap <C-K><C-U>						<ESC>^3xi

	 map <C-K><C-F>							 :vimgrep <cword> **/*.cpp **/*.h<CR>
	imap <C-K><C-F>						<C-O>:vimgrep <cword> **/*.cpp **/*.h<CR>

	 map <buffer> <F5>					     :call RunProject()<CR><CR>
 	imap <buffer> <F5>					<C-O>:call RunProject()<CR><CR>
	 map <buffer> <C-F5>				     :call RunProject()<CR><CR>
	imap <buffer> <C-F5>				<C-O>:call RunProject()<CR><CR>	 
endf

func! RunProject()
	let base_name = expand("%:r")
	let cmd = '!' . base_name . '.exe'
	execute cmd
endf


"
" GCC functions.
"

func! SetupGCC()
	compiler gcc
	setlocal makeprg=g++\ -std=c++0x\ % 

    " add include folders to path
    setlocal path=.,
                \/usr/include/,
                \/usr/include/c++/4.6/,
                \/usr/include/boost/

    setlocal tags=/usr/include/c++/4.6.3/tags,/usr/include/tags,./tags,./TAGS,tags,TAGS

	"
	" hotkeys
	"
	 map <buffer> <F5>					     :call GCCRunProject()<CR>
 	imap <buffer> <F5>					<C-O>:call GCCRunProject()<CR>
	 map <buffer> <C-F5>				     :call GCCRunProject()<CR>
	imap <buffer> <C-F5>				<C-O>:call GCCRunProject()<CR>
	
	 map <buffer> <C-F7>				     :call GCCCompileCppUnit()<CR><CR>
	imap <buffer> <C-F7>				<C-O>:call GCCCompileCppUnit()<CR><CR>
endf

func! GCCCompileCppUnit()
	setlocal makeprg=g++\ -std=c++0x\ %
	execute "update"
	execute "make"
endf

func! GCCRunProject()
    let cmd = "!./a.out"
    execute cmd
endf

"
" BCB functions.
"

func! SetupBCB()
	" make program settings
    setlocal makeprg=C:\Windows\Microsoft.NET\Framework\v2.0.50727\MSBuild.exe\ /nologo\ /v:n\ /t:make\ /p:config=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    setlocal errorformat=%f(%l):\ error\ E%n:\ %m

	" add include folders to path
	setlocal path=.,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\vcl,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\atl,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\boost_1_35,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\dinkumware,
				  \C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\Indy10

	"
	" hotkeys
	"

	 map <buffer> <F7>						 :call BCBMakeProject()<CR><CR>
	imap <buffer> <F7>					<C-O>:call BCBMakeProject()<CR><CR>
	 map <buffer> <C-F7>					 :call BCBCompileCppUnit()<CR><CR>
	imap <buffer> <C-F7>				<C-O>:call BCBCompileCppUnit()<CR><CR>	 
endf

func! BCBMakeProject()
	execute "update"
	execute "make"
endf

func! BCBCompileCppUnit()
	echo "not implement yet..."
endf

"
" VC90 functions
"

func! SetupVC90()
	" add include folders to path
	setlocal path=.,
				  "\C:\\Program\\\ Files\\Microsoft\\\ SDKs\\Windows\\v7.0\\Include,
				  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 11.0\VC\include,
				  \C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 11.0\\VC\\atlmfc\\include

	"
	" hotkeys
	"
	
	" 多一個 <CR> 是因為在外部程式結束後 VIM 會跳一個請按任意鍵繼續.
	 map <buffer> <F7>						 :call VC90MakeProject()<CR><CR>
	imap <buffer> <F7>					<C-O>:call VC90MakeProject()<CR><CR>
	 map <buffer> <C-F7>					 :call VC90CompileCppUnit()<CR><CR>
	imap <buffer> <C-F7>				<C-O>:call VC90CompileCppUnit()<CR><CR>
endf

func! VC90MakeProject()
    setlocal makeprg=C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe\ /nologo\ /v:q\ /t:build\ /p:configuration=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    setlocal errorformat=%f(%l):\ error\ C%n:\ %m
	execute "update"
	execute "make"
endf

func! VC90CompileCppUnit()
	setlocal makeprg=cl\ %
	setlocal errorformat=%f(%l)\ :\ error\ C%n:\ %m
	execute "update"
	execute "make"
endf
