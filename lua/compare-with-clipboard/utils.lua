local M = {}

M.setup_current_buffer = function(name, lines)
  vim.cmd.edit(name)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.buftype = 'nofile'
  vim.bo.buflisted = false
  vim.cmd.diffthis()
end

M.get_lsp_range_lines = function(bufnr, lsp_range)
  if lsp_range == nil or bufnr == nil then
    return {}
  end
  return vim.api.nvim_buf_get_text(bufnr,
          lsp_range.start.line, lsp_range.start.character,
          lsp_range['end'].line, lsp_range['end'].character,
          {}
      )
end

M.get_register_lines = function(reg_name)
  local lines = {}
  for line in vim.fn.getreg(reg_name):gmatch("[^\n]+") do
    table.insert(lines, line)
  end
  return lines
end

M.open_split = function(opts)
  if opts.vertical_split then
    vim.cmd.vnew()
  else
    vim.cmd.new()
  end
end

return M
