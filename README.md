# nvim-compare-with-clipboard

Sometimes I see two blocks of text that I suspect to be identical or I want to see the difference. But they are too long to compare by hands.
This plugin aims to solve this problem.

`nvim-lsp-file-operations` is a Neovim plugin that allows to compare currently selected text with contents of a clipboard using [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) as a convenient way to make it available everywhere.


## Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'antosha417/nvim-compare-with-clipboard',
```

## Setup
### With null-ls
```lua
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- your other sources
    require('compare-with-clipboard.null-ls').code_actions.compare_with_clipboard()
  },
})
```
This is equivalent to:
```lua
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- your other sources
    require('compare-with-clipboard.null-ls').code_actions.compare_with_clipboard({
      -- by default splits are horizontal
      vertical_split = false,
      -- by default compares with `+` register
      register = "+",
    })
  },
})
```
### Plain
You can also setup this plugin without `null-ls`. You need to call setup function only if you want to change the defaults. Otherwise it is good to go.
```lua
require('compare-with-clipboard.null-ls').setup({
  -- by default splits are horizontal
  vertical_split = false,
})
```
And then you can compare contents of any two registers
```vim
:lua require('compare-with-clipboard').compare_registers("a", "b")
```

## Contributing
PRs are always welcome.

