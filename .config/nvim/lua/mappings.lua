--
-- System clipboard
--

vim.keymap.set({ "n", "v" }, "<Leader>y", '"*y')
vim.keymap.set({ "n", "v" }, "<Leader>p", '"*p')
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+y')
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+p')

--
-- Indent with Tab
-- (insert-mode <Tab>/<S-Tab> are handled in plugin-settings.lua, since coc
-- needs to intercept them when its completion menu is open)
--

vim.keymap.set("n", "<Tab>", ">>_")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

--
-- Auto-expand brackets
--

vim.keymap.set("i", "(;", "(<CR>);<C-c>O")
vim.keymap.set("i", "(,", "(<CR>),<C-c>O")
vim.keymap.set("i", "{;", "{<CR>};<C-c>O")
vim.keymap.set("i", "{,", "{<CR>},<C-c>O")
vim.keymap.set("i", "[;", "[<CR>];<C-c>O")
vim.keymap.set("i", "[,", "[<CR>],<C-c>O")

--
-- Remove all trailing whitespace by pressing F5
--

vim.keymap.set("n", "<F5>", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")

--
-- NERDTree
--

vim.keymap.set("n", "<C-g>", ":NERDTreeToggle<CR>")

--
-- Enter clears search highlighting
--

vim.keymap.set("n", "<CR>", ":noh<CR><CR>")
