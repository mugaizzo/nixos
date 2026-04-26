{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    terminal.nvim.enable = lib.mkEnableOption "enable nvim";
  };

  # imports = [
  #   inputs.nixvim.homeModules.nixvim
  # ];

  config = lib.mkIf config.terminal.nvim.enable {
    home.packages = with pkgs; [
      alejandra
      lua54Packages.tiktoken_core
      lynx
      statix
      nil
      # vimPlugins.catppuccin-nvim
      # Required for treesitter
      gcc
      # Required for telescope
      fd
      # Latex support for render-markdown
      python312Packages.pylatexenc
    ];
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

      clipboard = {
        providers.xclip.enable = true;
        register = "unnamedplus";
      };

      colorschemes.catppuccin = {
        enable = true;
        autoLoad = true;
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

        abolish = {
          enable = true;
        };

        telescope = {
          enable = true;
          # autoLoad = true;
          extensions = {
            fzf-native.enable = true;
            live-grep-args.enable = true;
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
            "<leader>fG" = {
              action = "live_grep_args";
              options = {
                desc = "Live grep args [Telescope]";
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
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
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

        copilot-chat = {
          enable = true;
          settings = {

            answer_header = "## Copilot ";
            question_header = "## User ";
            error_header = "## Error ";
            auto_follow_cursor = true;
            model = "gpt-4.1";
            highlight_selection = true;
            selection = ''
                          function(source)
                local select = require('CopilotChat.select')
                return select.visual(source) or select.line(source)
              end
            '';
            separator = "───";
            show_folds = true;
            show_help = true;
            system_prompt = "require('CopilotChat.prompts').COPILOT_INSTRUCTIONS";
            temperatur = 0.1;
            history_path = config.lib.nixvim.mkRaw "vim.fn.stdpath('data') .. '/copilotchat_history'";
            mappings = {
              accept_diff = {
                insert = "<C-y>";
                normal = "<C-y>";
              };
              close = {
                insert = "<C-c>";
                normal = "q";
              };
              complete = {
                insert = "<Tab>";
              };
              jump_to_diff = {
                normal = "gj";
              };
              quickfix_diffs = {
                normal = "gq";
              };
              reset = {
                insert = "<C-l>";
                normal = "<C-l>";
              };
              show_context = {
                normal = "gc";
              };
              show_diff = {
                normal = "gd";
              };
              show_help = {
                normal = "gh";
              };
              show_info = {
                normal = "gi";
              };
              submit_prompt = {
                insert = "<C-s>";
                normal = "<CR>";
              };
              toggle_sticky = {
                detail = "Makes line under cursor sticky or deletes sticky line.";
                normal = "gr";
              };
              yank_diff = {
                normal = "gy";
                register = "\"";
              };
            };
            prompts = {
              Commit = {
                prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.";
                selection = "require('CopilotChat.select').gitdiff";
              };
              CommitStaged = {
                prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.";
                selection = ''
                  function(source)
                    return select.gitdiff(source, true)
                  end
                '';
              };
              Docs = {
                prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.";
              };
              Explain = {
                prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.";
              };
              Fix = {
                prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.";
              };
              FixDiagnostic = {
                prompt = "Please assist with the following diagnostic issue in file:";
                selection = "require('CopilotChat.select').diagnostics";
              };
              Optimize = {
                prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.";
              };
              Review = {
                callback = ''
                  function(response, source)
                    -- see config.lua for implementation
                  end
                '';
                prompt = "/COPILOT_REVIEW Review the selected code.";
              };
              Tests = {
                prompt = "/COPILOT_GENERATE Please generate tests for my code.";
              };
            };
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
        {
          action = "<cmd>Yazi<CR>";
          key = "<C-Up>";
        }
        {
          action = "<cmd>CopilotChatToggle<CR>";
          key = "<leader>cc";
        }
      ];
    };
  };
}
