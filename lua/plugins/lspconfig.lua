-- lua/plugins/lspconfig.lua
return {
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  {
    "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
    -- 0.11+ の新APIが使えるかチェック（簡素化）
    local has_new = (vim.fn.has("nvim-0.11") == 1) and type(vim.lsp.start) == "function"
    if not has_new then
      vim.notify("Neovim 0.11+ が必要です（新LSP API）。", vim.log.levels.ERROR)
      return
    end
      -- mason
      local ok_mason, mason = pcall(require, "mason")
      if not ok_mason then return end
      mason.setup()

      -- mason-lspconfig
      local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
      if not ok_mlsp then return end
      mlsp.setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",   -- typescript-language-server（必要に応じて "ts_ls"）
          "jsonls",
          "html",
          "cssls",
          "pyright",
        },
        automatic_installation = true,
      })

      -- 旧 lspconfig の“設定定義”は参照だけに使う（root_dir などの既定取得）
      local ok_lsp, _ = pcall(require, "lspconfig")
      if not ok_lsp then return end

      -- capabilities（nvim-cmp 連携）
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- on_attach（キーマップは貼らない）
      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      -- サーバ個別設定
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {},
        jsonls = {},
        html = {},
        cssls = {},
        pyright = {},
      }


        local function start(server_name, user_cfg)
          local ok_lsp, lspconfig = pcall(require, "lspconfig")
          if not ok_lsp then return end

          -- ts_ls → tsserver など、lspconfig名とのマッピング
          local server_alias = {
            ts_ls = "tsserver",
          }
          local target_name = server_alias[server_name] or server_name

          -- lspconfig[target_name] から default_config を取得
          local defaults = {}
          if lspconfig[target_name] and lspconfig[target_name].document_config then
            defaults = lspconfig[target_name].document_config.default_config or {}
          end

          local cfg = vim.tbl_deep_extend("force", defaults, user_cfg or {})
          cfg.on_attach = cfg.on_attach or on_attach
          cfg.capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities or {})

          if not cfg.cmd then
            vim.notify(("LSP '%s' の cmd が見つかりません。Mason でインストール済みか確認してください。"):format(target_name), vim.log.levels.ERROR)
            return
          end

          vim.lsp.start(cfg)
        end

      -- 診断表示の調整
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        float = { border = "rounded" },
        severity_sort = true,
      })
    end,
  },
}
