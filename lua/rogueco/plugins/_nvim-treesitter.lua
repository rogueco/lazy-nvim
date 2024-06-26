require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c_sharp',
    'bash',
    'css',
    'html',
    'javascript',
    'json',
    'lua',
    'python',
    'regex',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'yaml',
    'query',
    'sql',
    'go'
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['am'] = '@function.outer',
        ['im'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>pn'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>pp'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        -- ["]o"] = "@loop.*",
        [']o'] = { query = { '@loop.inner', '@loop.outer' } },
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        [']S'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
        -- ["]O"] = "@loop.*",
        [']O'] = { query = { '@loop.inner', '@loop.outer' } },
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
        -- ["[o"] = "@loop.*",
        ['[o'] = { query = { '@loop.inner', '@loop.outer' } },
        ['[S'] = { query = '@scope', query_group = 'locals', desc = 'Prev scope' },
        ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Prev fold' },
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
        -- ["[O"] = "@loop.*",
        ['[O'] = { query = { '@loop.inner', '@loop.outer' } },
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        [']d'] = '@conditional.outer',
      },
      goto_previous = {
        ['[d'] = '@conditional.outer',
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
