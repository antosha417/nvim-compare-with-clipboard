local null_ls = require("null-ls")

local M = {}

local default_opts = {
  vertical_split = false,
  register = "+",
}

local set_buf_options = function(name)
  vim.cmd.edit(name)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
  vim.bo.buftype = 'nofile'
  vim.bo.buflisted = false
  vim.cmd.diffthis()
end

local get_selected_lines = function(bufnr, range)
  if range == nil or bufnr == nil then
    return {}
  end
  return vim.api.nvim_buf_get_text(bufnr,
    range.start.line, range.start.character,
    range['end'].line, range['end'].character,
    {}
  )
end

local compare_with_register = function(opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  local selected_lines = get_selected_lines(opts.bufnr, opts.lsp_params.range)

  vim.cmd.tabnew()
  set_buf_options("[clipboard]")
  vim.cmd("put " .. opts.register)

  if opts.vertical_split then
    vim.cmd.vnew()
  else
    vim.cmd.new()
  end
  set_buf_options("[selection]")
  vim.api.nvim_buf_set_lines(0, -1, -1, false, selected_lines)
end

M.setup = function(opts)
  default_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  local source = {
    name = "diff_with_register",
    method = null_ls.methods.CODE_ACTION,
    filetypes = {},
    generator = {
      fn = function(params)
        if (vim.api.nvim_get_mode().mode ~= 'v') then
          return nil
        end
        return {
          {
            title = "Compare selection with clipboard",
            action = function() compare_with_register(params) end,
          },
        }
      end,
    }
  }
  null_ls.register(source)
end

return M

