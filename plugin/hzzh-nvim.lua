local M = require('hzzh-nvim')

vim.api.nvim_create_autocmd('BufEnter', {
	callback = M.execute,
})

vim.api.nvim_create_user_command('HZZHEnable', function()
	M.enabled = true
	M.execute()
end, {})

vim.api.nvim_create_user_command('HZZHDisable', function()
	M.enabled = false
	M.execute()
end, {})

vim.api.nvim_create_user_command('HZZHSearch', function() M.search() end, {})

-- vim: set et ft=lua sts=4 sw=4 ts=4 :
