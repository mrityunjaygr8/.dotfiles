--[[ local status_ok, lsp = pcall(require, "lsp-zero") ]]
--[[]]
--[[ if not status_ok then ]]
--[[   return ]]
--[[ end ]]
--[[ lsp.preset({ ]]
--[[   name = "manual-setup", ]]
--[[   set_lsp_keymaps = false, ]]
--[[   manage_nvim_cmp = true, ]]
--[[   suggest_lsp_servers = false ]]
--[[ }) ]]
--[[]]
--[[ lsp.setup_servers({ "rnix", "pyright", "gopls", "rust_analyzer", "tsserver", "bashls", "terraformls", "cssls", "jsonls" }) ]]
--[[ lsp.nvim_workspace() ]]
--[[ lsp.setup() ]]
local lsp_servers = { "rnix", "pyright", "gopls", "rust_analyzer", "tsserver", "bashls", "terraformls", "cssls",
  "jsonls", "lua_ls" }
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>z", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>x", vim.diagnostic.setloclist, opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_flags = {
  debounce_text_changes = 150,
}
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")


  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lspconfig = require("lspconfig")

for _, server_name in ipairs(lsp_servers) do
  lspconfig[server_name].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }
end
