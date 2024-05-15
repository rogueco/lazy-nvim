local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazyPlugins = {

  ------------------------------------------------------------------------
  -- TODO: Organise these into categories
  ------------------------------------------------------------------------
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { 'fatih/vim-go' }, -- GO support

  ------------------------------------------------------------------------
  -- LIBRARIES
  ------------------------------------------------------------------------
  { 'nvim-lua/plenary.nvim' },
  { 'tpope/vim-repeat' },
  { 'numToStr/Comment.nvim', opts = {} },

  ------------------------------------------------------------------------
  -- THEMES, EDITOR AND UI
  ------------------------------------------------------------------------
  { 'folke/tokyonight.nvim' },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'stevearc/conform.nvim' }, -- AUTO FORMAT
  { 'lewis6991/gitsigns.nvim' }, -- GUTTER GIT SIGNS
  { 'ryanoasis/vim-devicons', priority = 100 }, -- https://github.com/ryanoasis/vim-devicons
  { 'nvim-tree/nvim-web-devicons' },
  { 'preservim/nerdtree', dependencies = { 'ryanoasis/vim-devicons' }, cmd = { 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeFind' } }, -- https://github.com/preservim/nerdtree
  --{ 'stevearc/oil.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

  ------------------------------------------------------------------------
  -- LSP PLUGINS
  ------------------------------------------------------------------------
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
  },

  ------------------------------------------------------------------------
  -- TOOLS
  ------------------------------------------------------------------------
  { 'nvim-telescope/telescope.nvim', event = 'VimEnter', branch = '0.1.x' },

  -- TODO: Split this up
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  ------------------------------------------------------------------------
  -- COMPLETION AND SNIPPETS
  ------------------------------------------------------------------------
  { 'hrsh7th/nvim-cmp' }, -- https://github.com/hrsh7th/nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' }, -- https://github.com/hrsh7th/cmp-nvim-lsp
  { 'hrsh7th/cmp-buffer' }, -- https://github.com/hrsh7th/cmp-buffer
  { 'hrsh7th/cmp-path' }, -- https://github.com/hrsh7th/cmp-path
  { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
  { 'hrsh7th/cmp-calc' }, -- https://github.com/hrsh7th/cmp-calc
  { 'hrsh7th/cmp-emoji' }, -- https://github.com/hrsh7th/cmp-emoji
  { 'L3MON4D3/LuaSnip' }, -- https://github.com/L3MON4D3/LuaSnip
  { 'saadparwaiz1/cmp_luasnip' }, -- https://github.com/saadparwaiz1/cmp_luasnip
  { 'Issafalcon/lsp-overloads.nvim' },

  ------------------------------------------------------------------------
  -- AI ASSISTANT
  ------------------------------------------------------------------------
  { 'Exafunction/codeium.vim' },

  ------------------------------------------------------------------------
  -- END
  ------------------------------------------------------------------------
}

require('lazy').setup(lazyPlugins, {
  performance = {
    rtp = {
      disabled_plugins = {
        -- "netrwPlugin"
      },
    },
  },
})
