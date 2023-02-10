# nvim-compare-with-clipboard

`nvim-lsp-file-operations` is a Neovim plugin that allows to compare currently selected text with contents of a clipboard using [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) as a convenient way to make it available everywhere.

## Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'antosha417/nvim-compare-with-clipboard',
  requires = {
    { "jose-elias-alvarez/null-ls.nvim" },
  }
}
```

## Setup
```lua
require("compare-with-clipboard").setup()
```
This is equivalent to:
```lua
require("lsp-file-operations").setup {
  -- by default splits are horizontal
  vertical_split = false,
  -- by default compares with `+` register
  register = "+",
}
```

## Contributing
PRs are always welcome.

