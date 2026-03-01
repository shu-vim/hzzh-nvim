local M = {}

M.config = {
	highlight = 'SpellBad',
	trailing_zen = '」』）】＞',
	leading_zen = '、。：「『（【＜',
}

M.setup = function(args) M.config = vim.tbl_deep_extend('force', M.config, args or {}) end

M.execute = function()
	local win = vim.api.nvim_get_current_win()
	local ok, prevmatchid = pcall(vim.api.nvim_win_get_var, win, 'prevmatchid')
	if ok and prevmatchid ~= -1 then
		vim.fn.matchdelete(prevmatchid)
		vim.api.nvim_win_set_var(win, 'prevmatchid', prevmatchid)
	end

	local hOfhz = '[[:alpha:]]'
	local zOfhz = '[^\\u0-\\u7f' .. M.config.trailing_zen .. ']'
	local zOfzh = '[^\\u0-\\u7f' .. M.config.leading_zen .. ']'
	local hOfzh = '[[:alpha:]]'
	local pattern = '\\v(' .. hOfhz .. '@<=' .. zOfhz .. ')|(' .. zOfzh .. '@<=' .. hOfzh .. ')'

	vim.api.nvim_win_set_var(win, 'prevmatchid', vim.fn.matchadd(M.config.highlight, pattern, 0, -1))
end

-- \v([[:alnum:]]@<=[^\u0-\u7f])|([^\u0-\u7f、。：]@<=[[:alnum:]])
-- あああ123いいいabc。
-- 'あああ'

vim.api.nvim_create_autocmd('WinEnter', {
	callback = M.execute,
})

return M
