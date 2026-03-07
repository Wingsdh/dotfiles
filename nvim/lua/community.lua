-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity/indent/mini-indentscope" },
  { import = "astrocommunity/editing-support/zen-mode-nvim" },
  { import = "astrocommunity/markdown-and-latex/markdown-preview-nvim" },
  { import = "astrocommunity/programming-language-support/csv-vim" },
  { import = "astrocommunity/pack/python" },
  { import = "astrocommunity/syntax/vim-cool" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Next.js 前端开发支持
  { import = "astrocommunity.pack.typescript" },
  -- 注意：AstroCommunity 没有 tailwind pack，需要手动配置 Tailwind LSP
  -- { import = "astrocommunity.pack.tailwind" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },

  -- import/override with your plugins folder
}
