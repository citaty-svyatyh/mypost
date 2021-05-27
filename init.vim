call plug#begin('~/.local/share/nvim/plugged')
"-------------------------------------------------------------------------------
" ПЛАГИНЫ
"-------------------------------------------------------------------------------
" --- Python ---
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'mitsuhiko/vim-jinja'
Plug 'fisadev/vim-isort', {'do': 'pip install isort'} " pip install isort Может сортировать импорты в шапке.
" --- Perl ---
Plug 'WolfgangMehner/perl-support'
" --- JavaScript ---
Plug 'pangloss/vim-javascript'
" --- JSON ---
Plug 'elzr/vim-json'
" --- Bash ---
Plug 'WolfgangMehner/bash-support'    " \rr - для запуска скрипта
" --- HTML ---
Plug 'othree/html5.vim'               " Поддержка microdata и прочей лабуды в html
Plug 'idanarye/breeze.vim'            " Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
Plug 'alvan/vim-closetag'             " Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>. Нажми >!
" --- CSS ---
Plug 'JulesWang/css.vim'              " CSS syntax file
Plug 'groenewege/vim-less'            " Vim syntax for LESS (dynamic CSS)
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
" --- Оформление ---
Plug 'vim-airline/vim-airline'        " Крутая строка состояния внизу экрана
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'        " Может менять цветовую схему. Список схем: https://github.com/flazz/vim-colorschemes/tree/prep
Plug 'joshdick/onedark.vim'          " Тема для вима
Plug 'challenger-deep-theme/vim'      " Тема вима
"Plug 'Yggdroot/indentLine'            " Точки для табов
" --- Автоформатирование кода для всех языков ---
Plug 'Chiel92/vim-autoformat'         " Форматирует все, но надо ставить модули, например для perl надо поставить perltidy.
" --- Автодополнялки ---
"  Здесь список всех поддерживаемых автодополнялкой языков:
"  https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
"  Для PHP, GO, TypeScript - смотри там же
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " Асинхронная автодополнялка, работает быстро в отличии от COC
Plug 'deoplete-plugins/deoplete-jedi'                             " Подплагин для автодополнения python
Plug 'carlitux/deoplete-ternjs'                                   " Подплагин для автодополнения javascript
Plug 'ternjs/tern_for_vim', {'do': 'cd ~/.local/share/nvim/plugged/tern_for_vim && npm install'}
" --- Навигация ---
Plug 'majutsushi/tagbar'              " Показывает дерево классов и функций, можно очень быстро перемещаться кнопка F8
Plug 'scrooloose/nerdtree'            " Дерево файлов. Для открытия файла в режиме таблицы юзай t, а для сплита s
Plug 'mileszs/ack.vim'                " Удобный grep по файлам
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" --- Разное ---
Plug 'cohama/lexima.vim'              " Закрывает автоматом скобки
Plug 'scrooloose/nerdcommenter'       " Комментирует блок \cc, снимает комменты с блока \cu
Plug 'tpope/vim-surround'             " Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
Plug 'powerman/vim-plugin-ruscmd'     " Русская раскладка в командом режиме
Plug 'chr4/nginx.vim'                 " nginx подсветка
Plug 'sheerun/vim-polyglot'           " Подсветка синтаксиса для тьмы языко, в т.ч. и конфиги nginx
Plug 'w0rp/ale'                       " Нужен, чтобы заработал eslint, как в атоме
Plug 'tpope/vim-unimpaired'           " ]p - вставить из буфера на строку выше, [p - ниже
Plug 'google/vim-searchindex'         " Считает кол-во совпадений при поиске
Plug 'tpope/vim-repeat'               " Может повторять через . vimsurround
Plug 'terryma/vim-multiple-cursors'   " Может изменять имя переменной одновременно в нескольких местах ctrl-n на имени и с
Plug 'mhinz/vim-startify'             " Стартовая страница, если просто набрать vim в консоле
Plug 'skanehira/translate.vim'        " Переводчик
Plug 'mattn/emmet-vim'                " Обрамляет строку в теги по ctrl- y
call plug#end()

"-------------------------------------------------------------------------------
" GLOBAL
"-------------------------------------------------------------------------------
syntax on
set autoindent
filetype on
filetype plugin on
filetype plugin indent on
" Цветовая тема и палитра 256 или 24бит цветов
if ($MYCOLOR=='24bit')
        set termguicolors
endif
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
        if (has("nvim"))
                "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
                let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        endif
        "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
        "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
        " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
        if (has("termguicolors"))
                set termguicolors
        endif
endif
colorscheme challenger_deep
"colorscheme onedark

" Нужно сделать, иначе Secrurecrt себя странно ведет. Вставляет везде символ q
set guicursor=
" Орфография для английского и русского языка
set spelllang=en,ru
" Два пробела при табуляции в качестве отступа для js/html/xml файлов, для
" остальных 4
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Мышка работает в VIM. Но, чтобы скопировать на уровне SecureCRT, надо зажать
" shift, перед выделением. И с зажатым shift вставлять.
set mouse=a

" Как vim сплитит экран
set splitright
set splitbelow

" Даже, если ща русская раскладка, все равно можно вводить любые команды типа
" Ctrl + r и т.д.
set keymap=russian-jcukenwin
set iminsert=0  " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0  " Чтобы при старте поиск был на английском, а не русском (start > /)
" Включаем номерацию строк
set number
" Вкл. относительную нумерацию строк, напр. 10j или 5k
set relativenumber
" Курсор всегда в центре экрана
set so=999
" Подсветка строки, на которой находится курсор
set cursorline
set nostartofline
hi CursorLine cterm=underline

" Возможность отката назад в файле
set undofile

