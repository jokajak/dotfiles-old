if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set smartindent         " smart indent
"set backup		" keep a backup file
set backup
set writebackup
" Rename the file to the backup when possible.
set backupcopy=auto
" Don't store all the backup and swap files in the current working dirctory.
set backupdir=$HOME/.vim/backups     " where to put backup file
set directory=$HOME/.vim/temp       " directory is the directory for temp file

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif


if &term=="xterm"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

set showmatch
set incsearch

if !exists(":DiffOrig")
	  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

if has('mouse')
   set mouse=a
endif

set title
if has('title') && (has('gui_running') || &title)
  set titlestring=
  set titlestring+=%f                    " file name
  set titlestring+=%(\ %h%m%r%w%)        " flags
  set titlestring+=\ -\ %{v:progname}    " program name
endif
set titleold=


set backup
set writebackup
" Rename the file to the backup when possible.
set backupcopy=auto
" Don't store all the backup and swap files in the current working dirctory.
set backupdir=$HOME/.vim/backups     " where to put backup file
set directory=$HOME/.vim/temp       " directory is the directory for temp file

" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Better command-line completion
set wildmenu

" Nifty completion menu
set wildignore+=*.o,*~
set wildmode=longest:full,full
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F10>

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

set autoindent                  " Always set autoindenting on
set expandtab                   " Always expand tabs to spaces
set shiftwidth=4                " Use 4 spaces for each level of indention
set smarttab                    " Use 'sw' at begining of line, 'ts' otherwise
set softtabstop=8               " To make backspacing over expanded tabs easier
set tabstop=8                   " What tabs are meant to be

" Editing {{{2
set backspace=indent,eol,start  " More powerful backspacing
set nrformats=hex,octal,alpha   " Recognize hexadecimal, octal, and characters for ctrl-a/x
set textwidth=78                " Seems like a good place to break lines
set wrapmargin=0                " Don't break lines based on window size

" Formatting {{{2
set formatoptions=
set formatoptions+=c            " Format comments
set formatoptions+=r            " Continue comments by default
set formatoptions+=o            " Make comment when using o or O from comment line
set formatoptions+=q            " Format comments with gq
set formatoptions+=n            " Recognize numbered lists
set formatoptions+=2            " Use indent from 2nd line of a paragraph
set formatoptions+=l            " Don't break lines that are already long
set formatoptions+=1            " Break before 1-letter words
 
set formatlistpat=^\\s*\\(\\d\\+\\\|\\*\\\|-\\\|•\\)[\\]:.)}\\t\ ]\\s*

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map W to w so that when you hit :W it writes it as expected
cmap W w

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Map \dtw to delete trailing whitespace (devils)
map <leader>dtw :%s/\s\+$//g<CR>       ' Delete Trailing Whitespace

"------------------------------------------------------------

" Display {{{2
if (has('gui_running') || &t_Co > 16) && exists('&cursorline')
  set cursorline " Highlight the current line
endif
set display=lastline " Show as much as possible of wrapped lines
if exists('&foldcolumn')
  set foldcolumn=1 " Show top-level fold sections
endif
set nofoldenable " Disable folds by default
set foldmethod=syntax " Fold by syntax
set linebreak " Don't wrap words
set list " Add visual clues (disables 'linebreak')
set number " Show line numbers
set numberwidth=4
set wrap " Wrap long lines
 
set listchars=
if has('multi_byte') && (&tenc =~? '^u\(tf\|cs\)' || (! strlen(&tenc) && &enc =~? '^u\(tf\|cs\)')) && (v:version >= 602 || v:version == 601 && has('patch469'))
"set listchars+=eol:§
  set listchars+=tab:»·
  try
    set listchars+=nbsp:+
  endtry
  set listchars+=trail:·
  set listchars+=extends:→
  set listchars+=precedes:←
else
  if v:version < 603
