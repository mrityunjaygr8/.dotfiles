local status_ok, oh_lucy = pcall(require, "oh-lucy")
if not status_ok then
  return
end

-- vim.g.catppuccin_flavour = "mocha"
-- catpuccin.setup()
-- vim.cmd([[colorscheme catppuccin]])
vim.cmd([[colorscheme oh-lucy]])
