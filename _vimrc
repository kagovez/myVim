set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin


" For OS Environment Detection
if(has("win32") || has("win95") || has("win64") || has("win16"))
    "let g:vimrc_iswindows=1
    let g:iswindows=1
else
    "let g:vimrc_iswindows=0
    let g:iswindows=0
endif


" For Vundle
let g:useVundle=1
filetype off					"required!
if(g:iswindows==1)
    if(g:useVundle==1)
	    " set the runtime path to include Vundle and initialize
        set rtp+=c:/tc/vim/vimfiles/bundle/Vundle.vim
		" let Vundle manage Vundle, required
        call vundle#begin('c:/tc/vim/vimfiles/bundle/')
        Plugin 'gmarik/vundle'
        Plugin 'kien/ctrlp.vim'
        Plugin 'vim-scripts/nerdtree-execute'
        Plugin 'vim-scripts/taglist.vim'
        Plugin 'vim-scripts/SrcExpl'
        Plugin 'vim-scripts/Trinity'
        "Plugin 'vim-scripts/TagHighlight'		"this fails to work over Windows
        Plugin 'abudden/taghighlight-automirror'
        call vundle#end()				"required!
        filetype plugin indent on 			"required!
    endif
else
    " For Linux
    " let Vundle manage Vundle, required
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin('c:/tc/vim/vimfiles/bundle/')
    Plugin 'gmarik/vundle'
    Plugin 'kien/ctrlp.vim'
    Plugin 'vim-scripts/nerdtree-execute'
    Plugin 'vim-scripts/taglist.vim'
    Plugin 'vim-scripts/SrcExpl'
    Plugin 'vim-scripts/Trinity'
    "Plugin 'vim-scripts/TagHighlight'		"this fails to work over Windows
    Plugin 'abudden/taghighlight-automirror'
    call vundle#end()				"required!
    filetype plugin indent on 			"required!
endif


" Basic Settings
"colorscheme tango
colorscheme apprentice
"colorscheme Tomorrow-Night-Eighties

set cursorline "���u �ثe��Ц�m
set nu	"Display Line Number
set hlsearch
set incsearch
set showcmd
set mouse=a
set ruler
syntax on

"nmap <C-n> :tnext<CR><CR>
"nmap <C-b> :tp<CR><CR>
"Omni completion enabled
"set omnifunc=syntaxcomplete#Complete
"set nocp  
"filetype plugin on




" Function MyDiff()
set diffexpr=
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


" For CtrlP
let g:ctrlp_root_markers = ['ctrlp.root']
"let g:ctrlp_max_files = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*.o,*.ewp,*.ewd,*.ewt,*.dep  " IAR
set wildignore+=*.ioc			     " CUBEMX


" For Ctags F12
"   reference:
"   http://www.vimer.cn/2009/10/%E6%8A%8Avim%E6%89%93%E9%80%A0%E6%88%90%E4%B8%80%E4%B8%AA%E7%9C%9F%E6%AD%A3%E7%9A%84ide2.html
"   http://blog.csdn.net/backgarden_straw/article/details/7971495
"
"   https://github.com/sunnyss12/vim
"if(has("win32") || has("win95") || has("win64") || has("win16"))
"    "let g:vimrc_iswindows=1
"    let g:iswindows=1
"else
"    "let g:vimrc_iswindows=0
"    let g:iswindows=0
"endif
autocmd BufEnter * lcd %:p:h
" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
" 
"   reference:
"   http://www.vimer.cn/2009/10/%E6%8A%8Avim%E6%89%93%E9%80%A0%E6%88%90%E4%B8%80%E4%B8%AA%E7%9C%9F%E6%AD%A3%E7%9A%84ide2.html
if(g:iswindows==1)
    map <F12> :call Do_CsTag()<CR>
else
    map <F7> :call Do_CsTag()<CR>
endif
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


" Function Do_CsTag()
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        silent! execute "!ctags -R --c-types=+p --fields=+S *"
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            "silent! execute !find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"

	    ""For CHRE linker script:
            "silent! execute !find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.lkr' > cscope.files"

	    ""For CHRE linker script:
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.lkr' -o -name '*.ld' > cscope.files"
        else
            "silent! execute !dir /s/b *.c,*.h,*.s >> cscope.files"

	    ""For CHRE linker script:
            silent! execute "!dir /s/b *.c,*.h,*.s,*.lkr >> cscope.files"	
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"//==============================================================
"vim-airline settings:
"set encoding=utf-8
"set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
"if $COLORTERM == 'gnome-terminal'
"	set t_CO=256
"endif
"set status line
"set laststatus=2
"enable powerline-fonts
"let g:airline_powerline_fonts=1
"Theme setting
"let g:airline_theme='aurora'
"Enable tabline
"let g:airline#extensions#tabline#enabled=1


" For SrcExpl - The switch of the Source Explorer 
" // makred by Ethan on 2015.08.12
" // nmap <F7> :SrcExplToggle
" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 
" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 
" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 
" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 
" // In order to Avoid conflicts, the Source Explorer should know what plugins 
" // are using buffers. And you need add their bufname into the list below 
" // according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 
" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 
" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" //  create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>"  

