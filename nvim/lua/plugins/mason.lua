-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        -- Next.js 前端开发 LSP 服务器
        -- 注意：TypeScript LSP 已由 astrocommunity.pack.typescript 提供（使用 vtsls）
        -- "ts_ls",        -- 已移除，避免与 vtsls 冲突
        "eslint",          -- ESLint LSP
        "tailwindcss",     -- Tailwind CSS LSP
        "html",            -- HTML LSP
        "cssls",           -- CSS LSP
        "jsonls",          -- JSON LSP
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "stylua",
        "black",
        -- Next.js 前端开发工具
        "prettierd",       -- Prettier 格式化工具
        "eslint_d",        -- ESLint 诊断工具
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
