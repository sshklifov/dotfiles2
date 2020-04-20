" vim: set sw=2 ts=2 sts=2 foldmethod=marker:
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'

Plug 'joshdick/onedark.vim'

Plug 'webdevel/tabulous'
Plug 'vim-airline/vim-airline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sshklifov/auclo'

call plug#end()

""""""""""""""""""""""""""""Everything else""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bracket completion whitelist
let g:auclo_whitelist = ['cpp', 'c']

" Indentation settings
set expandtab
set shiftwidth=4
set softtabstop=4
set cinoptions=L0,:0,l1,b1,g0,t0,(s,U1,

" Display line numbers
set number
set relativenumber
set cc=80
autocmd FileType text,tex set tw=80
" set tw=80

" Smart searching with '/'
set ignorecase
set smartcase
set hlsearch
nnoremap <silent> <Space> :nohlsearch<CR>

" Typos
command! Q q
command! W w
command! Qa qa

" Annoying quirks
set sessionoptions-=blank
set shortmess+=I
au FileType * setlocal fo-=cro
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
nnoremap <C-w>t <C-w>T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""Appearance""""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onedark
set background=dark
set termguicolors

" Tabulous
let tabulousLabelLeftStr = ' ['
let tabulousLabelRightStr = '] '
let tabulousLabelNumberStr = ':'
let tabulousLabelNameDefault = 'Empty'
let tabulousCloseStr = ''

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_symbols = {'space': ' ', 'paste': 'PASTE', 'maxlinenr': ' |',
      \ 'dirty': '⚡', 'crypt': '🔒', 'linenr': '<C-G>', 'readonly': '',
      \ 'spell': 'SPELL', 'modified': '+', 'notexists': 'Ɇ', 'keymap': 'Keymap:',
      \ 'ellipsis': '...', 'branch': '', 'whitespace': ''}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""Command completion""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildchar=9
set wildcharm=9
set wildignore=*.o,*.out
set wildignorecase
set wildmode=full
cnoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <expr> <Right> pumvisible() ? "\<Down>" : "\<Right>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""Latex"""""""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set title
autocmd FileType tex nnoremap <silent> <buffer>
      \<leader>goto :CocCommand latex.ForwardSearch<CR>