" :print may behave badly with this disabled
"set listchars+=eol:$
  endif
  set listchars+=tab:>-
  try
    set listchars+=nbsp:+
  endtry
  set listchars+=trail:.
  set listchars+=extends:>
  set listchars+=precedes:<
endif

" Viminfo {{{2
set history=50                  " Keep 50 lines of command line history
set viminfo=
set viminfo+='100               " Remember 100 previously edited files' marks
set viminfo+=!                  " Remember some global variables
set viminfo+=h                  " Don't restore the hlsearch highlighting

" Functions {{{1
if exists(':function') == 2

  function! SimpleFoldText() " {{{2
    return getline(v:foldstart) . ' '
  endfunction

  function! MyFoldText() " {{{2
    let suba = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=\|}}}\d\=', '', 'g')
    let suba = substitute(suba, '\s*$', '')
    let subb = substitute(getline(v:foldend), '/\*\|\*/\|{{{\d\=\|}}}\d\=', '', 'g')
    let subb = substitute(subb, '^\s*', '', '')
    let subb = substitute(subb, '\s*$', '', '')
    let lines = v:foldend - v:foldstart + 1
    let text = suba . ' ... ' . subb
    let text = text[0:min([strlen(text), &columns - &fdc - 15 - strlen(nr2char(lines))])]
    return text . ' (' . lines . ' lines) '
  endfunction

  function! MyFoldIndent() " {{{2
    let line = getline(v:lnum)
    if line =~# '^$'
      return 0
    endif
    let numl = LeadingSpace(line)
    if line =~# &formatlistpat && &formatoptions =~# 'n'
      return '>' . ((numl  / &shiftwidth) + 1)
    endif
    if (numl % &shiftwidth) > 0 || numl == 0
      return '='
    endif
    return numl / &shiftwidth
  endfunction

  function! LeadingSpace(line)
    let line = substitute(a:line, '^\(\s*\)\S.*$', '\1', '')
    let line = substitute(line, '\t', repeat(' ', &tabstop), 'g')
    return strlen(line)
  endfunction

  function! StatusLineTrailingSpaceWarning() " {{{2
    " return '[\s$]' if trailing whitespace is detected
    " return '' otherwise
    if !exists('b:statusline_trailing_space_warning')
      if !&readonly && search('\s\+$', 'nw') != 0
        let b:statusline_trailing_space_warning = '[\s$]'
      else
        let b:statusline_trailing_space_warning = ''
      endif
    endif
    return b:statusline_trailing_space_warning
  endfunction

  function! StatusLineTabWarning() " {{{2
    " return '[&et]' if &et is set wrong
    " return '[mixed-indenting]' if spaces and tabs are used to indent
    " return an empty string if everything is fine
    if !exists('b:statusline_tab_warning')
      if &filetype == 'help'
        let b:statusline_tab_warning = ''
      else
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0
        if tabs && spaces
          let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
          let b:statusline_tab_warning = '[&et]'
        else
          let b:statusline_tab_warning = ''
        endif
      endif
    endif
    return b:statusline_tab_warning
  endfunction

  function! StatusLineEncodingBombWarning() " {{{2
    if &fenc !~ '^$\|utf-8' || &bomb
      return '[' . &fenc . (&bomb ? '-bom' : '') . ']'
    else
      return ''
    endif
  endfunction

  if exists('*synstack') " {{{2
    function! ShowSynStack()
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunction
  endif

  function! ShowSynIDs() " {{{2
    let hi = synIDattr(synID(line('.'),col('.'),1),'name')
    let trans = synIDattr(synID(line('.'),col('.'),0),'name')
    let lo = synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')
    echo 'hi<' . hi . '> trans<' . trans . '> lo<' . lo . '>'
  endfunction

  function! VisualNavigation() " {{{2
    if !exists('g:my_visual_navigation_maps')
      let g:my_visual_navigation_maps=1
      echomsg 'Enabled visual navigation'
      setlocal wrap
      silent! noremap <buffer> <unique> _ g_
      silent! noremap <buffer> <unique> 0 g0
      silent! noremap <buffer> <unique> <Home> g<Home>
      silent! noremap <buffer> <unique> ^ g^
      silent! noremap <buffer> <unique> $ g$
      silent! noremap <buffer> <unique> <End> g<End>
      silent! noremap <buffer> <unique> k gk
      silent! noremap <buffer> <unique> <Down> g<Down>
      silent! noremap <buffer> <unique> j gj
      silent! noremap <buffer> <unique> <Up> g<Up>
    else
      unlet g:my_visual_navigation_maps
      echomsg 'Disabled visual navigation'
      setlocal wrap<
      silent! unmap <buffer> _
      silent! unmap <buffer> 0
      silent! unmap <buffer> <Home>
      silent! unmap <buffer> ^
      silent! unmap <buffer> $
      silent! unmap <buffer> <End>
      silent! unmap <buffer> k
      silent! unmap <buffer> <Down>
      silent! unmap <buffer> j
      silent! unmap <buffer> <Up>
    endif
  endfunction

  function! LastModified() "{{{2
    " autocmd BufWritePre * call LastModified()
    if &modified
      let save_cursor = getpos(".")
      silent! keepjumps 1,4s/ Last Modified: \zs.*/\=strftime('%c')/
      call setpos('.', save_cursor)
    endif
  endfunction

