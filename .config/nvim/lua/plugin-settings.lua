--
-- gruvbox
--

pcall(vim.cmd.colorscheme, "gruvbox")

--
-- lightline
--

vim.g.lightline = { colorscheme = "gruvbox" }

--
-- NERDTree
--

vim.g.NERDTreeDirArrows = 0

--
-- gitgutter
--

vim.g.gitgutter_max_signs = 1000

--
-- telescope
--

local ok_telescope, telescope = pcall(require, "telescope")
if ok_telescope then
  telescope.setup({})
  pcall(telescope.load_extension, "fzf")
end

--
-- neoscroll (default keymaps)
--

local ok_neoscroll, neoscroll = pcall(require, "neoscroll")
if ok_neoscroll then
  neoscroll.setup()
end

--
-- markdown-preview
--

local ok_mdpreview, mdpreview = pcall(require, "markdown_preview")
if ok_mdpreview then
  mdpreview.setup({
    instance_mode = "takeover",
    port = 0,
    open_browser = true,
    default_theme = "dark",
    debounce_ms = 300,
  })
end

vim.keymap.set("n", "<Leader>mps", "<cmd>MarkdownPreview<CR>", { silent = true })
vim.keymap.set("n", "<Leader>mpS", "<cmd>MarkdownPreviewStop<CR>", { silent = true })

--
-- coc.nvim (official recommended baseline config, translated to Lua)
--

vim.opt.hidden = true
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"

local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.keymap.set("i", "<Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#next"](1)
  elseif check_back_space() then
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  else
    return vim.fn["coc#refresh"]()
  end
end, { expr = true, silent = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#prev"](1)
  else
    -- falls back to the old de-indent behavior when no completion menu is open
    return vim.api.nvim_replace_termcodes("<C-d>", true, true, true)
  end
end, { expr = true, silent = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#confirm"]()
  else
    return vim.api.nvim_replace_termcodes("<C-g>u<CR><C-r>=coc#on_enter()<CR>", true, true, true)
  end
end, { expr = true, silent = true })

-- GoTo code navigation
-- (remap = true is required: <Plug>(...) only works through recursive mapping)
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true, remap = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true, remap = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true, remap = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true, remap = true })

-- Show documentation
vim.keymap.set("n", "K", function()
  if vim.fn.CocAction("hasProvider", "hover") then
    vim.fn.CocActionAsync("doHover")
  else
    vim.api.nvim_feedkeys("K", "in", false)
  end
end, { silent = true })

-- Symbol renaming
vim.keymap.set("n", "<Leader>rn", "<Plug>(coc-rename)", { remap = true })

-- Format selected code
vim.keymap.set({ "n", "x" }, "<Leader>f", "<Plug>(coc-format-selected)", { remap = true })

-- Diagnostics navigation
vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true, remap = true })
vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true, remap = true })

-- Code actions
vim.keymap.set("n", "<Leader>a", "<Plug>(coc-codeaction-cursor)", { remap = true })
