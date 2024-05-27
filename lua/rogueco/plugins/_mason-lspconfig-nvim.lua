local lsp_installer_ensure_installed = {
  -- LSP
  'gopls',
  'bashls',
  'omnisharp',
  -- "omnisharp-mono",
  'dockerls',
  'eslint',
  'jsonls',
  'pyright',
  -- "sumneko_lua",
  'lua_ls',
  --"sqls", -- https://github.com/lighttiger2505/sqls
  'lemminx',
  'yamlls',
  'azure_pipelines_ls',

  -- FRONT END SPECIFIC
  'html',
  --'vue-language-server', -- TODO: Look into how to get this working
  'emmet_ls',
  'tsserver',
  'tailwindcss',
  'cssls',

  -- DAP
  -- "netcoredbg",

  -- LINTERS
  'tflint',

  -- FORMATTERS
  -- "csharpier",
  -- "jq",
  -- "markdownlint",
  --'prettier',
}

--if vim.fn.has 'win32' == 1 then
--  table.insert(lsp_installer_ensure_installed, 'powershell_es')
--elseif vim.fn.has 'unix' == 1 then
--  table.insert(lsp_installer_ensure_installed, 'omnisharp_mono')
-- table.insert(lsp_installer_ensure_installed, "omnisharp-mono")
--end

require('mason-lspconfig').setup {
  ensure_installed = lsp_installer_ensure_installed,
  automatic_installation = true,
}
