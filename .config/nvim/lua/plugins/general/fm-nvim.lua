require('fm-nvim').setup{
	-- Border around floating window
	border   = "rounded", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

	-- Percentage (0.8 = 80%)
	height   = 0.8,
	width    = 0.8,

	-- Command used to open files
	edit_cmd = "edit", -- opts: 'tabedit'; 'split'; 'pedit'; etc...

	-- Terminal commands used w/ file manager
	cmds = {
		lf_cmd     = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
		fm_cmd     = "fm",
		nnn_cmd    = "nnn",
		fff_cmd    = "fff",
		twf_cmd    = "twf",
		xplr_cmd   = "xplr",
		vifm_cmd   = "~/.local/bin/vifmrun",
		ranger_cmd = "ranger"
	},

	-- Mappings used inside the floating window
	mappings = {
		vert_split  = "<C-v>",
		horz_split  = "<C-h>",
		tabedit     = "<C-t>",
		edit        = "<C-e>",
		ESC         = "Q"
	}
}