" For Trinity
" Open and close all the three plugins on the same time 
nmap <F8>  :TrinityToggleAll
" Open and close the Taglist separately 
" nmap <F10> :TrinityToggleTagList				//changed by Ethan on 2015.08.12
nmap <F9> :TrinityToggleTagList
" Open and close the Source Explorer separately 
" nmap <F9>  :TrinityToggleSourceExplorer			//changed by Ethan on 2015.08.12
nmap <F10>  :TrinityToggleSourceExplorer
" Open and close the NERD Tree separately 
nmap <F11> :TrinityToggleNERDTree


" For taglist
if(g:iswindows==1)
"let Tlist_Ctags_Cmd = 'C:\mytools\ctags58\ctags.exe'
"let Tlist_Ctags_Cmd = 'C:\tc\ForVim\ctags.exe'
let Tlist_Ctags_Cmd = 'C:\ctags58\ctags.exe'
endif


" For GNUGrep
if(g:iswindows==1)
":let Grep_Path = 'C:\mytools\GnuWin32\bin\grep.exe'
:let Grep_Path = 'C:\tc\BuildTools_2-9-20170629-1013\bin\bin\busybox\grep.exe'
endif


" For autoloading cscope
" source:
" https://stackoverflow.com/questions/12243233/how-to-auto-load-cscope-out-in-vim
if has("cscope")
  "set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " set cspc=3
  " add any database in current directory
  if filereadable("cscope.out")
	  "cs add cscope.out
	  "Modified by Ethan, 2015-1-15
	  let cwd = getcwd()
	  exe "cs add cscope.out" cwd
  else
      let cscope_file=findfile("cscope.out", ".;")
      let cscope_pre=matchstr(cscope_file, ".*/")
      "echo cscope_file
      if !empty(cscope_file) && filereadable(cscope_file)
         exe "cs add" cscope_file
      endif      
  endif
  set csverb
endif


"=========================================================================================================="
" reference:
" https://github.com/sunnyss12/vim
"
"##�ϥ�ctags cscope��?��?���?��?����k
"
"�����w?ctags�Mcscope�A?�_centos�t?�w?��k?�Gyum install ctags�Byum install cscope�C
"�p�G�{�Ǧ���?�A�ݭn�b�{�ǳ̥~������?�U�ϥ�vim��?���A�_?�ϥ�cscope��?�d��?���??��?�C
"�p�G�{�Ǧ���?�A?�t�m���Mbundle�w?�w?�F��???����A�u�n�b�{�ǳ̥~��?��vim�A?��?��?��???����A�ϥ�?����i�H��?�h?���C
"�p�G�{�Ǧ��h?���A�u�ݭn��?�䤤�@?���A�M�Z���UF12�A???��W����Do_CsTag()��?�A?��??�ͦ�ctags cscope�Τ_��???���R����?���Gtags�Mcscope.out���C
"�p�G�ϥ�ctags?���???�A���?��?���?�W?�A�M�Z���U���UCtrl+]�A??�D?���?�Ҧb��?���w??�F���UCtrl+t,??�^��W���D?�e����m?�C
"�p�G�ϥ�cscope?���???�A���?��?���?�W?�A�M�Z���U:Ctrl+g,???��cscope find g ��?�W�C �p�GCtrl+]�䤣���?�w??�A�i�H????�C���u�ڪ�??�A�p�GCtrl+g?������A�i�H�A??Ctrl + s�F�bc++��󤤡A�p�G��?�Q���#include���Y??���A�i�H���?���V?���A�M�Z���UCtrl+f�Y�i�C?�L?�R�O�b�W�����t�m72-80��??��F�M�g�C��Lcscope�R�O����?�i�H?��:http://vimcdoc.sourceforge.net/doc/if_cscop.html#:cscope
"�ثevim��??�A?��?�[??�e��?��tags�Mcscope.out���C�p�G�Q�[?��L��?��tags�Mcscope.out���A�i�H�b�t�m��󤤦�?�K�[�C��p�W���t�m��set tags+=/usr/include/c++/tags�Mexecute "cs add /usr/include/c++/cscope.out /usr/include/c++",??�y?�O?�F��?vim?�[?/usr/include/c++��?�U��tags�Mcscope.out�A??�i�H�b�d��c++?���?�w���?��?�C
"�ϥ�taglist�G?��:Tlist�Ϊ�\tl�i�H��?taglist�A??���f��?�Fctags??���Ҧ���?�C�A�����U\tl�i�H����taglist�C�btaglist�U�d�ݲĤ@?��?�w?�i�H���U:tag�A�U�@?��?�w?�i�H:tnext�C
"~/.vimrc�u??�e�n?��?�_�@�ΡA/etc/vimrc�Ovim�������t�m���A?�Ҧ���?����@�ΡA�q?��?�U/etc/vimrc�]?�[??�e��?��cscope.out���A���O?������cscope.out����?��?�A??�ϥ�ctrl+f�d��?���??��?�A�ݭn?����"cs add $PWD/cscope.out"�ק�?cs add $PWD/cscope.out $PWD"�C/etc/vimrc���Fetc_vimrc���C

"=========================================================================================================="
" scripts from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Plugin 'FuzzyFinder'
" scripts not on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" ...

"filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line
"=========================================================================================================="

"All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
