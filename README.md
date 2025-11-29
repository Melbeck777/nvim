,# Nvim

## Strucutre of direcotry

```
│  init.lua <- Setting except keymap, load lazy.lua and kymap.lua
│  README.md
│
└─lua
    ├─config
    │      keymap.lua <- Setting the keymap
    │      lazy.lua <- Load plugins
    │      telescope.lua
    │
    └─plugins
            autolist.lua
            autopairs.lua
            bufferline.lua
            comment.lua
            committia.lua
            conform.lua
            diffview.lua
            gitsigns.lua
            img-clip.lua
            lazygit.lua
            lspconfig.lua
            lualine.lua
            markdown-preview.lua
            mason-tool-installer.lua
            nvim-cmp.lua
            nvim-colorizer.lua
            nvim-tree.lua
            nvim-treesitter.lua
            telescope.lua
            toggleterm.lua
            tokyonight.lua
```

## plugins

### Setting

- lazy.nvim

### Markdown preview

- markdown-preview.nvim

### Git

- git-blame.nvim
- gitsigns.nvim
- diffview.nvim

### Completion

- cmp-buffer
- cmp-cmdline
- cmp-nvim-lsp
- cmp-path
- cmp_luasnip
- nvim-cmp
- nvim-lspconfig
- friendly-snippets
- LuaSnip
- mason-lspconfig.nvim
- mason-tool-installer.nvim
- mason.nvim

### Formatter

- conform
  - stylua(Lua)
    ```shell
    winget install Stylua.Stylua
    ```
  - black(Python)
    ```shell
    pip install balck
    ```
  - ruff_format(Python)
    ```shell
    pip install ruff
    ```
  - gofumpt(go)
    ```shell
    go install mvdan.cc/gofumpt@latest
    ```
  - goimports
    ```shell
    go install golang.org/x/tools/cmd/goimports@latest
    ```

### Finder

- nvim-tree
  - Download font from [Nerd Fonts](https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf) .
- nvim-treesitter

### UI

- nvim-web-devicons
- plenary.nvim
- telescope
  - If you use live_grep in windows, you need to install ripgrep.
  - You can install below command in PowerShell.
  ```
   winget install BurntSushi.ripgrep.MSVC
  ```
- tokyonight.nvim
- bufferline.nvim
- lualine.nvim

### Other

- img-clip.nvim
- autolist.nvim
- Comment.nvim
- toggleterm
- nvim-colorizer.lua
- nvim-autopairs

## ToDo

- [x] Imporve the view of nvim-tree
- [x] Automatically added bullet points
- [ ] Checke the spell
- [x] Fix to retuern normalmode when through terminal mode.
- - It's solved chaneg focus command.
- [x] Add code suggest in insert mode.
- [x] Code format some files.(python, go, c++, js, java)
- [x] Set floating window transparent.
      ![transplant](assets/transplant.png)
- [x] Complete the git setting.
  - [x] Set the commit comment wirtten by vim.
  - [x] Install some plugins.
- [ ] Set the ddc.
  - [ ] get formatter of markdown
- [ ] Setting lazygit.
