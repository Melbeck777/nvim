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
    │      
    └─plugins
            autopairs.lua
            lspconfig.lua
            nvim-tree.lua
            nvim-treesitter.lua
            telescope.lua
            toggleterm.lua
            tokyonight.lua
            comment.lua
```

## plugins
- lspconfig
- nvim-tree
- nvim-treesitter
- telescope
    - If you want use 'live_grep' in windows you need to install ripgrep below command.
    ```
     winget install BurntSushi.ripgrep.MSVC
    ```
- toggleterm
- tokyonight
- autopairs
- mason
- nvim-lspconfig
- mason-lspconfig
- nvim-cmp
- cmp-nvim-lsp

## ToDo
[x] Imporve the view of nvim-tree
[x] Automatically added bullet points
[ ] Checke the spell
[x] Fix to retuern normalmode when through terminal mode.
   - It's solved chaneg focus command.
