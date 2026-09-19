return {
  "scrooloose/nerdtree",
  "scrooloose/syntastic",
  "itchyny/lightline.vim",
  "terryma/vim-multiple-cursors",
  { "morhetz/gruvbox", priority = 1000 },
  "tpope/vim-fugitive",
  "tpope/vim-abolish",
  "airblade/vim-gitgutter",
  "leafgarland/typescript-vim",
  { "neoclide/coc.nvim", branch = "release" },
  -- coc extensions installed straight from their repos, per coc-volar's
  -- documented non-CocInstall setup
  { "yaegassy/coc-volar", build = "npm install" },
  { "yaegassy/coc-volar-tools", build = "npm install" },
  "posva/vim-vue",
  "cakebaker/scss-syntax.vim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "karb94/neoscroll.nvim",
  -- required by markdown-preview.nvim
  "selimacerbas/live-server.nvim",
  "selimacerbas/markdown-preview.nvim",
}
