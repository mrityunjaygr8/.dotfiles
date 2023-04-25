--[[ local status_ok, rose_pine = pcall(require, "rose-pine") ]]
--[[ if not status_ok then ]]
--[[   return ]]
--[[ end ]]
--[[ rose_pine.setup({ ]]
--[[   disable_italics = true ]]
--[[ }) ]]
--[[]]
--[[ -- vim.g.catppuccin_flavour = "mocha" ]]
--[[ -- catpuccin.setup() ]]
--[[ -- vim.cmd([[colorscheme catppuccin]) ]]
--[[ vim.cmd([[colorscheme rose-pine]) ]]
vim.opt.background = "dark"
vim.cmd("colorscheme nord")
