local M = {}

M.config = {
  highlight = 'SpellBad',
  trailing_zen = '」』）】＞',
  leading_zen = '、。：「『（【＜',

  highlight_enabled = true,
}

M.setup = function(args) M.config = vim.tbl_deep_extend('force', M.config, args or {}) end

M.build_regexp = function()
  local hOfhz = '[[:alpha:]]'
  local zOfhz = '[^\\u0-\\u7f' .. M.config.trailing_zen .. ']'
  local zOfzh = '[^\\u0-\\u7f' .. M.config.leading_zen .. ']'
  local hOfzh = '[[:alpha:]]'
  local pattern = '\\v(' .. hOfhz .. '@<=' .. zOfhz .. ')|(' .. zOfzh .. '@<=' .. hOfzh .. ')'

  return pattern
end

M.search = function() vim.fn.setreg('/', M.build_regexp()) end

M.execute = function()
  local win = vim.api.nvim_get_current_win()
  local ok, prevmatchid = pcall(vim.api.nvim_win_get_var, win, 'prevmatchid')
  if ok and prevmatchid ~= -1 then
    vim.fn.matchdelete(prevmatchid)
    vim.api.nvim_win_del_var(win, 'prevmatchid')
  end

  if not M.config.highlight_enabled then return end

  vim.api.nvim_win_set_var(win, 'prevmatchid', vim.fn.matchadd(M.config.highlight, M.build_regexp(), 0, -1))
end

M.add_to_qf = function()
  local pattern = M.build_regexp()

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local qf_items = {}
  for lnum, line in ipairs(lines) do
    local col = 0
    while true do
      local res = vim.fn.matchstrpos(line, pattern, col)
      local start_idx = res[2]
      local end_idx = res[3]

      if start_idx == -1 then break end

      table.insert(qf_items, {
        bufnr = bufnr,
        lnum = lnum,
        col = start_idx + 1,
        text = line,
      })

      if end_idx == col then
        col = col + 1
      else
        col = end_idx
      end

      if col >= #line then break end
    end
  end

  if #qf_items > 0 then
    vim.fn.setqflist(qf_items, 'r')
    vim.cmd('copen')
  else
    vim.notify('No matches found for hzzh.')
  end
end

-- あああaaaいいいiii
-- 「aaa」
-- 'あああ'

return M

-- vim: set et ft=lua sts=2 sw=2 ts=2 :
