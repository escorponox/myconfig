set ignorecase

" windows
nnoremap ,z <C-W>\|
nnoremap ,h :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap ,j :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap ,k :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap ,l :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nnoremap ,= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
nnoremap ,x <C-W>x
nnoremap ,c :close<CR>

" tabs
nnoremap ,tt :<C-U>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>
nnoremap ,tp :<C-U>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>

" quit/save all
nnoremap ,q :Qall<CR>
nnoremap ,w :Wall<CR>

" comments
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" find and replace word
nnoremap ,rr :<C-U>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>

" error navigation
nnoremap <C-k> :call VSCodeNotify('editor.action.marker.prev')<CR>
nnoremap <C-j> :call VSCodeNotify('editor.action.marker.next')<CR>
