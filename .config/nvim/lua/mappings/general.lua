
local nnmap = function(key,action)
		vim.api.nvim_set_keymap('n',key,action,{noremap = true})
end

local bnnmap = function(key,action)
		vim.api.nvim_buf_set_keymap(0,'n',key,action,{noremap = true})
end

local snnmap = function(key,action)
		vim.api.nvim_set_keymap('n',key,action,{noremap = true, silent = true})
end

local nnmap = function(key,action)
		vim.api.nvim_set_keymap('n',key,action,{noremap = true})
end

local inmap = function(key,action)
		vim.api.nvim_set_keymap('i',key,action,{noremap = true})
end

local vnmap = function(key,action)
		vim.api.nvim_set_keymap('v',key,action,{noremap = true})
end

local xnmap = function(key,action)
		vim.api.nvim_set_keymap('x',key,action,{noremap = true})
end

vim.api.nvim_set_keymap('n','<leader>kl', ':s/chakkachakkachakka/chakka/e<CR>',{noremap = true, silent = true})

-----------------------------------------------------------------------------//
-- Add Empty space above and below
-----------------------------------------------------------------------------//
nnmap('[<space>', [[<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[]])
nnmap(']<space>', [[<cmd>put =repeat(nr2char(10), v:count1)<cr>]])

-----------------------------------------------------------------------------//
-- Paste in visual mode multiple times
-- Paste in visual mode multiple times
xnmap('p', 'pgvy')
-- search visual selection
vnmap('//', [[y/<C-R>"<CR>]])

-----------------------------------------------------------------------------//
-- Capitalize
-----------------------------------------------------------------------------//
nnmap('<leader>U', 'gUiw`]')
inmap('<C-u>', '<cmd>norm!gUiw`]a<CR>')

-----------------------------------------------------------------------------//
-- open a new file in the same directory
-----------------------------------------------------------------------------//
nnmap('<leader>nf', [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })

-- local savefunc = function()
--   -- NOTE: this uses write specifically because we need to trigger a filesystem event
--   -- even if the file isn't change so that things like hot reload work
--   vim.cmd[[ 'silent! write' ]]
--   vim.notify('Saved ' .. vim.fn.expand '%:t', nil, { timeout = 1000 })
-- end

-----------------------------------------------------------------------------//
-- Save
-----------------------------------------------------------------------------//
-- nnmap('<c-s>', [[<cmd>lua require"mappings/extra".savefunc()<cr>]])

------------------------------------------------------------------------------
-- Quickfix
------------------------------------------------------------------------------
nnmap(']q', '<cmd>cnext<CR>zz')
nnmap('[q', '<cmd>cprev<CR>zz')
nnmap(']l', '<cmd>lnext<cr>zz')
nnmap('[l', '<cmd>lprev<cr>zz')

-----------------------------------------------------------------------------//
-- Close buffer
-----------------------------------------------------------------------------//
nnmap('<Leader>bq' , ':bn<bar>bd#<CR>')
-- Close all buffer except current
nnmap('<Leader>bQ' , ':%bd<bar>e#<bar>bd#<cr>')

-----------------------------------------------------------------------------//
-- Diable higlight
-----------------------------------------------------------------------------//
bnnmap('<localleader>hl' , ':set hlsearch!<CR>')

-----------------------------------------------------------------------------//
-- Toggle line wrap
-----------------------------------------------------------------------------//
nnmap('<localleader>wr' , ':setlocal wrap!<cr>')

-----------------------------------------------------------------------------//
-- Remap for dealing with word wrap
-----------------------------------------------------------------------------//
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap=true, expr = true, silent = true})

-----------------------------------------------------------------------------//
-- Use alt + hjkl to resize windows
-----------------------------------------------------------------------------//
nnmap('<M-UP>' , ':resize -2<CR>')
nnmap('<M-DOWN>' , ':resize +2<CR>')
nnmap('<M-LEFT>' , ':vertical resize -2<CR>')
nnmap('<M-RIGHT>' , ':vertical resize +2<CR>')

-----------------------------------------------------------------------------//
-- Easy CAPS toggle
-----------------------------------------------------------------------------//
nnmap('<Leader><c-u>' , 'viw~<Esc>')

-----------------------------------------------------------------------------//
-- Search and replace
-----------------------------------------------------------------------------//
nnmap('<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>')
vnmap('<Leader>vsr' , [[:s/\%V<C-r>"\%V//gc<Left><Left><Left>]])
-- vnmap('<Leader>vsr' , [[:s/<C-r>"//gc<Left><Left><Left>]])
-- nnmap('<Leader><leader>sr' , [[:%s/\%V<C-r>"//gc<Left><Left><Left>]])
vnmap('<Leader>ss' , [[y/<C-R>"<CR>]])
vnmap('<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>')
-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

-----------------------------------------------------------------------------//
-- TAB/SHIFT-TAB in general mode will move to next/prev buffer
-----------------------------------------------------------------------------//
nnmap('<TAB>' , ':bnext<CR>')
nnmap('<S-TAB>' , ':bprevious<CR>')

-----------------------------------------------------------------------------//
-- Alternate way to save and quit
-----------------------------------------------------------------------------//
nnmap('<C-s>' , '<cmd>w<CR>')
nnmap('<c-q>' , ':q<CR>')

-----------------------------------------------------------------------------//
-- Use control-c instead of escape
-----------------------------------------------------------------------------//
nnmap('<C-c>' , '<Esc>')
inmap('<C-C>' , '<ESC>')

-----------------------------------------------------------------------------//
-- Better tabbing
-----------------------------------------------------------------------------//
vnmap('<' , '<gv')
vnmap('>' , '>gv')

-----------------------------------------------------------------------------//
-- Move selected line / block of text in visual mode
-----------------------------------------------------------------------------//
vim.api.nvim_set_keymap('n', '<S-Down>', ':m .+1<CR>==', { noremap = true})
vim.api.nvim_set_keymap('n', '<S-Up>', ':m .-2<CR>==', { noremap = true})
vim.api.nvim_set_keymap('i', '<S-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('i', '<S-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('v', '<S-Down>', ':m \'>+1<CR>gv=gv', { noremap = true})
vim.api.nvim_set_keymap('v', '<S-Up>', ':m \'<-2<CR>gv=gv', { noremap = true})

-----------------------------------------------------------------------------//
-- Better window navigation
-----------------------------------------------------------------------------//
nnmap('<C-h>' , '<C-w>h')
nnmap('<C-j>' , '<C-w>j')
nnmap('<C-k>' , '<C-w>k')
nnmap('<C-l>' , '<C-w>l')

nnmap('<C-Left>' , '<C-w>h')
nnmap('<C-Down>' , '<C-w>j')
nnmap('<C-Up>' , '<C-w>k')
nnmap('<C-Right>' , '<C-w>l')
