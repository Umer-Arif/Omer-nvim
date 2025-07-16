return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  -- Mason-LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",
        "clangd",
        "lua_ls",
      },
      automatic_installation = false,
    },
  },

  -- typescript-tools.nvim: THE ONLY TS/JS LSP WE WANT
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init = function()
      -- BLOCK any tsserver installation attempts
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonPackageInstalling",
        callback = function(args)
          if args.data.package == "typescript-language-server" then
            vim.notify("BLOCKED: typescript-language-server installation", vim.log.levels.WARN)
            vim.cmd("MasonUninstall typescript-language-server")
          end
        end,
      })
    end,
    opts = {
      settings = {
        separate_diagnostic_server = false,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = {
          "fix_all",
          "add_missing_imports",
          "remove_unused",
        },
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "none",
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = false,
        },
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        client.server_capabilities.signatureHelpProvider = false
      end,
    },
  },

  -- nvim-lspconfig: Core LSP setup
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Explicitly disable ts_ls to prevent any auto-loading
      lspconfig.ts_ls.setup({
        on_attach = function() end,
        autostart = false,
      })

      -- Lazy load other LSPs
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "lua", "c", "cpp", "html", "css" },
        callback = function(args)
          local ft = args.match
          local servers = {
            python = "pyright",
            lua = "lua_ls",
            c = "clangd",
            cpp = "clangd",
            html = "html",
            css = "cssls",
          }
          if servers[ft] and not lspconfig[servers[ft]].manager then
            lspconfig[servers[ft]].setup({
              handlers = {
                ["textDocument/signatureHelp"] = function() end,
              },
            })
          end
        end,
      })
    end,
  },

  -- nvim-cmp: Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
      })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- conform.nvim: Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },
}
