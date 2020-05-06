" logdelta.vim
" Author:       Chris AtLee <chris@atlee.ca>
" Version:      0.1

if exists("g:loaded_logdelta") || &cp || v:version < 700
  finish
endif
let g:loaded_logdelta = 1

function! s:LogDeltas()
python3 << EOF
import vim
import re

vim.command("call setqflist([], 'r')")

last_time = None
delta_by_lines = []
for i, line in enumerate(vim.current.buffer):
    m = re.search(r"(\d\d):(\d\d):(\d\d)", line)
    if m:
        h, m, s = [int(_) for _ in m.groups()]
        t = h * 3600 + m * 60 + s
        if not last_time:
            last_time = t
            continue

        delta = t - last_time
        delta_by_lines.append((delta, i))
        last_time = t

delta_by_lines.sort(reverse=True)
for d, linenum in delta_by_lines:
    item = f"{{'filename': bufname(), 'lnum': {linenum}, 'text': 'delta: {d}'}}"
    cmd = f"call setqflist([], 'a', {{'items': [ {item} ] }} )"
    vim.command(cmd)
    # Stop telling us of changes less than 5s
    if d < 5:
        break
EOF
copen
endfunction

nnoremap <silent> <leader>p :call <SID>LogDeltas()<CR>
