local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  -- fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  -- vim.cmd 'packadd packer.nvim'
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

if packer_bootstrap then
	require('packer').sync()
end

-- local packerSyncandSource = function()
-- 	echo "updating plugins"
-- 	lua require('packer').sync()
-- 	echo "Updating complete"
-- end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost **/packer/init.lua echom "Run PackerSync" | PackerSync
		" autocmd BufWritePost **/packer/init.lua lua packerSyncandSource()
    " autocmd BufWritePost **/packer/init.lua echo "Updating plugins" | :PackerSync | source $MYVIMRC
  augroup end
]])