"-------------------------------------------------------------------------------
" LET'S
"-------------------------------------------------------------------------------

" python-mode
let g:pymode_python = 'python3'                           " По умолчанию python-mode использует проверку синтаксиса python 2. Чтобы включить python 3
let g:python3_host_prog='/usr/bin/python3'
let g:pymode_lint_ignore=["E722", "C901"]                 " Игнорировать определенные линты
" Тема для айрлайна и все остальное настройка tabline
let g:airline_theme='papercolor'
"let g:airline_theme='onedark'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 1      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 1     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
" fzf
let g:fzf_buffers_jump = 1
"let g:fzf_action = {  'enter': 'tab drop',  'ctrl-t': 'tab drop'}
" Включаем автодополнялку при старте
let g:deoplete#enable_at_startup = 1
" Чтобы работало по <F8> навигация по перловому файлу
let g:tagbar_type_perl = {
                        \ 'ctagstype' : 'perl',
                        \ 'kinds'     : [
                        \ 'p:package:0:0',
                        \ 'w:roles:0:0',
                        \ 'e:extends:0:0',
                        \ 'u:uses:0:0',
                        \ 'r:requires:0:0',
                        \ 'o:ours:0:0',
                        \ 'a:properties:0:0',
                        \ 'b:aliases:0:0',
                        \ 'h:helpers:0:0',
                        \ 's:subroutines:0:0',
                        \ 'd:POD:1:0'
                        \ ]
                        \ }
" Компактный вид у тагбара
let g:tagbar_compact = 1
" Отк. сортировка по имени у тагбара
let g:tagbar_sort = 0

" Конфиг ale + eslint
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
" Запуск линтера, только при сохранении
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Используем ag вместо grep. Он будет игнорить папки помеченные .gitignore
if executable('ag')
        let g:ackprg = 'ag --vimgrep'
endif

" Показывать скрытые файлы и папки в NERDTree
let NERDTreeShowHidden = 1

" Направление перевода с русского на английский
let g:translate_source = "ru"
let g:translate_target = "en"
let g:translate_popup_window = 0

"-------------------------------------------------------------------------------
" AUTOCMD
"-------------------------------------------------------------------------------
" Для питоновский скрипов автоматом вызывает Дерево функций и классов
autocmd VimEnter *.py,*.pl,*.js,*.php TagbarToggle
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *.htm,*.html,*.xml,*.json,*.php,*.css,*.rss setlocal tabstop=2 shiftwidth=2 softtabstop=2
" Автоматический перенос текста для текстовых файлов
autocmd BufRead,BufNewFile *.txt  setlocal textwidth=80
" С этой строкой отлично форматирует html файл, который содержит jinja2
au BufNewFile,BufRead *.html set filetype=htmldjango
autocmd BufRead,BufNewFile *.conf let b:autoformat_autoindent=0
" Запоминает где nvim последний раз редактировал файл
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Запуск php скриптов с помощью \rr
autocmd FileType php noremap \rr :w!<CR>:!/bin/php %<CR>

"-------------------------------------------------------------------------------
" ГОРЯЧИЕ КНОПКИ
"-------------------------------------------------------------------------------
" Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянутся
imap jj <Esc>
" Отключаем стрелочки
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" Системный буфер обмена shift - Y / P
noremap <S-Y> "+y
" По F1 очищаем последний поиск с подсветкой
nnoremap <silent><F1> :noh<CR>
" shift + F1 = удалить пустые строки
nnoremap <S-F1> :g/^$/d<CR>
" Используй F2 для временной вставки из буфера, чтобы отключить авто идент
set pastetoggle=<F2>
" Перечитать .vimrc / init
noremap <F3> :source ~/.config/nvim/init.vim<CR>
" Открыть .config/nvim/init.vim через Shift + <F3>
" Может не работать, если echo $TERM  xterm-256color
noremap <S-F3> :edit ~/.config/nvim/init.vim<CR>
" Поиск слова под курсором, воскл. знак, чтобы не было автооткрытия файла
noremap <F4> :Ack! <cword> --ignore-dir={static,logs}<cr>
noremap <S-F4> :Ack! --ignore-dir={static,logs}
" Тогле включение и отклю. показа строк и обычных и релативных
nnoremap  <silent> <F5> :exec &nu==&rnu? "se nu!" : "se rnu!"<cr>
" Дерево файлов. Используй для открытия файлов t  и s  чтобы открывать в режиме таблицы или сплита
noremap <F6> :NERDTreeRefreshRoot<CR> :NERDTreeToggle<CR>
" Nginx - форматер красивый.
" https://github.com/1connect/nginx-config-formatter
nnoremap <F7> :w !nginxfmt.py %<CR>
" Показ дерева классов и функций, плагин majutsushi/tagbar
nnoremap <F8> :TagbarToggle<CR>
" Проверка орфографии <F11> для русского и английского языка
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
" CTRL-s сохранялка и автоформат
inoremap <C-s> <esc>:Autoformat<CR>:w<CR>
noremap <C-s> <esc>:Autoformat<CR>:w<CR>
" Пролистнуть на страницу вниз (как в браузерах)
nnoremap <Space> <PageDown> zz
" Пролистнуть на страницу вверх
nnoremap <C-Space> <PageUp> zz
" fzf
noremap <C-a> :Files<CR>
noremap <C-p> :Buffers<CR>
" Переводчик
vmap t <Plug>(VTranslate)

" Переключение между буферов с помощью TAB
function! BSkipQuickFix(command)
        let start_buffer = bufnr('%')
        execute a:command
        while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
                execute a:command
        endwhile
endfunction

nnoremap <Tab> :call BSkipQuickFix("bn")<CR>
nnoremap <S-Tab> :call BSkipQuickFix("bp")<CR>
