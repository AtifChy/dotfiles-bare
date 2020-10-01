" lightline config
let g:lightline = {
  	\   'colorscheme': 'one',
  	\   'active': {
  	\     'left':[ [ 'mode', 'paste' ],
 	\              [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ]
  	\     ]
  	\   },
 	\   'separator': { 'left': "\u2b80", 'right': "\u2b82" },
  	\   'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  	\   'component_function': {
  	\     'gitbranch': 'fugitive#head',
        \     'filetype': 'MyFiletype',
        \     'fileformat': 'MyFileformat',
	\     'cocstatus' : 'coc#status',
	\     'currentfunction' : 'CocCurrentFunction'
        \ },
  	\ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  	\}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
 	\}

" devicons for lightline
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" coc#status for lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

