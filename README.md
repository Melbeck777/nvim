# Nvim

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

### Markdown
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
- cmp\_luasnip
- nvim-cmp
- nvim-lspconfig
- conform.nvim
- friendly-snippets
- LuaSnip
- mason-lspconfig.nvim
- mason-tool-installer.nvim
- mason.nvim

### Finder
- nvim-tree
    - Download font from below.
    - https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf
- nvim-treesitter

### UI
- nvim-web-devicons
- plenary.nvim
- telescope
    - If you use live\_grep in windows, you need to install ripgrep.
    - You can install below command in PowerShell.
    ```
     winget install BurntSushi.ripgrep.MSVC
    ```
- tokyonight.nvim
- bufferline.nvim
    - You need to install `Hack Nerd Font` from ![Nerd Fonts](https://www.nerdfonts.com/)
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
-    - It's solved chaneg focus command.
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
