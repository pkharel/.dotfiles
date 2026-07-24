-- Set leader keys strictly before anything else loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- File and Undo persistence
vim.opt.backupcopy = "yes"         -- Webpack and modern dev-server friendly
vim.opt.undofile = true            -- Persistent undo history across sessions
vim.opt.updatetime = 250           -- Faster UI and diagnostic update interval
vim.opt.termguicolors = true       -- Enable 24-bit RGB colors

-- Search mechanics
vim.opt.ignorecase = true          -- Case-insensitive search...
vim.opt.smartcase = true           -- ...unless capital letters are typed explicitly
vim.opt.incsearch = true           -- Show live matches while typing
vim.opt.hlsearch = false

-- Tab and Indentation Defaults (2-space standard)
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0

-- Window Splitting Behavior
vim.opt.splitright = true          -- New vertical splits open to the right
vim.opt.splitbelow = true          -- New horizontal splits open below

---- Text Wrapping & Layout Guide
--vim.opt.textwidth = 80
--vim.opt.formatoptions:append("t")
--vim.opt.formatoptions:remove("l")
--vim.opt.colorcolumn = "80"

-- Native UI Elements
vim.opt.number = true              -- Show absolute line numbers
vim.opt.relativenumber = true      -- Highly recommended: relative numbers for fast navigation
vim.opt.cursorline = true          -- Highlight current cursor line
vim.opt.signcolumn = "yes"         -- Maintain constant margin stability

-- ========================================================================== --
-- 3. PLUGIN SPECIFICATIONS & CONFIGURATION
-- ========================================================================== --

require("lazy").setup({
  -- High-performance Color Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight-storm]]
      -- Clean override for the line guide
      vim.cmd[[highlight ColorColumn ctermbg=darkgray guibg=#2a2f41]]
    end
  },

  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },

  -- Integrated File Tree Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle File Explorer" })
    end,
  },

  -- Seamless Inline Git Tracking Indicator
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },

  {
    "cappyzawa/trim.nvim",
    opts = {
      highlight = true,
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.config").setup({
        -- Keep your default parsers configured here
        ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "markdown", "python", "cpp" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      -- Automatically install and enable LSPs in Nvim 0.11+
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "pyright",
          "bashls",
        },
        automatic_enable = true, -- Automatically runs vim.lsp.enable() for installed servers
      })

      -- Attach keymaps automatically whenever ANY language server starts up
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        end,
      })

      -- Customize server settings using native `vim.lsp.config`
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  }
})
