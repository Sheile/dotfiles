scriptencoding utf-8

let g:mapleader = " "

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
NeoBundle 'hrp/EnhancedCommentify'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-ref'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'rhysd/vim-textobj-ruby'
NeoBundle 'rking/ag.vim'

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

call neobundle#end()

NeoBundleCheck

let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" ----- key customize -----
map gb `.zz
map <c-g> g;
autocmd InsertLeave * set nopaste

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

" ----- backup -----
set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap

" ----- Shortcut -----
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

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
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

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

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
