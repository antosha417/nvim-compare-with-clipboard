local config = require('compare-with-clipboard.config')
local M = {}

M.setup = function(opts)
  config.default_opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})
end

M.compare_registers = require('compare-with-clipboard.compare-registers').compare_registers

return M
