{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      nixd
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted  # HTML, CSS, JS
      lua-language-server
      omnisharp-roslyn
      gopls             # Go

      # Tools
      ripgrep
      fd
    ];

    plugins = with pkgs.vimPlugins; [
      dracula-nvim
      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim
      telescope-nvim
      plenary-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      nvim-autopairs
      comment-nvim
      nvim-ts-autotag
    ];

    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undofile = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 50
      vim.opt.clipboard = "unnamedplus"

      -- Theme
      vim.cmd("colorscheme dracula")

      -- Leader key
      vim.g.mapleader = " "

      -- jk to exit insert mode
      vim.keymap.set("i", "jk", "<Esc>")

      -- File tree toggle with Ctrl+n
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

      -- Telescope
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")

      -- LSP keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

      -- Lualine
      require("lualine").setup({
        options = { theme = "dracula" }
      })

      -- HTML AutoTag
      require("nvim-ts-autotag").setup()

      -- Nvim tree
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })

      -- Autopairs
      require("nvim-autopairs").setup()

      -- Comment
      require("Comment").setup()

      -- Gitsigns
      require("gitsigns").setup()

      -- LSP
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.nixd.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.omnisharp.setup({ capabilities = capabilities })

      -- Completion
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    '';
  };
}
