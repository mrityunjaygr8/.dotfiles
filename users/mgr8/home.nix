{ config, pkgs, lib, ... }:

let
  # moonfly = pkgs.vimUtils.buildVimPluginFrom2Nix {
  #   name = "moonfly";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "bluz71";
  #     repo = "vim-moonfly-colors";
  #     rev = "d3ff722e84a9571acbb489e8e85b2a44bbefb602";
  #     hash = "sha256-kvnh3NzKmLzVQ4I1KtZMEAcDZ+gZVF9TFfg1BhswbN4=";
  #   };
  # };
  github_theme_nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "ea713c37691b2519f56cd801a2330bdf66393d0f";
      hash = "sha256-MGQvyQj1rLN4tuIRkn3AWKCFXXDlLZ552YM/HTguhpU=";
    };
    preInstall = ''
      echo "This file is being removed, otherwise when building help tags, we are getting an error saying duplicate tags"
      rm -rf ./doc/gt_deprecated.txt
    '';
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mgr8";
  home.homeDirectory = "/home/mgr8";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    pre-commit
    openssl
    xclip
    vscodium
    fzf
    vlc
    tldr
    # neovim
    git-crypt
    gnupg
    tmux
    pinentry
    direnv
    lazygit
    lazydocker
    rustc
    cargo
    gdb
    neofetch
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    cypress
    postman
    teams
    ripgrep
    zoxide
    fd
    exa
    gnumake
    python3
    python310Packages.pip
    docker
    docker-compose
    zip
    unzip
    awscli2
    go
    clang-tools_14
    gopls
    terraform
    terragrunt
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.screenshot-tool
    gnome.gnome-screenshot
    jq
    calibre
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    (alacritty.overrideAttrs (attrs: {
      postInstall = (attrs.postInstall or "") + ''
        rm -rf $out/share/applications/Alacritty.desktop
      '';

    }))
  ];

  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
  };

  services.lorri.enable = true;

  programs.git = {
    enable = true;
    userName = "Mrityunjay Saxena";
    userEmail = "mrityunjaysaxena1996@gmail.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      credential = {
        helper = "store";
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = ''
        luafile $HOME/.config/nvim/lua/user/options.lua
        luafile $HOME/.config/nvim/lua/user/keymaps.lua
        luafile $HOME/.config/nvim/lua/user/colorscheme.lua
        luafile $HOME/.config/nvim/lua/user/treesitter.lua
        luafile $HOME/.config/nvim/lua/user/lsp.lua
        luafile $HOME/.config/nvim/lua/user/cmp.lua

        lua << EOF
        vim.defer_fn(
          function()
            vim.cmd [[
              luafile $HOME/.config/nvim/lua/user/autocommands.lua
              luafile $HOME/.config/nvim/lua/user/autopairs.lua
              luafile $HOME/.config/nvim/lua/user/bufferline.lua
              luafile $HOME/.config/nvim/lua/user/colorizer.lua
              luafile $HOME/.config/nvim/lua/user/comment.lua
              luafile $HOME/.config/nvim/lua/user/gitsigns.lua
              luafile $HOME/.config/nvim/lua/user/lualine.lua
              luafile $HOME/.config/nvim/lua/user/nvim-tree.lua
              luafile $HOME/.config/nvim/lua/user/surround.lua
              luafile $HOME/.config/nvim/lua/user/telescope.lua
              luafile $HOME/.config/nvim/lua/user/toggleterm.lua
              luafile $HOME/.config/nvim/lua/user/whichkey.lua
            ]]
          end, 70)
        EOF
      '';
      extraPackages = with pkgs; [
        lua-language-server
        rust-analyzer
        gopls
        rustfmt
        shellcheck
        rnix-lsp
        terraform-ls
        nodePackages.pyright
        nodePackages.typescript-language-server
        tree-sitter
        code-minimap
        luaPackages.lua-lsp
        nodePackages.yaml-language-server
        nodePackages.bash-language-server
        nodePackages.vscode-langservers-extracted
      ];

      plugins = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            nix
            python
            dockerfile
            c
            css
            scss
            bash
            fish
            go
            hcl
            html
            javascript
            json
            lua
            make
            markdown
            rust
            sql
            terraform
            toml
            tsx
            typescript
            yaml
          ]
        ))
        plenary-nvim
        popup-nvim
        nord-nvim
        nvim-autopairs
        comment-nvim
        nvim-web-devicons
        nvim-tree-lua
        bufferline-nvim
        vim-bbye
        lualine-nvim
        toggleterm-nvim
        impatient-nvim
        indent-blankline-nvim
        which-key-nvim
        lazygit-nvim
        # moonfly
        github_theme_nvim

        vim-nix


        lsp-zero-nvim
        nvim-lspconfig
        nvim-cmp
        cmp-buffer
        cmp-path
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua

        telescope-nvim



        nvim-ts-context-commentstring
        nvim-ts-rainbow

        gitsigns-nvim

        nvim-colorizer-lua
        nvim-surround
      ];
    };
    nix-index = {
      enable = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      shortcut = "Space";
      baseIndex = 1;
      escapeTime = 0;
      keyMode = "vi";
      shell = "${pkgs.fish}/bin/fish";
      mouse = true;
      # plugins = with pkgs; [
      #   tmuxPlugins.nord
      # ];
      extraConfig = ''
        # split panes
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        # reload config without restarting
        bind r source-file $HOME/.config/tmux/tmux.conf

        # switch panes without using prefix using Alt-arrow
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # disable auto-rename of windows
        set-option -g allow-rename off

        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # Github colors for Tmux

        set -g mode-style "fg=#c9d1d9,bg=#1f2428"

        set -g message-style "fg=#c9d1d9,bg=#1f2428"
        set -g message-command-style "fg=#c9d1d9,bg=#1f2428"

        set -g pane-border-style "fg=#444c56"
        set -g pane-active-border-style "fg=#2188ff"

        set -g status "on"
        set -g status-justify "left"

        set -g status-style "fg=#2188ff,bg=#1f2428"

        set -g status-left-length "100"
        set -g status-right-length "100"

        set -g status-left-style NONE
        set -g status-right-style NONE

        set -g status-left "#[fg=#1f2428,bg=#2188ff,bold] #S #[fg=#2188ff,bg=#1f2428,nobold,nounderscore,noitalics]"
        set -g status-right "#[fg=#1f2428,bg=#1f2428,nobold,nounderscore,noitalics]#[fg=#1f2428,bg=#1f2428] #{prefix_highlight} #[fg=#e1e4e8,bg=#1f2428,nobold,nounderscore,noitalics]#[fg=#586069,bg=#e1e4e8] %Y-%m-%d  %I:%M %p #[fg=#2188ff,bg=#e1e4e8,nobold,nounderscore,noitalics]#[fg=#1f2428,bg=#2188ff,bold] #h "

        setw -g window-status-activity-style "underscore,fg=#d1d5da,bg=#1f2428"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=#24292e,bg=#1f2428"
        setw -g window-status-format "#[fg=#1f2428,bg=#1f2428,nobold,nounderscore,noitalics]#[fg=#666666,bg=#1f2428,nobold,nounderscore,noitalics] #I  #W #F #[fg=#1f2428,bg=#1f2428,nobold,nounderscore,noitalics]"
        setw -g window-status-current-format "#[fg=#1f2428,bg=#e1e4e8,nobold,nounderscore,noitalics]#[fg=#586069,bg=#e1e4e8,bold] #I  #W #F #[fg=#e1e4e8,bg=#1f2428,nobold,nounderscore,noitalics]"
      '';

    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
            sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          };
        }
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "pure-fish";
            repo = "pure";
            rev = "a959c8b97d5d444e1e1a04868967276acc127099";
            sha256 = "sha256-6T/4ThQ2KXrSnLBfCHF8PC3rg16D9cCUCvrS8RSvCno=";
          };
        }
        {
          name = "catppuccin";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fish";
            rev = "cb79527f5bd53f103719649d34eff3fbae634155";
            sha256 = "sha256-ciUNJrZE1EJ6YeMmEIjX/vDiP2MCG1AYHpdjeQOOSxg=";
          };
        }
        {
          name = "nvm";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "nvm.fish";
            rev = "9db8eaf6e3064a962bca398edd42162f65058ae8";
            sha256 = "sha256-LkCpij6i5XEkZGYLx9naO/cnbkUCuemypHwTjvfDzuk=";
          };
        }
        {
          name = "virtualfish";
          src = pkgs.fetchFromGitHub {
            owner = "justinmayer";
            repo = "virtualfish";
            rev = "e6163a009cad32feb02a55a631c66d1cc3f22eaa";
            sha256 = "sha256-u6wm+bWCkxxYbtb4wer0AGyVdvuaBiOH1nRmpZssVHo=";
            postFetch = ''
              mkdir $out/conf.d
              mv $out/virtualfish/*.fish $out/conf.d
            '';
          };
        }
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "fzf";
            rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
            sha256 = "sha256-28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
          };
        }
      ];
      shellInit = ''
        # Set syntax highlighting colours; var names defined here:
        # http://fishshell.com/docs/current/index.html#variables-color
        set fish_color_autosuggestion brblack

        fish_config theme choose Nord
        set -Ux GIT_ASKPASS ""
        set VIRTUALFISH_PYTHON_EXEC $(which python)

        zoxide init fish | source

        direnv hook fish | source
        set -g direnv_fish_mode disable_arrow
      '';
      shellAliases = {
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
        tmux = "tmux -u";
        ll = "exa -alhtaccessed";
      };
      shellAbbrs = {
        lg = "lazygit";
        ld = "lazydocker";
        g = "git";
        m = "make";
        n = "nvim";
        o = "open";
        p = "python3";
      };
      functions = {
        mkdcd = {
          description = "Make a directory tree and enter it";
          body = "mkdir -p $argv[1]; and cd $argv[1]";
        };
      };
    };
  };


  xdg.configFile.nvim = {
    source = ../../config/nvim;
    recursive = true;
  };

  xdg.desktopEntries.alacritty = {
    name = "Alacritty";
    genericName = "Terminal";
    type = "Application";
    exec = "env -u WAYLAND_DISPLAY alacritty";
    icon = "Alacritty";
    categories = [ "System" "TerminalEmulator" ];
    comment = "A fast, cross-platform, OpenGL terminal emulator";
  };


  home.file = {
    ".config/alacritty/" = {
      source = ../../config/alacritty;
      recursive = true;
    };
  };


  dconf.settings =
    let
      custom_shortcuts =
        let
          inherit (builtins) length head tail listToAttrs genList;
          range = a: b: if a < b then [ a ] ++ range (a + 1) b else [ ];
          globalPath = "org/gnome/settings-daemon/plugins/media-keys";
          path = "${globalPath}/custom-keybindings";
          mkPath = id: "${globalPath}/custom${toString id}";
          isEmpty = list: length list == 0;
          mkSettings = settings:
            let
              checkSettings = { name, command, binding }@this: this;
              aux = i: list:
                if isEmpty list then [ ] else
                let
                  hd = head list;
                  tl = tail list;
                  name = mkPath i;
                in
                aux (i + 1) tl ++ [{
                  name = mkPath i;
                  value = checkSettings hd;
                }];
              settingsList = (aux 0 settings);
            in
            listToAttrs (settingsList ++ [
              {
                name = globalPath;
                value = {
                  custom-keybindings = genList (i: "/${mkPath i}/") (length settingsList);
                };
              }
            ]);
        in
        mkSettings [
          {
            name = "Launch Alacritty";
            command = "env -u WAYLAND_DISPLAY alacritty";
            binding = "<Super>Return";
          }
          {
            name = "Launch Firefox";
            command = "firefox";
            binding = "<Super>b";
          }
        ];

      wm_keybinds = {
        "org/gnome/shell/keybindings" = {
          toggle-message-tray = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          volume-down = [ "<Control><Alt>minus" "XF86AudioLowerVolume" ];
          volume-mute = [ "<Control><Alt>0" "XF86AudioMute" ];
          volume-up = [ "<Control><Alt>equal" "XF86AudioRaiseVolume" ];
        };
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Shift><Super>c" ];
          toggle-maximized = [ "<Super>m" ];
        };
      };

      app_menu_config = {
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
      };

      extensions = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "gnome-shell-screenshot@ttll.de" "clipboard-indicator@tudmotu.com" "appindicatorsupport@rgcjonas.gmail.com" ];
        };
      };
    in
    lib.mkMerge [ custom_shortcuts wm_keybinds extensions app_menu_config ];

}
