call plug#begin('~/.local/share/nvim/plugged')

"-------------------------------------------------------------------------------
" ПЛАГИНЫ
"-------------------------------------------------------------------------------

" --- Python ---
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'mitsuhiko/vim-jinja'
" Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'fisadev/vim-isort', {'do': 'pip install isort'} " pip install isort Может сортировать импорты в шапке. Just call the :Isort command, and it will reorder the imports of the current python file. Or select a block of imports with visual mode, and press Ctrl-i to sort them.

" --- Perl ---
Plug 'WolfgangMehner/perl-support'

" --- JavaScript ---
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'           " Для проверки js синтаксиска надо поставить npm install -g jshint
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}   " Автодополнялка для js. Используй Ctrl+x и Ctrl+o

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
Plug 'itchyny/lightline.vim'          " Тема для крутой строки
Plug 'challenger-deep-theme/vim'      " Тема вима

" --- Автоформатирование кода для всех языков ---
Plug 'Chiel92/vim-autoformat'         " Форматирует все, но надо ставить модули, например для perl надо поставить perltidy. Кнопка форматирует, а потом сохраняет

" --- Автодополнялки ---
"  Старая автодополнялка, но она не умеет дополнять, например ennumerate
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " Работает для питона, чтобы заработало для js надо ставить npm и прочее

" Новая понтовая автодополнялка. Чтобы ее поставить:
" :checkhealth
" :call coc#util#install()
" :CocInstall coc-python
" Дальше он запросит какой линтер использовать для питона.
" Можно либо полностью отказаться, либо выбрать линтер, поставить
" https://github.com/palantir/python-language-server
" И настроить линтер под себя с помощью coc-settings.json  в той же папке, что и
" init.vim а, так же  в файле ~/.pylintrc
" Еще варианты настройки линтера:
" https://jdhao.github.io/2018/09/20/disable_warning_neomake_pylint/

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- Навигация ---
Plug 'majutsushi/tagbar'              " Показывает дерево классов и функций, можно очень быстро перемещаться кнопка F8
Plug 'scrooloose/nerdtree'            " Дерево файлов. Для открытия файла в режиме таблицы юзай t, а для сплита s

" --- Разное ---
Plug 'vimlab/split-term.vim'          " Запуск баша из под вима
Plug 'cohama/lexima.vim'              " Закрывает автоматом скобки
Plug 'scrooloose/nerdcommenter'       " Комментирует блок \cc, снимает комменты с блока \cu
Plug 'tpope/vim-surround'             " Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
Plug 'powerman/vim-plugin-ruscmd'     " Русская раскладка в командом режиме
Plug 'chr4/nginx.vim'                 " nginx подсветка
Plug 'sheerun/vim-polyglot'           " Подсветка синтаксиса для тьмы языко, в т.ч. и конфиги nginx

call plug#end()

"-------------------------------------------------------------------------------
" НАСТРОЙКИ
"-------------------------------------------------------------------------------
" Нужен, например, чтобы шапка рисовалась для баш и перл скриптов
syntax on
set autoindent
filetype on
filetype plugin on
filetype plugin indent on
" --- python-mode ---
let g:pymode_python = 'python3'                           " По умолчанию python-mode использует проверку синтаксиса python 2. Чтобы включить python 3
let g:python3_host_prog='/usr/bin/python3'              " Путь к вирт. окружению python
let g:pymode_lint_ignore=["E722", "C901"]                         " Игнорировать определенные линты


" Цветовая те
colorscheme challenger_deep

" Нужно сделать, иначе Secrurecrt себя странно ведет. Вставляет везде символ q
set guicursor=
" Для питоновский скрипов автоматом вызывает Дерево функций и классов
autocmd VimEnter *.py,*.pl,*.js,*.php TagbarToggle

" Орфография для английского и русского языка
set spelllang=en,ru

" Два пробела при табуляции в качестве отступа для js/html/xml файлов, для
" остальных 4
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *.htm,*.html,*.xml,*.json,*.php,*.css,*.rss setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Автоматический перенос текста для текстовых файлов
autocmd BufRead,BufNewFile *.txt  setlocal textwidth=80

" С этой строкой отлично форматирует html файл, который содержит jinja2
au BufNewFile,BufRead *.html set filetype=htmldjango


autocmd BufRead,BufNewFile *.conf let b:autoformat_autoindent=0

" Мышка работает в VIM. Но, чтобы скопировать на уровне SecureCRT, надо зажать
" shift, перед выделением. И с зажатым shift вставлять.
set mouse=a

" Включаем автодополнялку при старте
let g:deoplete#enable_at_startup = 1

" Настройка vimlab/split-term.vim - окно с башем всегда справа
" Открывает терминал с башем всегда внизу экрана. Команда :Term
set splitright
set splitbelow

" Запоминает где nvim последний раз редактировал файл
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Даже, если ща русская раскладка, все равно можно вводить любые команды типа
" Ctrl + r и т.д.
set keymap=russian-jcukenwin
set iminsert=0  " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0  " Чтобы при старте поиск был на английском, а не русском (start > /)
"set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Типа "Нажимает" на ESC при быстром нажатии jj, чтобы не тянутся
imap jj <Esc>

" Отключаем стрелочки
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


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

" Включаем номерацию строк
set number
" Вкл. относительную нумерацию строк, напр. 10j или 5k
set relativenumber

" Показывать скрытые файлы и папки в NERDTree
let NERDTreeShowHidden = 1

" Курсор всегда в центре экрана
set so=999

" Подсветка строки, на которой находится курсор
set cursorline
set nostartofline
hi CursorLine cterm=underline

"-------------------------------------------------------------------------------
" Горячие кнопки
"-------------------------------------------------------------------------------
" Используй F2 для временной вставки из буфера, чтобы отключить авто идент
set pastetoggle=<F2>
" Перечитать .vimrc / init
noremap <F3> :source ~/.config/nvim/init.vim<CR>
" Открыть .config/nvim/init.vim через Shift + <F3>
noremap <S-F3> :tabedit ~/.config/nvim/init.vim<CR>
" Запуск баша по F4
noremap <F4> :Term<CR>
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

" CTRL-Z is Undo
noremap <C-z> u
inoremap <C-z> <C-O>u

" CTRL-s сохранялка и автоформат
inoremap <C-s> <esc>:Autoformat<CR>:w<CR>
noremap <C-s> <esc>:Autoformat<CR>:w<CR>

" Пролистнуть на страницу вниз (как в браузерах)
nnoremap <Space> <PageDown> zz

" Пролистнуть на страницу вверх
nnoremap <C-Space> <PageUp> zz

" Переключаемся между таблицами с помощью <Tab>
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" Запуск php скриптов с помощью \rr
autocmd FileType php noremap \rr :w!<CR>:!/bin/php %<CR>
