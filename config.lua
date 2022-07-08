--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

vim.opt.cmdheight = 1

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "java",
  "javascript",
  "json",
  "lua",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

lvim.plugins = {
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup { keys = 'arstdhiokmqwfpgjluyzxcvbne' }
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
      vim.cmd [[
      let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-p>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
      let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]
      ]]
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  "nvim-telescope/telescope-live-grep-args.nvim",
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  "tpope/vim-surround",
  'mg979/vim-visual-multi',
  'gcmt/wildfire.vim',
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opts2 = { noremap = true, silent = false }
keymap("n", "n", "h", opts)
keymap("x", "n", "h", opts)
keymap("o", "n", "h", opts)
keymap("n", "e", "j", opts)
keymap("x", "e", "j", opts)
keymap("o", "e", "j", opts)
keymap("n", "u", "k", opts)
keymap("x", "u", "k", opts)
keymap("o", "u", "k", opts)
keymap("n", "i", "l", opts)
keymap("x", "i", "l", opts)
keymap("o", "i", "l", opts)
keymap("n", "l", "u", opts)
keymap("x", "l", "u", opts)
keymap("o", "l", "u", opts)
keymap("n", "k", "i", opts)
keymap("x", "k", "i", opts)
keymap("o", "k", "i", opts)
keymap("n", "K", "I", opts)
keymap("x", "K", "I", opts)
keymap("n", "h", "e", opts)
keymap("x", "h", "e", opts)
keymap("o", "h", "e", opts)
keymap("n", "H", "E", opts)
keymap("x", "H", "E", opts)
keymap("o", "H", "E", opts)
keymap("n", "=", "nzz", opts)
keymap("x", "=", "nzz", opts)
keymap("n", "-", "Nzz", opts)
keymap("x", "-", "Nzz", opts)

keymap("n", "N", "^", opts)
keymap("x", "N", "^", opts)
keymap("o", "N", "^", opts)
keymap("n", "I", "$", opts)
keymap("x", "I", "$h", opts)
keymap("o", "I", "$h", opts)
keymap("n", "W", "5w", opts)
keymap("x", "W", "5w", opts)
keymap("n", "B", "5b", opts)
keymap("x", "B", "5b", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)
keymap("n", "`", "~", opts)
keymap("x", "`", "~", opts)
keymap("n", ";", ":", opts2)
keymap("x", ";", ":", opts2)
keymap("n", "<C-u>", "<C-b>", opts)
keymap("n", "<C-e>", "<C-f>", opts)
keymap("x", "<C-u>", "<C-b>", opts)
keymap("x", "<C-e>", "<C-f>", opts)
keymap("c", "<C-u>", "<Up>", opts)
keymap("c", "<C-e>", "<Down>", opts)

keymap("n", "q", ":q<cr>", opts)
keymap("n", "S", ":w<cr>", opts)
keymap("n", "ZZ", ":wa<cr>:qa<cr>", opts)
keymap("n", "Q", "q", opts)
keymap("n", "st", ":%s//g<Left><Left>", opts2)
keymap("x", "st", ":s//g<Left><Left>", opts2)
keymap("n", "sd", ":cd ", opts)
keymap("n", "sp", ":set spell!<cr>", opts)
keymap("n", "<Esc>", ":noh<cr>", opts)
keymap("n", "<A-y>", ":m .+1<cr>==", opts)
keymap("n", "<A-l>", ":m .-2<cr>==", opts)
keymap("v", "<A-y>", ":m '>+1<cr>gv-gv", opts)
keymap("v", "<A-l>", ":m '>-2<cr>gv-gv", opts)

keymap("n", "s", "<nop>", opts)
keymap("n", "sN", ":set nosplitright<cr>:vsplit<cr>", opts)
keymap("n", "sE", ":set splitbelow<cr>:split<cr>", opts)
keymap("n", "sU", ":set nosplitbelow<cr>:split<cr>", opts)
keymap("n", "sI", ":set splitright<cr>:vsplit<cr>", opts)
keymap("n", "sn", "<C-w>h", opts)
keymap("n", "se", "<C-w>j", opts)
keymap("n", "su", "<C-w>k", opts)
keymap("n", "si", "<C-w>l", opts)
keymap("n", "<Up>", ":resize +5<cr>", opts)
keymap("n", "<Down>", ":resize -5<cr>", opts)
keymap("n", "<Left>", ":vertical resize -5<cr>", opts)
keymap("n", "<Right>", ":vertical resize +5<cr>", opts)
keymap("n", "sh", "<C-w>t<C-w>k", opts)
keymap("n", "sv", "<C-w>t<C-w>H", opts)
keymap("n", "srh", "<C-w>b<C-w>k", opts)
keymap("n", "srv", "<C-w>b<C-w>H", opts)
keymap("n", "sf", "<C-w>w", opts)
keymap("n", "sc", "<C-w>o", opts)
keymap("n", "sq", "<C-w>w:q<cr>", opts)
keymap("n", "ss", ":tabe<cr>", opts)

