--
-- Indenting
--

vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cursorline = true

--
-- Basics
--

vim.opt.number = true
vim.opt.shell = "bash"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.mouse = "a"

--
-- Templates
--

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.vue",
  command = "0r " .. vim.fn.stdpath("config") .. "/templates/skeleton.vue",
})

--
-- Other
--

vim.opt.swapfile = false
vim.opt.updatetime = 100

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.tpp",
  command = "set filetype=cpp",
})
