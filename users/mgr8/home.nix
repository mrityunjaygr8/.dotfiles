{ pkgs, lib, ... }:

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
    # jetbrains.goland
    # jetbrains.pycharm-professional
    libreoffice-fresh
    azure-cli
    uget
    qemu
    google-cloud-sdk
    # vmware-workstation
    pre-commit
    commit-mono
    openssl
    bruno
    stylua
    xclip
    vscodium
    fzf
    vlc
    wl-clipboard
    tldr
    # neovim
    nil
    git-crypt
    nnn
    # python
    python311Packages.python-lsp-server
    gnupg
    tmux
    pinentry
    direnv
    gitui
    lazygit
    lazydocker
    rustc
    cargo
    devbox
    cheat
    gdb
    neofetch
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    cypress
    # postman
    teams-for-linux
    ripgrep
    zoxide
    fd
    via
    qmk
    eza
    gnumake
    python3
    # poetry
    python311Packages.pip
    docker
    docker-compose
    ungoogled-chromium
    zip
    unzip
    # awscli2
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

    # LSPs start
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
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    # LSPs end
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
    zellij = {
      enable = true;
      # enableFishIntegration = true;
      settings = {
        copy_command = "wl-copy";
        simplified_ui = true;
        pane_frames = false;
        default_shell = "fish";
        theme = "tns";
        # tns is tokyo night storm
        themes.tns = {
          fg = "#A9B1D6";
          bg = "#24283B";
          black = "#383E5A";
          red = "#F93357";
          green = "#9ECE6A";
          yellow = "#E0AF68";
          blue = "#7AA2F7";
          magenta = "#BB9AF7";
          cyan = "#2AC3DE";
          white = "#C0CAF5";
          orange = "#FF9E64";
        };
      };
    };
    helix = {
      enable = true;
      # languages = {
      #   language = [{
      #     name = "go";
      #     config = { goimports = true; gofumpt = true; staticcheck = true; analyses = { unusedparams = true; unreachable = true; }; };
      #   }];
      # };
      settings = {
        theme = "kanagawa";
        editor = {
          bufferline = "always";
          line-number = "relative";
          lsp.display-messages = true;
          cursor-shape.insert = "bar";
          lsp.auto-signature-help = true;
          indent-guides.render = true;
        };
        keys.normal = {
          space.g = ":run-shell-command zellij run -fc -- lazygit";
          space.w = ":w";
          space.q = ":q";
          space.c = ":buffer-close";
          space.C = ":buffer-close-others";
          space.I = ":toggle lsp.display-inlay-hints";
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
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

        fish_add_path $HOME/.local/bin

        set -gx EDITOR hx
        # The WAYLAND_DISPLAY env is not being set in terminals other than GNOME CONSOLE.
        # This was creating a problem when using helix, as it as not using wayland specific 
        # clipboard provider due to this.
        # This function is a workaround for setting the WAYLAND_DISPLAY env
        if not set -q "WAYLAND_DISPLAY"
          if set -q "XDG_SESSION_TYPE"
              echo "XDG_SESSION_TYPE is set"
              set SESSION_TYPE "$XDG_SESSION_TYPE"      

              if test "$SESSION_TYPE" = "wayland"
                  echo "Setting WAYLAND_DISPLAY to 'wayland-0'"
                  set -Ux WAYLAND_DISPLAY "wayland-0"
              else
                  echo "SESSION_TYPE is not 'wayland', exiting"
              end
          else
              echo "XDG_SESSION_TYPE is unset, exiting"
          end
        end
      '';
      shellAliases = {
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
        tmux = "tmux -u";
        ll = "eza -alhtaccessed";
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

  xdg.desktopEntries.ghostty = {
    name = "Ghostty";
    type = "Application";
    genericName = "Terminal";
    exec = "ghostty";
    icon = "Alacritty";
    categories = [
      "System"
      "TerminalEmulator"
    ];
    comment = "A terminal emulator";
  };


  home.file = {
    ".config/alacritty/" = {
      source = ../../config/alacritty;
      recursive = true;
    };
    ".config/ghostty/config" = {
      text = ''
        font-family = CommitMono
        font-size = 15
        command = fish
      '';
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
