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
- toggleterm
- tokyonight
- autopairs

## ToDo
[x] Imporve the view of nvim-tree
[x] Automatically added bullet points
[ ] Checke the spell
[ ] Fix to retuern normalmode when through terminal mode.
 - this is problem of focus.
