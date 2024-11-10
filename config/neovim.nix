{ pkgs, inputs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        #nodePackages.bash-language-server
        gopls
        lua-language-server
        luajitPackages.lua-lsp
        marksman
        nil
        pyright
        rust-analyzer
        wl-clipboard
        xclip
        yaml-language-server
      ];
      plugins = with pkgs.vimPlugins; [
        alpha-nvim
        auto-session
        bufferline-nvim
        cmp-buffer
        cmp-nvim-lsp
        cmp_luasnip
        comment-nvim
        dressing-nvim
        friendly-snippets
        indent-blankline-nvim
        lspkind-nvim
        lualine-nvim
        luasnip
        neodev-nvim
        nui-nvim
        nvim-autopairs
        nvim-cmp
        nvim-lspconfig
        nvim-surround
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-ts-context-commentstring
        nvim-web-devicons
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        vim-tmux-navigator
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/keymaps.lua}
        ${builtins.readFile ./nvim/plugins/alpha.lua}
        ${builtins.readFile ./nvim/plugins/auto-session.lua}
        ${builtins.readFile ./nvim/plugins/nvim-tree.lua}
        ${builtins.readFile ./nvim/plugins/telescope.lua}
        ${builtins.readFile ./nvim/plugins/todo-comments.lua}
        ${builtins.readFile ./nvim/plugins/treesitter.lua}
        require("ibl").setup()
        require("bufferline").setup{}
        require("lualine").setup({
          icons_enabled = true,
        })
      '';
    };
  };
}

