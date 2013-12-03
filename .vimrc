scriptencoding utf-8

let mapleader = " "

" ----- pluginのインストール -----
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'hrp/EnhancedCommentify'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-ref'
NeoBundle 'kana/vim-smartinput'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

" ----- js関連 -----
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

NeoBundleCheck

" ----- key customize -----
map gb `.zz
map <c-g> g;

" ----- cursor move -----

" ----- cursor move in input mode -----
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>

" ----- display -----
syntax on
set number
set ruler
set showcmd
"set laststatus=2

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

" ----- backup -----
set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap

" ----- Shortcut -----
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
nnoremap j gj
nnoremap k gk

" 拡張子毎のSyntax highlightを適用
autocmd BufNewFile,BufRead *.scss set filetype=css
autocmd BufNewFile,BufRead *.coffee.js set filetype=coffee
autocmd BufNewFile,BufRead *.jst set filetype=html
autocmd BufNewFile,BufRead *.jst.ejs set filetype=html
autocmd BufNewFile,BufRead *.jst.eco set filetype=html

" ----- color scheme -----
set t_Co=256
colorscheme desert256

" Uniteの選択行が黒背景になるので修正
hi PmenuSel ctermfg=0 ctermbg=7 guibg=Grey

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


" ----- cursor line -----
set cursorline
" カレントウィンドウにのみ下線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" ----- Encoding -----
" via: http://www.kawaz.jp/pukiwiki/?vim#cb691f26
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" ----- 各プラグインの設定 -----

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-start neocomplcache without :NeoCompleCacheEnable
let g:neocomplcache_enable_at_startup = 1

" 補完のショートカットキーをCtrl-Spaceに変更
" http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


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
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=controller()


""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert = 1

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
nnoremap <silent> <Leader>d  :<C-u>UniteWithBufferDir -no-split file<CR>

" Ctrl + JはESCとする
au FileType unite inoremap <silent> <buffer> <C-j> <ESC>

" ESCキーで終了する
au FileType unite nmap <silent> <buffer> <C-j> <Plug>(unite_exit)
au FileType unite nmap <silent> <buffer> <ESC> <Plug>(unite_exit)

" Uniteに入る際はpasteモードをOFFにする
au FileType unite set nopaste


""""""""""""""""""""""""""""""""""""""""""""""""""
""" hrp/EnhancedCommentify
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EnhCommentifyBindInInsert = "no"

""""""""""""""""""""""""""""""""""""""""""""""""""
""" jscomplete-vim.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType javascript :setl omnifunc=jscomplete#CompleteJS
let g:jscomplete_use = ['dom', 'moz']
