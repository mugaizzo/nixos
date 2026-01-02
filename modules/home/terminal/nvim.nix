{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    terminal.nvim.enable = lib.mkEnableOption "enable nvim";
  };

  imports = [
    inputs.nixvim.homeModules.nixvim
  ];


  config = lib.mkIf config.terminal.nvim.enable {
    # home.packages = with pkgs; [
    #   alejandra
    #   statix
    #   nil
    #   vimPlugins.catppuccin-nvim
    #   # Required for treesitter
    #   gcc
    #   # Required for telescope
    #   fd
    #   # Latex support for render-markdown
    #   python312Packages.pylatexenc
    # ];
    programs.nixvim = {
      enable = true;
      opts = {
        expandtab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        ignorecase = true;
        relativenumber = true;
      };

      globals = {
        mapleader = " ";
      };
      colorschemes.catppuccin = {
        enable = true;
        #autoLoad = true;
        settings = {
          flavour = "mocha";
        };
      };

      plugins = {
        alpha = {
          enable = true;
          autoLoad = true;
          settings =
          config.lib.nixvim.mkRaw
            #lua
            ''
              (function()
                      local startify = require('alpha.themes.startify')

                      -- Replace the header with your custom one
                      startify.section. header.val = {
                  "⠀⠀  ⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢀⣠⣄⠀⠀⠀⠀⠀ ⠀⠀⠀",
                  "⠀⠀⣤⣤⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                  "⠀⠀⣿⣿⠀ ⠀⣀⣀⡀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                  "⠀⠀⢸⣿⠀ ⣾⣿⣿⣿⣾⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⡿⠏⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠁⠀⠀⠀⣰⣶⡀⠀⠀⠀⠀",
                  "⠀⠀⢸⣿⠀ ⠻⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⢰⣶⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⣠⣶⣿⣿⠀⠸⣿⣿⣷⣶⣶⣿⣿⡿⠀⠀⠀⠀⠀",
                  "⠀⠀⣠⣤⠀ ⠀⠙⢿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠻⢿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠟⠉⠀⠀⠙⠻⠿⠿⠿⠟⣋⣀⣤⣄⡀⠀⠀",
                  "⠀⠀⠈⠉⠀ ⠀⠀⠀⢻⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠻⠿⠿⠿⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⠿⠿⠃⠀⠀",
                  "    ⠀⠀⠀                  ⠀⠀⢀⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠉⠀⠀⠀⠀⠀⠀",
                  "      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                      }

                      return startify. config
                    end)()
            '';
        };

        lualine = {
          enable = true;
          autoLoad = true;
        };

        web-devicons = {
          enable = true;
          autoLoad = true;
        };

        cursorline = {
          enable = true;
          autoLoad = true;
          settings = {
            cursorword = {
              enable = true;
            };
          };
        };

        noice = {
          enable = true;
          autoLoad = true;
          settings = {
            presets = {
              bottom_search = true;
            };
          };
        };

        telescope = {
          enable = true;
          # autoLoad = true;
          extensions = {
            fzf-native.enable = true;
          };
          keymaps = {
            "<leader><leader>" = {
              action = "oldfiles";
              options = {
                desc = "old files [Telescope]";
              };
            };
            "<leader>ff" = {
              action = "find_files";
              options = {
                desc = "Find files [Telescope]";
              };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = {
                desc = "Live grep [Telescope]";
              };
            };
            "<leader>fb" = {
              action = "buffers";
              options = {
                desc = "Buffers [Telescope]";
              };
            };
            "<leader>fh" = {
              action = "help_tags";
              options = {
                desc = "Help tags [Telescope]";
              };
            };
            "<leader>ft" = {
              action = "";
              options = {
                desc = "Open [Telescope]";
              };
            };
            "<leader>fr" = {
              action = "resume";
              options = {
                desc = "Resume (previous search) [Telescope]";
              };
            };
            "<leader>fvf" = {
              action = "git_files";
              options = {
                desc = "Git files [Telescope]";
              };
            };
            "<leader>fvcw" = {
              action = "git_commits";
              options = {
                desc = "Git commits [Telescope]";
              };
            };
            "<leader>fvcb" = {
              action = "git_bcommits";
              options = {
                desc = "Git buffer commits [Telescope]";
              };
            };
            "<leader>fvb" = {
              action = "git_branches";
              options = {
                desc = "Git branches [Telescope]";
              };
            };
            "<leader>fvs" = {
              action = "git_status";
              options = {
                desc = "Git status [Telescope]";
              };
            };
            "<leader>fvx" = {
              action = "git_stash";
              options = {
                desc = "Git stash [Telescope]";
              };
            };
            "<leader>flsb" = {
              action = "lsp_document_symbols";
              options = {
                desc = "LSP Document Symbols [Telescope]";
              };
            };
            "<leader>flsw" = {
              action = "lsp_workspace_symbols";
              options = {
                desc = "LSP Workspace Symbols [Telescope]";
              };
            };
            "<leader>flr" = {
              action = "lsp_references";
              options = {
                desc = "LSP References [Telescope]";
              };
            };
            "<leader>fli" = {
              action = "lsp_implementations";
              options = {
                desc = "LSP Implementations [Telescope]";
              };
            };
            "<leader>flD" = {
              action = "lsp_definitions";
              options = {
                desc = "LSP Definitions [Telescope]";
              };
            };
            "<leader>flt" = {
              action = "lsp_type_definitions";
              options = {
                desc = "LSP Type Definitions [Telescope]";
              };
            };
            "<leader>fld" = {
              action = "diagnostics";
              options = {
                desc = "Diagnostics [Telescope]";
              };
            };
            "<leader>fs" = {
              action = "treesitter";
              options = {
                desc = "Treesitter [Telescope]";
              };
            };
          };
        };

        which-key = {
          enable = true;
          autoLoad = true;
        };

        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            highlight.enable = true;
            indent.enable = true;
          };
        };

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings.sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
        };

        vimtex = {
          enable = true;
          settings = {
            view_method = "zathura";
            syntax_enabled = 0;
            #     quickfix_ignore_filters = [
            #       "organization"
            #       "publisher"
            #       "address"
            #     ];
          };
        };

        mini-pairs.enable = true;
        mini-surround.enable = true;
        mini-move.enable = true;

        yazi = {
          enable = true;
          autoLoad = true;
          settings = {
            open_for_directories = false;
          };
        };

        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            nil_ls.enable = true;
            html.enable = true;
            eslint.enable = true;
            ts_ls.enable = true;
            cssls.enable = true;
            jsonls.enable = true;
            bashls.enable = true;
          };
          keymaps = {
            lspBuf = {
              K = "hover";
              gD = "declaration";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
              "<leader>lf" = "format";
              "<leader>la" = "code_action";
            };
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
          };
        };

        # none-ls = {
        #   enable = true;
        #   sources = {
        #     formating = {
        #       prettier.enable = true;
        #       black.enable = true;
        #     };
        #   };
        # };

        # copilot-chat = {
        #   enable = true;
        #   autoLoad = true;
        #   settgins = {
        #   #later on
        #  };
        # };
      };

      keymaps = [
        {
          action = "<cmd>w<CR>";
          key = "<leader>w";
        }
      ];
      #   globals = {
      #     # clipboard = "osc52";
      #     # t_RV = "";
      #     vimtex_view_method = "zathura";
      #     vimtex_syntax_enabled = 0;
      #     vimtex_quickfix_ignore_filters = [
      #       "organization"
      #       "publisher"
      #       "address"
      #     ];
      #   };
      #   clipboard = {
      #     enable = true;
      #     registers = "unnamedplus";
      #     providers.xclip.enable = true;
      #   };
      #
      #     # cinnamon-nvim = {
      #     #   enable = true;
      #     #   setupOpts = {
      #     #     keymaps.basic = true;
      #     #     options.mode = "cursor";
      #     #   };
      #     # };
      #
      #
      #
      #
      #
      #
      #   languages = {
      #     enableTreesitter = true;
      #     nix = {
      #       enable = true;
      #       lsp.enable = true;
      #       format.enable = true;
      #       format.package = pkgs.alejandra;
      #       extraDiagnostics = {
      #         enable = true;
      #         types = ["statix"];
      #       };
      #     };
      #
      #     clang = {
      #       enable = true;
      #       cHeader = true;
      #     };
      #   };
      #
      #   lsp.null-ls = {
      #     enable = true;
      #
      #     setupOpts.sources = [
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.stylua'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.prettier'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.shellharden'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.shfmt'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.alejandra'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.diagnostics.statix'')
      #       # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.black'')
      #       # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.isort'')
      #       # (lib.generators.lua-inline ''require("null-ls").builtins.diagnostics.mypy'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.diagnostics.ansiblelint'')
      #       (lib.generators.mkLuaInline
      #         ''require("null-ls").builtins.formatting.clang_format'')
      #       # (lib.generators.mkLuaInline
      #       #   ''require("none-ls").diagnostics.eslint'')
      #     ];
      #   };
      #   options = {
      #     expandtab = true;
      #     tabstop = 2;
      #     shiftwidth = 2;
      #     ignorecase = true;
      #     number = true;
      #     relativenumber = true;
      #   };
      #
      #   mini = {
      #     pairs.enable = true;
      #     surround.enable = true;
      #     move.enable = true;
      #     # ai.enable = true;
      #     # hipatterns.enable = true;
      #     # cursorword.enabble = true;
      #   };
      #
      #   snippets.luasnip.enable = true;
      #
      #   autocomplete.nvim-cmp = {
      #     enable = true;
      #     sourcePlugins = ["luasnip" "cmp-luasnip" "which-key-nvim" "nvim-treesitter" "mini-surround" "none-ls-nvim" "telescope"];
      #     sources = {
      #       nvim_lsp = "[LSP]";
      #       luasnip = "[LuaSnip]";
      #       buffer = "[buffer]";
      #     };
      #   };
      #
      #   git.vim-fugitive.enable = true;
      #
      #   terminal.toggleterm.lazygit = {
      #     enable = true;
      #     package = pkgs.lazygit;
      #     direction = "float";
      #     mappings.open = "<leader>gl";
      #   };
      #
      #   notify.nvim-notify = {
      #     enable = true;
      #     setupOpts.background_colour = "#000000";
      #   };
      #   utility.yazi-nvim = {
      #     enable = true;
      #     setupOpts.open_for_directories = true;
      #   };
      #
      #   additionalRuntimePaths = [
      #     # You can list more than one file here.
      #     ./nvim
      #   ];
      #
      #   startPlugins = [
      #     pkgs.vimPlugins.CopilotChat-nvim
      #     pkgs.vimPlugins.plenary-nvim
      #   ];
      #
      #   luaConfigRC.myconfig =
      #     # entryAnywhere
      #     /*
      #     lua
      #     */
      #     ''
      #       require("CopilotChat").setup {
      #            -- Your CopilotChat configuration here
      #            window = {
      #             -- layout = "float",
      #             -- border = "rounded",
      #       	  title = "🤖 AI Assistant",
      #       	  zindex = 100, -- Ensure window stays on top
      #            },
      #       headers = {
      #       	user = "👤 You: ",
      #       	assistant = "🤖 Copilot: ",
      #       	tool = "🔧 Tool: ",
      #       },
      #       separator = "━━",
      #       show_folds = false, -- Disable folding for cleaner look
      #          }
      #
      #          -- Set up keymaps for CopilotChat
      #          -- vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open CopilotChat" })
      #     '';
      #
      #   keymaps = [
      #     {
      #       key = "<leader>w";
      #       mode = ["n"];
      #       noremap = true;
      #       action = ":w<CR>";
      #       silent = true;
      #       desc = "Save file";
      #     }
      #     {
      #       key = "<C-d>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<C-d>zz";
      #       silent = true;
      #       desc = "Center after scroll downward half screen";
      #     }
      #     {
      #       key = "<C-u>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<C-u>zz";
      #       silent = true;
      #       desc = "Center after scroll upward half screen";
      #     }
      #     {
      #       key = "n";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "nzz";
      #       silent = true;
      #       desc = "Center after search forward";
      #     }
      #     {
      #       key = "N";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "Nzz";
      #       silent = true;
      #       desc = "Center after search backwards";
      #     }
      #     {
      #       key = "<A-Down>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = ":m .+1<CR>==";
      #       silent = true;
      #       desc = "Move line Down(n)";
      #     }
      #     {
      #       key = "<A-Down>";
      #       mode = ["v"];
      #       noremap = true;
      #       action = ":m '>+1<CR>gv=gv";
      #       silent = true;
      #       desc = "Move line Down(v)";
      #     }
      #     {
      #       key = "<A-Up>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = ":m .-2<CR>==";
      #       silent = true;
      #       desc = "Move line Up(n)";
      #     }
      #     {
      #       key = "<A-Up>";
      #       mode = ["v"];
      #       noremap = true;
      #       action = ":m '<-2<CR>gv=gv";
      #       silent = true;
      #       desc = "Move line Up(v)";
      #     }
      #     # {
      #     #   key = "<leader>y";
      #     #   mode = ["n"];
      #     #   noremap = true;
      #     #   action = "\"+y";
      #     #   # silent = true;
      #     #   desc = "yank";
      #     # }
      #     {
      #       key = "<leader>y";
      #       mode = ["x"];
      #       noremap = true;
      #       action = "\"+y";
      #       # silent = true;
      #       desc = "yank";
      #     }
      #     # {
      #     #   key = "<leader>y";
      #     #   mode = ["s"];
      #     #   noremap = true;
      #     #   action = "\"+y";
      #     #   # silent = true;
      #     #   desc = "yank";
      #     # }
      #     {
      #       key = "<Space>Y";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "\"+y$";
      #       # silent = true;
      #       desc = "yank";
      #     }
      #     {
      #       key = "<Space>p";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "\"+p";
      #       # silent = true;
      #       desc = "paste";
      #     }
      #     {
      #       key = "<C-h>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<C-w>h";
      #       desc = "move b/w windows";
      #     }
      #     {
      #       key = "<C-j>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<C-w>j";
      #       desc = "move b/w windows";
      #     }
      #     {
      #       key = "<C-k>";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<C-w>k";
      #       desc = "move b/w windows";
      #     }
      #     {
      #       key = "K";
      #       mode = ["n"];
      #       action = "vim.lsp.buf.hover";
      #       desc = "buffer hover vim.lsp.buf.hover";
      #     }
      #     {
      #       key = "<leader>gd";
      #       mode = ["n"];
      #       action = "vim.lsp.buf.definition";
      #       desc = "go to definition vim.lsp.buf.definition";
      #     }
      #     {
      #       key = "<leader>gr";
      #       mode = ["n"];
      #       action = "vim.lsp.buf.references";
      #       desc = "go to references vim.lsp.buf.references";
      #     }
      #     {
      #       key = "<leader>ca";
      #       mode = ["n"];
      #       action = "vim.lsp.buf.code_action";
      #       desc = "code action vim.lsp.buf.code_action";
      #     }
      #     {
      #       key = "<leader>fo";
      #       mode = ["n"];
      #       noremap = true;
      #       action = "<cmd>Telescope oldfiles<cr>";
      #       desc = "Telescope oldfiles";
      #     }
      #     {
      #       key = "<leader>cc";
      #       mode = ["n"];
      #       action = "<cmd>CopilotChatToggle<cr>";
      #       desc = "Toggle CopilotChat";
      #     }
      #     {
      #       key = "<leader>gp";
      #       mode = ["n"];
      #       action = ":Gitsigns preview_hunk<CR>";
      #       desc = "Gitsigns preview_hunk";
      #     }
      #     {
      #       key = "<leader>gt";
      #       mode = ["n"];
      #       action = ":Gitsigns toggle_current_line_blame<CR>";
      #       desc = "Gitsigns toggle blame";
      #     }
      #     # {
      #     #   key = "<leader>gl";
      #     #   mode = ["n"];
      #     #   action = "<cmd>LazyGit<cr>";
      #     #   desc = "Open Lazygit";
      #     # }
      #   ];
      # };
    };

    # programs.nvf = {
    #   enable = true;
    #   defaultEditor = true;
    #
    #   settings.vim = {
    #     dashboard.alpha = {
    #       enable = true;
    #       theme = "startify";
    #       # it is unclear how to add the head, skipping for now
    #       #       opts = { header.val = "{
    #       # [[⠀⠀⣤⣤⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    #       # [[⠀⠀⣿⣿⠀ ⠀⣀⣀⡀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    #       # [[⠀⠀⢸⣿⠀ ⣾⣿⣿⣿⣾⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⡿⠏⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠁⠀⠀⠀⣰⣶⡀⠀⠀⠀⠀]],
    #       # [[⠀⠀⢸⣿⠀ ⠻⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⢰⣶⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⣠⣶⣿⣿⠀⠸⣿⣿⣷⣶⣶⣿⣿⡿⠀⠀⠀⠀⠀]],
    #       # [[⠀⠀⣠⣤⠀ ⠀⠙⢿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠻⢿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠟⠉⠀⠀⠙⠻⠿⠿⠿⠟⣋⣀⣤⣄⡀⠀⠀]],
    #       # [[⠀⠀⠈⠉⠀ ⠀⠀⠀⢻⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠻⠿⠿⠿⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⠿⠿⠃⠀⠀]],
    #       # [[    ⠀⠀⠀                  ⠀⠀⢀⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠉⠀⠀⠀⠀⠀⠀]],
    #       # [[      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]
    #       #   }";};
    #     };
    #     globals = {
    #       clipboard = "osc52";
    #       t_RV = "";
    #       vimtex_view_method = "zathura";
    #       vimtex_syntax_enabled = 0;
    #       vimtex_quickfix_ignore_filters = [
    #         "organization"
    #         "publisher"
    #         "address"
    #       ];
    #     };
    #
    #
    #     latex.vimtex.enable = true;
    #
    #     clipboard = {
    #       enable = true;
    #       registers = "unnamedplus";
    #       providers.xclip.enable = true;
    #     };
    #
    #     theme = {
    #       enable = true;
    #       name = "catppuccin";
    #       style = "mocha";
    #     };
    #
    #     statusline = {
    #       lualine = {
    #         enable = true;
    #         theme = "dracula";
    #       };
    #     };
    #
    #     visuals = {
    #       nvim-web-devicons.enable = true;
    #       nvim-cursorline = {
    #         enable = true;
    #         setupOpts.cursorword.enable = true;
    #       };
    #       # cinnamon-nvim = {
    #       #   enable = true;
    #       #   setupOpts = {
    #       #     keymaps.basic = true;
    #       #     options.mode = "cursor";
    #       #   };
    #       # };
    #     };
    #
    #     ui = {
    #       noice.enable = true;
    #       borders.plugins.which-key.enable = true;
    #     };
    #
    #     telescope = {
    #       enable = true;
    #     };
    #
    #     treesitter = {
    #       enable = true;
    #       highlight.enable = true;
    #       fold = true;
    #       indent.enable = true;
    #     };
    #
    #     languages = {
    #       enableTreesitter = true;
    #       nix = {
    #         enable = true;
    #         format.enable = true;
    #         format.package = pkgs.alejandra;
    #         extraDiagnostics = {
    #           enable = true;
    #           types = ["statix"];
    #         };
    #       };
    #     };
    #
    #     lsp.null-ls = {
    #       enable = true;
    #
    #       setupOpts.sources = [
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.stylua'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.prettier'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.shellharden'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.shfmt'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.alejandra'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.diagnostics.statix'')
    #         # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.black'')
    #         # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.isort'')
    #         # (lib.generators.lua-inline ''require("null-ls").builtins.diagnostics.mypy'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.diagnostics.ansiblelint'')
    #         (lib.generators.mkLuaInline
    #           ''require("null-ls").builtins.formatting.clang_format'')
    #         # (lib.generators.mkLuaInline
    #         #   ''require("none-ls").diagnostics.eslint'')
    #       ];
    #     };
    #     options = {
    #       expandtab = true;
    #       tabstop = 2;
    #       shiftwidth = 2;
    #       ignorecase = true;
    #       number = true;
    #       relativenumber = true;
    #     };
    #
    #     mini = {
    #       pairs.enable = true;
    #       surround.enable = true;
    #       move.enable = true;
    #       # ai.enable = true;
    #       # hipatterns.enable = true;
    #       # cursorword.enabble = true;
    #     };
    #
    #     snippets.luasnip.enable = true;
    #
    #     autocomplete.nvim-cmp = {
    #       enable = true;
    #       sourcePlugins = ["luasnip" "cmp-luasnip" "which-key-nvim" "nvim-treesitter" "mini-surround" "none-ls-nvim" "telescope"];
    #       sources = {
    #         nvim_lsp = "[LSP]";
    #         luasnip = "[LuaSnip]";
    #         buffer = "[buffer]";
    #       };
    #     };
    #
    #     git.vim-fugitive.enable = true;
    #
    #     terminal.toggleterm.lazygit = {
    #       enable = true;
    #       package = pkgs.lazygit;
    #       direction = "float";
    #       mappings.open = "<leader>gg";
    #     };
    #
    #     notify.nvim-notify = {
    #       enable = true;
    #       setupOpts.background_colour = "#000000";
    #     };
    #     utility.yazi-nvim = {
    #       enable = true;
    #       setupOpts.open_for_directories = true;
    #     };
    #
    #     additionalRuntimePaths = [
    #       # You can list more than one file here.
    #       ./nvim
    #     ];
    #
    #     startPlugins = [
    #       pkgs.vimPlugins.CopilotChat-nvim
    #       pkgs.vimPlugins.plenary-nvim
    #     ];
    #
    #     luaConfigRC.myconfig =
    #       # entryAnywhere
    #       /*
    #       lua
    #       */
    #       ''
    #         require("CopilotChat").setup {
    #              -- Your CopilotChat configuration here
    #              window = {
    #               -- layout = "float",
    #               -- border = "rounded",
    #         	  title = "🤖 AI Assistant",
    #         	  zindex = 100, -- Ensure window stays on top
    #              },
    #         headers = {
    #         	user = "👤 You: ",
    #         	assistant = "🤖 Copilot: ",
    #         	tool = "🔧 Tool: ",
    #         },
    #         separator = "━━",
    #         show_folds = false, -- Disable folding for cleaner look
    #            }
    #
    #            -- Set up keymaps for CopilotChat
    #            -- vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open CopilotChat" })
    #       '';
    #
    #     keymaps = [
    #       {
    #         key = "<leader>w";
    #         mode = ["n"];
    #         noremap = true;
    #         action = ":w<CR>";
    #         silent = true;
    #         desc = "Save file";
    #       }
    #       {
    #         key = "<C-d>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "<C-d>zz";
    #         silent = true;
    #         desc = "Center after scroll downward half screen";
    #       }
    #       {
    #         key = "<C-u>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "<C-u>zz";
    #         silent = true;
    #         desc = "Center after scroll upward half screen";
    #       }
    #       {
    #         key = "n";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "nzz";
    #         silent = true;
    #         desc = "Center after search forward";
    #       }
    #       {
    #         key = "N";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "Nzz";
    #         silent = true;
    #         desc = "Center after search backwards";
    #       }
    #       {
    #         key = "<A-Down>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = ":m .+1<CR>==";
    #         silent = true;
    #         desc = "Move line Down(n)";
    #       }
    #       {
    #         key = "<A-Down>";
    #         mode = ["v"];
    #         noremap = true;
    #         action = ":m '>+1<CR>gv=gv";
    #         silent = true;
    #         desc = "Move line Down(v)";
    #       }
    #       {
    #         key = "<A-Up>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = ":m .-2<CR>==";
    #         silent = true;
    #         desc = "Move line Up(n)";
    #       }
    #       {
    #         key = "<A-Up>";
    #         mode = ["v"];
    #         noremap = true;
    #         action = ":m '<-2<CR>gv=gv";
    #         silent = true;
    #         desc = "Move line Up(v)";
    #       }
    #       # {
    #       #   key = "<leader>y";
    #       #   mode = ["n"];
    #       #   noremap = true;
    #       #   action = "\"+y";
    #       #   # silent = true;
    #       #   desc = "yank";
    #       # }
    #       {
    #         key = "<leader>y";
    #         mode = ["x"];
    #         noremap = true;
    #         action = "\"+y";
    #         # silent = true;
    #         desc = "yank";
    #       }
    #       # {
    #       #   key = "<leader>y";
    #       #   mode = ["s"];
    #       #   noremap = true;
    #       #   action = "\"+y";
    #       #   # silent = true;
    #       #   desc = "yank";
    #       # }
    #       {
    #         key = "<Space>Y";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "\"+y$";
    #         # silent = true;
    #         desc = "yank";
    #       }
    #       {
    #         key = "<Space>p";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "\"+p";
    #         # silent = true;
    #         desc = "paste";
    #       }
    #       {
    #         key = "<C-h>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "<C-w>h";
    #         desc = "move b/w windows";
    #       }
    #       {
    #         key = "<C-j>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "<C-w>j";
    #         desc = "move b/w windows";
    #       }
    #       {
    #         key = "<C-k>";
    #         mode = ["n"];
    #         noremap = true;
    #         action = "<C-w>k";
    #         desc = "move b/w windows";
    #       }
    #       {
    #         key = "K";
    #         mode = ["n"];
    #         action = "vim.lsp.buf.hover";
    #         desc = "buffer hover vim.lsp.buf.hover";
    #       }
    #       {
    #         key = "<leader>gd";
    #         mode = ["n"];
    #         action = "vim.lsp.buf.definition";
    #         desc = "go to definition vim.lsp.buf.definition";
    #       }
    #       {
    #         key = "<leader>gr";
    #         mode = ["n"];
    #         action = "vim.lsp.buf.references";
    #         desc = "go to references vim.lsp.buf.references";
    #       }
    #       {
    #         key = "<leader>ca";
    #         mode = ["n"];
    #         action = "vim.lsp.buf.code_action";
    #         desc = "code action vim.lsp.buf.code_action";
    #       }
    #       # {
    #       #   key = "<leader>fp";
    #       #   mode = ["n"];
    #       #   action = "vim.lsp.buf.format";
    #       #   desc = "format please vim.lsp.buf.format";
    #       # }
    #       {
    #         key = "<leader>cc";
    #         mode = ["n"];
    #         action = "<cmd>CopilotChatToggle<cr>";
    #         desc = "Toggle CopilotChat";
    #       }
    #       {
    #         key = "<leader>gp";
    #         mode = ["n"];
    #         action = ":Gitsigns preview_hunk<CR>";
    #         desc = "Gitsigns preview_hunk";
    #       }
    #       {
    #         key = "<leader>gt";
    #         mode = ["n"];
    #         action = ":Gitsigns toggle_current_line_blame<CR>";
    #         desc = "Gitsigns toggle blame";
    #       }
    #       # {
    #       #   key = "<leader>lg";
    #       #   mode = ["n"];
    #       #   action = "<cmd>LazyGit<cr>";
    #       #   desc = "Open Lazygit";
    #       # }
    #     ];
    #   };
    # };
  };
}
