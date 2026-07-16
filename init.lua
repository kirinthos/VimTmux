vim.pack.add({
    -- File Tree Explorer
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- optional

    -- tmux navigation
    { src = "https://github.com/alexghergh/nvim-tmux-navigation" },

    -- colorschemes
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/AlexvZyl/nordic.nvim" },

    -- fuzzy finding!
    { src = "https://github.com/nvim-lua/plenary.nvim" }, -- dep to telescope
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

    -- full workspace diagnostics instead of open buffers
    { src = "https://github.com/artemave/workspace-diagnostics.nvim" },

    -- preview window and dependencies
    { src = "https://github.com/ibhagwan/fzf-lua" }, -- lua implementation of fzf

    -- default LSP configurations
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- formatting plugin
    { src = "https://github.com/stevearc/conform.nvim" },
})

-- remap the leader!
vim.g.mapleader = " "

-- Open config files
vim.keymap.set("n", "<leader>hc", ":edit ~/.config/nvim/init.lua<CR>", { desc = "Edit init.lua configuration" })
-- Reload hotkey
vim.keymap.set("n", "<leader>hr", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })

-- compile fzf-native because vim.pack doesn't really have hooks
vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "telescope-fzf-native.nvim",
    desc = "Rebuild telescope's fzf plugin on changes",
    callback = function(e)
        local kind = e.data.kind
        if kind == "install" or kind == "update" then
            -- Check if the directory exists and run make
            local fzf_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
            print("Installing and configuring your plugin..." .. fzf_dir)

            if vim.fn.isdirectory(fzf_dir) == 1 then
                vim.fn.jobstart({ "make" }, { cwd = fzf_dir })
            end
        end
    end,
})

-- support truecolors
vim.o.termguicolors = true
vim.cmd.colorscheme("kanagawa")

-- jk as escape
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.g.maplocalleader = " "

-- line numbers
vim.opt.number = true

-- tabs and such
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.expandtab = true -- Use spaces instead of tabs

-- reload config
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("source $MYVIMRC")
    print("Neovim config reloaded")
end, { desc = "Reload Neovim config" })

-- File Explorer Toggle
require("nvim-tree").setup()
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- neovim tmux navigation
local nvim_tmux_nav = require("nvim-tmux-navigation")
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)

-- LSP Configuration and controls
-- workspace diagnostic configuration
vim.lsp.config("*", {
    on_attach = function(client, bufnr)
        -- some clients support workspace diagnostics natively
        if client:supports_method("workspace/diagnostic", bufnr) then
            vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
        else
            require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" }, -- Use clippy to find full workspace issues
        },
    },
})

vim.lsp.config("pyright", {
    root_markers = {
        ".git",
        "pyrightconfig.json",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
    },
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                -- Optional: Controls level of strictness ("off", "basic", or "strict")
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- and enable them
vim.lsp.enable({
    "pyright",
    "ts_ls",
    "lua_ls",
    "rust_analyzer",
})

-- Code Formatting
require("conform").setup({
    -- Map file types to their respective formatters
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
    },

    -- Set up the format-on-save trigger
    format_on_save = {
        -- These options are passed to conform.format()
        timeout_ms = 1000,
        lsp_format = "fallback", -- Use LSP formatting if no conform tool is available
    },
})

-- telescope configuration
require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {
                preview_width = 0.5, -- Gives 50% screen width to the code preview
                width = 0.9, -- 90% of screen width
                height = 0.9, -- 90% of screen height
            },
            vertical = {
                preview_width = 0.5,
                width = 0.9,
                height = 0.9,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        diagnostics = {
            wrap_results = true, -- Wraps long error messages so they don't get truncated
            layout_strategy = "vertical",
        },
    },
})
-- fuzzy finding within telescope
require("telescope").load_extension("fzf")

local telescopebuiltin = require("telescope.builtin")
-- Files and Buffers
vim.keymap.set("n", "<leader><leader>", telescopebuiltin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>b", telescopebuiltin.buffers, { desc = "Telescope buffers" })
-- Code Functions
vim.keymap.set("n", "<leader>cl", telescopebuiltin.diagnostics, { desc = "Code LSP Diagnostics" })
vim.keymap.set("n", "<leader>cd", telescopebuiltin.lsp_definitions, { desc = "Code definitions" })
vim.keymap.set("n", "<leader>ci", telescopebuiltin.lsp_implementations, { desc = "Code implementations" })
vim.keymap.set("n", "<leader>cr", telescopebuiltin.lsp_references, { desc = "Code references" })
-- Telescope help
vim.keymap.set("n", "<leader>hh", telescopebuiltin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>hk", telescopebuiltin.keymaps, { desc = "Telescope help keymaps" })
-- Searching
vim.keymap.set("n", "<leader>sp", telescopebuiltin.live_grep, { desc = "Search with grep through the project" })
vim.keymap.set(
    "n",
    "<leader>ss",
    telescopebuiltin.lsp_workspace_symbols,
    { desc = "Search fuzzy find Workspace Symbols" }
)

-- Make a key to populate workspace diagnostics for debugging
vim.api.nvim_set_keymap("n", "<space>cx", "", {
    noremap = true,
    callback = function()
        for _, client in ipairs(vim.lsp.buf_get_clients()) do
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end
    end,
})

-- diagnostic on hover
-- reduce the hover delay (default is 4000ms/4 seconds)
vim.o.updatetime = 350
-- automatically open diagnostic popups on hover
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always", -- shows the source of the error (e.g., Pyright)
            prefix = " ",
            scope = "cursor", -- "cursor" only shows the specific error under the cursor; change to "line" for the whole line
        }
        vim.diagnostic.open_float(nil, opts)
    end,
})