autocmd BufWinLeave *.tex silent !pkill qpdfview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""Bulgarian langmap"""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:XkbSwitchLib = "/usr/lib/libxkbswitch.so"
let s:ins_layout=''

function! s:SwitchLayout()
  let s:ins_layout=libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
  if s:ins_layout == 'us'
    let s:ins_layout=''
  endif
  call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us')
  return ''
endfunction

function! s:RestoreLayout()
  if !empty(s:ins_layout)
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', s:ins_layout)
  endif
  let s:ins_layout=''
  return ''
endfunction

autocmd InsertLeave * call <SID>SwitchLayout()
autocmd InsertEnter * call <SID>RestoreLayout()

" airline integration
let g:airline#extensions#xkblayout#enabled = 0
function! CustomXkbStatus()
  if empty(s:ins_layout)
    return ''
  else
    return '[BG]'
  endif
endfunction
call airline#parts#define_function('xkblayout', 'CustomXkbStatus')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""""IDE maps"""""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader><leader>q :CocCommand session.save nvim<CR>:qa<CR>
nnoremap <silent> <leader>so :CocCommand session.load nvim<CR>
nnoremap <silent> <leader>cd :lcd %:p:h<CR>
nnoremap <silent> <leader>t :call
      \ jobstart("xfce4-terminal --working-directory=" . getcwd())<CR>
nnoremap <silent> <leader>unix :set ff=unix<CR>
nnoremap <silent> <leader>ev :tab drop $MYVIMRC<CR>

" copy-pasting
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y
xnoremap <leader>y "+y
xnoremap <leader>Y "+Y
nnoremap <silent> <leader>p :set
      \ paste <Bar> exe 'silent! normal! "+p' <Bar> set nopaste<CR>
nnoremap <silent> <leader>P :set
      \ paste <Bar> exe 'silent! normal! "+P' <Bar> set nopaste<CR>
xnoremap <silent> <leader>p :<C-W>set
      \ paste <Bar> exe 'silent! normal! gv"+p' <Bar> set nopaste<CR>
xnoremap <silent> <leader>P :<C-W>set
      \ paste <Bar> exe 'silent! normal! gv"+P' <Bar> set nopaste<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""COC.NVIM""""""""""""""""""""""""""""""""""""{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Completion
set completeopt=menuone,noselect
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <silent> <C-space> coc#refresh()
inoremap <silent> <CR> <C-R>=<SID>confirmCompletion()<CR>

function! s:confirmCompletion()
  if complete_info()["selected"] != "-1"
    return "\<C-y>"
  else
    return "\<C-g>u\<CR>"
  endif
endfunction

" color
highlight CocErrorSign guifg=DarkRed
highlight CocWarningSign guifg=LightRed
highlight CocInfoSign guifg=LightBlue
highlight CocHintSign guifg=LightBlue

" vim-lsp-cxx-highlight
highlight default link cPreCondit Macro
highlight default link LspCxxHlGroupMemberVariable LspCxxHlSymVariable
" coc highlight action
highlight default link CocHighlightText Visual

" Navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" Navigate blocks
nnoremap [b [{
nnoremap ]b ]}
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>dig :CocList diagnostics<CR>
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)

" Lists (coc-lists_
nnoremap <silent> <leader>sym :<C-u>CocList outline<CR>
nnoremap <silent> <leader>gsym :<C-u>CocList -I symbols<CR>
nnoremap <silent> <leader>buf :<C-u>CocList --normal buffers<CR>
nnoremap <silent> <leader>ju :<C-u>CocList -A location<CR>
nnoremap <silent> <leader>mru :<C-u>CocList mru<CR>
nnoremap <leader>file :<C-u>CocList files<Space>
nnoremap <silent> <leader>cmd :<C-u>CocList cmdhistory<CR>
nnoremap <silent> <leader>mark :<C-u>CocList marks<CR>
autocmd FileType cpp nnoremap <silent> <buffer>
      \<leader>goto :<C-u>CocList -I -A lines<CR>

" Explorer (coc-explorer)
nnoremap <silent> <leader>tre :CocCommand explorer<CR>

" Add status line support, for integration with other plugin
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
autocmd FileType cpp setl formatexpr=CocAction('formatSelected')

" fix comments for json
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType json setlocal commentstring=//\ %s
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""""""CCLS"""""""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
autocmd CursorHold  * silent call CocActionAsync('highlight')

" finds all instances of the specified type
" when cursor under a variable, uses its type
nn <silent> <leader>inst :call
      \ CocLocations('ccls', '$ccls/vars')<CR>

" inide a function: list called functions
nn <silent> <leader>cale :call
      \ CocLocations('ccls', '$ccls/call', {'callee':v:true})<CR>
" inside a function: list functions that call it
nn <silent> <leader>calr :call
      \ CocLocations('ccls', '$ccls/call')<CR>

nn <silent> <leader>mvar :hide call
      \ CocLocations('ccls', '$ccls/member')<CR>
nn <silent> <leader>mfun :hide call
      \ CocLocations('ccls', '$ccls/member', {'kind':3})<CR>
nn <silent> <leader>mtyp :hide call
      \ CocLocations('ccls', '$ccls/member', {'kind':2})<CR>

" find base clases
nn <silent> <leader>base :call
      \ CocLocations('ccls','$ccls/inheritance')<CR>
" find dervied classes
nn <silent> <leader>der :call
      \ CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<CR>

" nagive among declarations
nn <silent><buffer> <C-j> :call
      \ CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nn <silent><buffer> <C-h> :call
      \ CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nn <silent><buffer> <C-l> :call
      \ CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nn <silent><buffer> <C-k> :call
      \ CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""GETTING HELP"""""""""""""""""""""""""""""""""""{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Related to the c++ standard (via browser)
function! s:WebLookup()
  let q = expand('<cword>')
  let url = 'https://en.cppreference.com/mwiki/index.php?search='.q
  call jobstart(['exo-open', url])
  return q
endfunction

nnoremap <silent> <leader>web :call <SID>WebLookup()<CR>

" Show documentation in preview window
" Works with doxygen or vim help
nnoremap <silent> <leader>doc :call <SID>show_documentation()<CR>

" Consult man pages
nnoremap <silent> <leader>man K

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'tab h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""""""""""""""""" TODO
set scrolloff=4
set noautoread
" zr, zm
" set foldmethod=indent
" set foldmethod=marker

" set binary
" set display=uhex

" TODO CocList maps
