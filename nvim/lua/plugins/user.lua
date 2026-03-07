-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- Discord 富状态插件（已禁用以提升启动速度）
  { "andweeb/presence.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {}, -- 使用默认配置
  },

  -- Claude Code 集成
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "right", -- 窗口位置（右侧）
        split_width_percentage = 0.50, -- 占据屏幕50%宽度
      },
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  -- lspkind 用于美化补全菜单
  {
    "onsails/lspkind.nvim",
    lazy = false,
  },

  -- Codeium AI 代码补全
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function() require("codeium").setup {} end,
  },

  -- 配置 nvim-cmp 以使用 Codeium
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      -- 确保 sources 表存在
      if not opts.sources then opts.sources = {} end

      -- 在现有源的前面添加 Codeium
      table.insert(opts.sources, 1, {
        name = "codeium",
        priority = 1000,
        group_index = 1,
      })

      -- 配置补全菜单格式，显示来源信息
      local has_lspkind, lspkind = pcall(require, "lspkind")
      if has_lspkind then
        opts.formatting = {
          format = lspkind.cmp_format {
            mode = "symbol_text", -- 显示图标和文本
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,

            -- 为不同的补全源设置图标
            symbol_map = {
              Codeium = "󰘦", -- Codeium 专用图标
            },

            -- 自定义格式化函数
            before = function(entry, vim_item)
              -- 设置补全源的显示名称
              local source_names = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                codeium = "[Codeium]",
              }
              vim_item.menu = source_names[entry.source.name] or ("[" .. entry.source.name .. "]")
              return vim_item
            end,
          },
        }
      else
        -- 如果 lspkind 不可用，使用简单的格式化
        opts.formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local source_names = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              codeium = "[Codeium]",
            }
            vim_item.menu = source_names[entry.source.name] or ("[" .. entry.source.name .. "]")
            return vim_item
          end,
        }
      end

      return opts
    end,
  },
}
