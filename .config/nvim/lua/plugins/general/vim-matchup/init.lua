vim.g.matchup_matchparen_offscreen = { method = 'popup'}
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_deferred_show_delay = 50
vim.g.matchup_matchparen_deferred_hide_delay = 700

require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
}

local nmap = function(key,action)
		vim.api.nvim_set_keymap('n',key,action,{noremap = false})
end

local nnmap = function(key,action)
		vim.api.nvim_set_keymap('n',key,action,{noremap = true})
end

nmap('<leader>mh' , '<plug>(matchup-hi-surround)')
nmap('<leader>mw' , ':<c-u>MatchupWhereAmI?<cr>')
