local config = require('compare-with-clipboard.config')
local utils = require('compare-with-clipboard.utils')

local M = {}

local to_buffer_name = function (reg_name)
  return "[register " .. reg_name .. "]"
end

M.compare_registers = function(reg_name, other_reg_name, opts)
  opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})

  vim.cmd.tabnew()
  utils.setup_current_buffer(to_buffer_name(reg_name), utils.get_register_lines(reg_name))

  utils.open_split(opts)
  utils.setup_current_buffer(to_buffer_name(other_reg_name), utils.get_register_lines(other_reg_name))
end

return M