endif

" Commands {{{1
if exists(':command') == 2

  " Compare a modified file to what is saved on disk
  command! DiffOrig vert new | set bt=nofile bh=wipe |
        \ read # | 0 delete _ | diffthis | wincmd p | diffthis
  command! DiffOff only | diffoff | set fdc<

  " Replace tabs with 'shiftwidth' spaces
  if has('ex_extra')
    command! -bang -range=% ReTab silent unlet b:statusline_tab_warning | let ts=&l:ts | let &l:ts=&sw | <line1>,<line2>retab<bang> | let &l:ts=ts | unlet ts
  endif

  " Remove trailing space
  command! -range=% UnTrail silent! unlet b:statusline_trailing_space_warning | <line1>,<line2>s/\s\+$//

  " Shift the position under the cursor to column N
  if has('ex_extra')
    command! -nargs=1 Shift exec 'normal '.(<args>-col('.')).'i '
  endif

  " Save using sudo
  if executable('sudo') && executable('dd')
    command! SUwrite write !sudo dd of=%
  endif

  " D'oh
  command! -bang -nargs=? -complete=help H help<bang> <args>

endif

" Status line {{{1
set statusline=
set statusline+=%4(%n%)\ " Buffer number (4 columns, lines up with the line numbers most of the time)
set statusline+=%<%f\ " Relative filename & path (truncatable)
set statusline+=%y%m%r%w                                " Flags: filetype, modified/nomodifiable, read-only, preview
set statusline+=%1*                                     " Various warnings
set statusline+=%{StatusLineTabWarning()}               " Indentation
set statusline+=%{StatusLineTrailingSpaceWarning()}     " Trailing space
set statusline+=%{&ff=='unix'?'':'['.&ff.']'}           " &fileformat != 'unix'
set statusline+=%{StatusLineEncodingBombWarning()}      " &fileencoding, &bomb
set statusline+=%{&eol?'':'[noeol]'}                    " &noeol
set statusline+=%*                                      " End of warnings section
set statusline+=%=\ " Separate left from right
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ " Current highlight group
set statusline+=%b,0x%-8B\ " Current character in decimal and hex representation
set statusline+=%-12(%l,%c%V%)\ %P                      " Current line and column, file percentage (set 'ruler')

" Keymap {{{1
" Disable F1 for help {{{2
map <F1> <Nop>

" To start a dockbook easier
imap ,dtx <?xml version="1.0"?><CR><!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" []>
