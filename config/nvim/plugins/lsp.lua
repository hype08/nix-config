local lspconfig = require("lspconfig")

require'lspconfig'.tsserver.setup{
  filetypes = { "typescript", "javascript" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
  single_file_support = true,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      }
    }
  }
}

require'lspconfig'.solargraph.setup{
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      hover = true,
      formatting = true,
      symbols = true,
      definitions = true,
      references = true,
      rename = true,
      useBundler = true  -- Set to true if using bundler
    }
  },
  filetypes = { "ruby", "rakefile", "rb" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git", ".ruby-version")
}

require'lspconfig'.bashls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.nil_ls.setup{
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
      diagnostics = {
        ignored = {},
        excludedFiles = {},
      },
      flake = {
        autoEvalInputs = true,
      },
      nix = {
        maxMemoryMB = 2048,
        flake = {
          autoArchive = true,
        },
      }
    }
  },
  autostart = true,
  -- Root directory patterns where the server will start
  root_dir = require'lspconfig'.util.root_pattern(
    "flake.nix",
    "shell.nix",
    "default.nix",
    ".git"
  ),
  filetypes = { "nix" },
}
require'lspconfig'.yamlls.setup{}
