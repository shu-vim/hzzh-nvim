local M = require('hzzh-nvim')

local group = vim.api.nvim_create_augroup('hzzh-nvim', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = M.execute,
})

vim.api.nvim_create_user_command('HZZHEnable', function()
  M.config.highlight_enabled = true
  M.execute()
end, {})

vim.api.nvim_create_user_command('HZZHDisable', function()
  M.config.highlight_enabled = false
  M.execute()
end, {})

vim.api.nvim_create_user_command('HZZHSearch', function() M.search() end, {})

vim.api.nvim_create_user_command('HZZHAddQF', function() M.add_to_qf() end, {})

-- vim: set et ft=lua sts=2 sw=2 ts=2 :