keymap("n", "<C-l>", ":BufferLineCyclePrev<cr>", opts)
keymap("n", "<C-y>", ":BufferLineCycleNext<cr>", opts)
keymap("n", ",s", ":HopChar2<cr>", opts)
keymap("n", "t", ":HopLineStart<cr>", opts)
keymap("n", "f", ":HopChar1CurrentLine<cr>", opts)
keymap("n", ",r", ":RnvimrToggle<cr>", opts)
keymap("n", ",c", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("v", ",c", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
keymap("n", "g]", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)
keymap("n", "g[", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)

lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.term_mode["<C-x>"] = "<C-\\><C-N>"
lvim.lsp.buffer_mappings.normal_mode["K"] = ""
lvim.lsp.buffer_mappings.normal_mode["gh"] = { vim.lsp.buf.hover, "Show hover" }
local _, cmp = pcall(require, "cmp")
lvim.builtin.cmp.mapping["<C-u>"] = cmp.mapping.select_prev_item()
lvim.builtin.cmp.mapping["<C-e>"] = cmp.mapping.select_next_item()
lvim.builtin.cmp.mapping["<C-k>"] = cmp.mapping.abort()

require("nvim-lsp-installer").setup({
  ui = {
    keymaps = {
      install_server = "k",
      update_server = "l",
      update_all_servers = "L",
    },
  }
})

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-e>"] = actions.move_selection_next,
    ["<C-u>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,

    ["<C-b>"] = actions.preview_scrolling_up,
    ["<C-f>"] = actions.preview_scrolling_down,
  },
  n = {
    ["e"] = actions.move_selection_next,
    ["u"] = actions.move_selection_previous,

    ["<C-b>"] = actions.preview_scrolling_up,
    ["<C-f>"] = actions.preview_scrolling_down,
  },
}
lvim.builtin.telescope.defaults.layout_config.width = 0.99
lvim.builtin.telescope.defaults.layout_config.height = 0.99
local _, telescope = pcall(require, "telescope")
telescope.load_extension("live_grep_args")

lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = { "i", "<CR>", "o" }, action = "edit", mode = "n" },
  { key = "n", action = "close_node" },
  { key = "v", action = "vsplit" },
  { key = "C", action = "toggle_git_ignored" },
  { key = "s", action = "" },
  { key = "-", action = "" },
  { key = "N", action = "dir_up" },
  { key = "I", action = "cd" },
}
lvim.builtin.nvimtree.setup.filters.dotfiles = true

lvim.builtin.treesitter.rainbow.enable = true

vim.cmd [[
let g:VM_leader = {'default': '\', 'visual': '\', 'buffer': '\'}
let g:VM_maps = {}
let g:VM_custom_motions = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['i'] = 'k'
let g:VM_maps['I'] = 'K'
let g:VM_maps['Find Under'] = '<C-k>'
let g:VM_maps['Find Subword Under'] = '<C-k>'
let g:VM_maps["Select Cursor Down"] = 'E'
let g:VM_maps["Select Cursor Up"] = 'U'
let g:VM_maps['Find Next'] = ''
let g:VM_maps['Find Prev'] = ''
let g:VM_maps["Undo"] = 'l'
]]

lvim.builtin.which_key.mappings = {
  b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  c = { "<cmd>BufferKill<CR>", "Close Buffer" },
  C = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
  f = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
  t = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  },

  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
    G = { "<cmd>Gitsigns setloclist<cr>", "Open changed hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    P = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
    D = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    u = { "<cmd>Trouble lsp_references<cr>", "Usage" },
    ["]"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
    ["["] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
  },
  L = {
    name = "LunarVim",
    c = {
      "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
      "Edit config.lua",
    },
    f = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "Find LunarVim files",
    },
    g = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
      "Grep LunarVim files",
    },
    i = {
      "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
      "Toggle LunarVim Info",
    },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
    l = {
      name = "logs",
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "view default log",
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        "Open the default logfile",
      },
      l = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
        "view lsp log",
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        "view neovim log",
      },
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      p = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(get_cache_dir() .. '/packer.nvim.log')<cr>",
        "view packer log",
      },
      P = { "<cmd>edit $LUNARVIM_CACHE_DIR/packer.nvim.log<cr>", "Open the Packer logfile" },
    },
    n = { "<cmd>Telescope notify<cr>", "View Notifications" },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Clean" },
    C = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  s = {
    name = "Search",
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "File" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope marks<cr>", "Marks" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    t = { "<cmd>Telescope live_grep_args<cr>", "Text" },
    T = { "<cmd>TodoTelescope<cr>", "Todo" },
  },
}
