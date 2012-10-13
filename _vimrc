let $LANG="zh_TW.UTF-8"
set langmenu=zh_tw.utf-8
set encoding=utf8

"reload menu with UTF-8 encoding
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
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
endfunction

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


set tabstop=4
set shiftwidth=4
set softtabstop=4
set showmatch

set incsearch
set number
set hlsearch
set ruler
set cursorline     " cul <= highlight the current line.
set foldcolumn=2

" syntax & color scheme
syntax enable
syntax on
colorscheme koehler

" Open and close all the three plugins on the same time 
nmap <C-F8>   :TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
nmap <C-F9>   :TrinityToggleSourceExplorer<CR> 
" Open and close the taglist.vim separately 
nmap <C-F10>  :TrinityToggleTagList<CR> 
" Open and close the NERD_tree.vim separately 
nmap <C-F11>  :TrinityToggleNERDTree<CR> 

" comment this line.
map <C-K><C-C> I//<ESC>
" uncomment this line.
map <C-K><C-U> ^2x<ESC>

map  <A-g> <C-]>
map! <A-g> <C-]>

""""""""""""""""""""""""""""""""""""""""""""""""""
" enable omnicppcomplete plugin
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp

" enable filetype detect and pluing and load corresponded indent file.
filetype plugin indent on

" see :h omnicppcomplete
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C++ .<CR>

unmap <C-Y>

" configuration for python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab makeprg=python\ %

" configuration for cpp
autocmd FileType cpp call SetupVCEnvironment()
"autocmd FileType cpp call SetupBCBEnvironment()

" automaitcally show quickfix window if there are any errors.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

map  <F7>       : call MakeProject() <CR>
map! <F7> <ESC> : w <CR> : call MakeProject() <CR>

" query the word under current cursor in MSDN
map  <silent> <F1>       : call LocalDoc() <CR>
imap <silent> <F1> <ESC> : call LocalDoc() <CR>

map  <silent> <C-F1>       : call OnlineDoc() <CR>
imap <silent> <C-F1> <ESC> : call OnlineDoc() <CR>

func! SetupVCEnvironment()
    set makeprg=C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe\ /nologo\ /v:q\ /t:build\ /p:configuration=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    set errorformat=%f(%l):\ error\ C%n:\ %m
	" add binary folders
	"set path+=C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\\VC\\bin
	"set path+=C:\\Program\\\ Files\\Microsoft\\\ SDKs\\Windows\\v7.0\\Bin
	"set path+=C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\\VC\\vcpackages
	" add include folders
	set path+=C:\\Program\\\ Files\\Microsoft\\\ SDKs\\Windows\\v7.0\\Include	
	set path+=C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\VC\include
	set path+=C:\\Program\\\ Files\\Microsoft\\\ Visual\\\ Studio\\\ 9.0\\VC\\atlmfc\\include
endf

func! SetupBCBEnvironment()
    set makeprg=msbuild\ /nologo\ /v:n\ /t:build\ /p:config=debug\ /p:GenerateFullPaths=true\ /clp:NoSummary
    set errorformat=%f(%l):\ error\ E%n:\ %m
	" add binary folders
	"set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\bin
	"set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include
	" add include folders
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\atl
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\boost_1_35
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\dinkumware
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\Indy10
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\vcl
	set path+=C:\\Program\\\ Files\\CodeGear\\RAD\\\ Studio\\6.0\\include\\include
endf
     
func! MakeProject()
	exec "update"
	exec "make"
	"exec "cw"
endfunc

func! LocalDoc()
	let s:dexplore = "\"C:\\Program Files\\Common Files\\microsoft shared\\Help 9\\dexplore.exe\""
	let s:wordUnderCursor = expand("<cword>")
	let s:arguments = "/helpcol ms-help://MS.W7SDK.1033 /usehelpsettings WindowsSDK.1.0 /LaunchFKeywordTopic " . s:wordUnderCursor
	let s:cmd = "silent !start " . s:dexplore . " " . s:arguments
	execute s:cmd
endfunc

" setup integrated help
func! OnlineDoc()
	let s:browser = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\""
	let s:wordUnderCursor = expand("<cword>")
	let s:url = "http://social.msdn.microsoft.com/search/en-us?query=" . s:wordUnderCursor
	let s:cmd = "silent !start " . s:browser . " " . s:url
	execute s:cmd
endfunc

cw 10


