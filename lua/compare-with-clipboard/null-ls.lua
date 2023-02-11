local config = require('compare-with-clipboard.config')
local utils = require('compare-with-clipboard.utils')
local M = {}

local lsp_range_code_action = function(opts)
  opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})

  vim.cmd.tabnew()
  utils.setup_current_buffer("[clipboard]", utils.get_register_lines(opts.register))

  utils.open_split(opts)
  utils.setup_current_buffer("[selection]", utils.get_lsp_range_lines(opts.bufnr, opts.lsp_params.range))
end

M.code_actions = {
    compare_with_clipboard = function(opts)
      config.default_opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})

      return {
          name = "diff_with_register",
          method = require("null-ls").methods.CODE_ACTION,
          filetypes = {},
          generator = {
              fn = function(params)
                if (vim.api.nvim_get_mode().mode ~= 'v') then
                  return nil
                end
                return {
                    {
                        title = "Compare selection with clipboard",
                        action = function() lsp_range_code_action(params) end,
                    },
                }
              end,
          }
      }
    end
}

return M
