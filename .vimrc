scriptencoding utf-8

let g:mapleader = ' '

" ----- pluginのインストール -----
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" Let NeoBundle manage NeoBundle
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-ref'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'rhysd/vim-textobj-ruby'
NeoBundle 'tpope/vim-surround'
NeoBundle 'rking/ag.vim'
NeoBundle 'elzr/vim-json'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" ----- js関連 -----
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'

" ----- Python -----
let $PATH = "~/.pyenv/shims:".$PATH
NeoBundle "davidhalter/jedi-vim"
NeoBundleLazy "lambdalisue/vim-pyenv", {
\ "depends": ['davidhalter/jedi-vim'],
\ "autoload": {
\   "filetypes": ["python", "python3", "djangohtml"]
\ }}

call neobundle#end()

NeoBundleCheck

" ----- Clear autocmd to suppress duplicated autocmd when load .vimrc multiple times -----
augroup vimrc
  autocmd!
augroup END

let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" ----- general -----
set visualbell t_vb=

" ----- key customize -----
map gb `.zz
map <c-g> g;
autocmd vimrc InsertLeave * set nopaste

" ----- cursor move in input mode -----
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>

" ----- display -----
syntax on
set number
set ruler
set showcmd
set laststatus=2

" 一定時間の経過かWindow/Buffer切り替え時のみcursorlineを表示
" Based on http://d.hatena.ne.jp/thinca/20090530/1243615055
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter,BufEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave,BufLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" ----- indent -----
set autoindent
set cindent         " smartindentよりも優秀
set tabstop=2
set shiftwidth=2
set expandtab
filetype plugin indent on

" ----- edit -----
set showmatch
set matchtime=1
set backspace=indent,eol,start

set wildmenu
set hidden

" 編集モードでjjと連続で入力することはまず無いので移動のミス入力として扱う
inoremap jj <Esc>jj

" ----- search -----
set wrapscan
set hlsearch
set ignorecase
set smartcase
set incsearch

" 検索中の/ or ?を自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" ESCでハイライト解除
nnoremap <ESC><ESC> :noh<return><ESC>

"virtualモードの時にスターで選択位置のコードを検索するようにする"
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" ----- backup -----
set backup
set backupdir=~/.vim/backup
set backupcopy=yes
set noswapfile
set directory=~/.vim/swap

" ----- Shortcut -----
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 拡張子毎のSyntax highlightを適用
autocmd vimrc BufNewFile,BufRead *.scss set filetype=css
autocmd vimrc BufNewFile,BufRead *.coffee.js set filetype=coffee
autocmd vimrc BufNewFile,BufRead *.jst set filetype=html
autocmd vimrc BufNewFile,BufRead *.jst.ejs set filetype=html
autocmd vimrc BufNewFile,BufRead *.jst.eco set filetype=html

" ----- color scheme -----
set t_Co=256
colorscheme desert256

" ----- mouse -----
set mouse=a

" ----- 終端のスペースを明示 -----
"augroup TrailingSpaces
"  autocmd!
"
"  " Trailing spaces
"  autocmd VimEnter,ColorScheme * highlight TrailingSpaces ctermbg=red
"  autocmd Syntax,InsertLeave * syntax match TrailingSpaces containedin=ALL /\s\+$/
"  autocmd InsertEnter * syntax clear TrailingSpaces
"  autocmd FileType unite syntax clear TrailingSpaces
"augroup END



" ----- Encoding -----
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

set encoding=utf-8
set fileencoding=utf-8

" ----- 各プラグインの設定 -----

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-h> "\<C-h>".neocomplete#start_manual_complete()
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd vimrc FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd vimrc FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd vimrc FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd vimrc FileType python setlocal omnifunc=jedi#completions
autocmd vimrc FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" 補完のショートカットキーをCtrl-Spaceに変更
" http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
" inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
" \ "\<lt>C-n>" :
" \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
" \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
" \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
" imap <C-@> <C-Space>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd vimrc User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=controller()


""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力モードで開始する
call unite#custom#profile('default', 'context', { 'options_cursor_line_time': 100.0 })
call unite#custom#profile('default', 'context', { 'start_insert': 1 })

" Uniteの選択行の見た目を変更
highlight UniteCursorLine ctermfg=0 ctermbg=7 guibg=Grey
autocmd vimrc BufEnter,BufWinEnter \[unite\]* highlight! link CursorLine UniteCursorLine
autocmd vimrc BufLeave \[unite\]* highlight! link CursorLine NONE

" 分割しないでuniteのbufferを表示する
nnoremap <Leader>u  :<C-u>Unite -no-split<Space>

" 全部乗せ
nnoremap <silent> <Leader>a  :<C-u>UniteWithCurrentDir -no-split -buffer-name=files buffer file_mru bookmark file<CR>
" ファイル一覧
nnoremap <silent> <Leader>f  :<C-u>Unite -no-split -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> <Leader>j  :<C-u>Unite -no-split buffer<CR>
" 常用セット
nnoremap <silent> <Leader>u  :<C-u>Unite -no-split buffer file_mru<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Leader>m  :<C-u>Unite -no-split file_mru<CR>
" 現在のバッファのカレントディレクトリからファイル一覧
nnoremap <silent> <Leader>D  :<C-u>UniteWithBufferDir -no-split file<CR>

" Ctrl + JはESCとする
autocmd vimrc FileType unite inoremap <silent> <buffer> <C-j> <ESC>

" ESCキーで終了する
autocmd vimrc FileType unite nmap <silent> <buffer> <C-j> <Plug>(unite_exit)
autocmd vimrc FileType unite nmap <silent> <buffer> <ESC> <Plug>(unite_exit)

" Uniteに入る際はpasteモードをOFFにする
autocmd vimrc FileType unite set nopaste


""""""""""""""""""""""""""""""""""""""""""""""""""
""" tyru/caw.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rhysd/clever-f.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clever_f_smart_case = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rking/ag.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
" カーソル位置の単語をgrep検索
nnoremap <silent> + :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR><C-R><C-W><CR>
" 指定した単語をgrep検索
nnoremap <silent> <Leader>/ :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR>
" 検索結果の再呼び出し
nnoremap <silent> <Leader>r  :<C-u>UniteResume search-buffer<CR>
" Jump specified line in current buffer
nnoremap <silent> <Leader>l  :<C-u>Unite -no-split line<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--smart-case --vimgrep --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

" elzr/vim-json
let g:vim_json_syntax_conceal = 0

" davidhalter/jedi-vim
autocmd vimrc FileType python setlocal completeopt-=preview
let g:jedi#rename_command = "<leader>R"


" 未保存のバッファを着色
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=52 guibg=#5f0000
  function! s:AlertModification()
    if &modified
      let &colorcolumn = join(range(1, 256), ',')
    endif
  endfunction
  augroup AlertModification
    au!
    au WinLeave * call s:AlertModification()
    au WinEnter * set colorcolumn=
  augroup END
endif
