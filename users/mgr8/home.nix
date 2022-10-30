{ config, pkgs, lib, ... }:

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
    openssl
    xclip
    vscodium
    fzf
    vlc
    tldr
    neovim
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
    rust-analyzer
    neofetch
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    cypress
    postman
    teams
    ripgrep
    fd
    bat
    exa
    python3
    python310Packages.pip
    docker
    docker-compose
    zip
    unzip
    awscli2
    go
    gopls
    terraform
    terragrunt
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.screenshot-tool
    gnome.gnome-screenshot
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
    nix-index = {
      enable = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = ''
        # remap prefix from C-b to C-a
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        set-option -g default-shell ${pkgs.fish}/bin/fish

        # reload config without restarting
        bind r source-file ~/.tmux.conf

        # switch panes without using prefix using Alt-arrow
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # enable mouse mode
        set -g mouse on

        # disable auto-rename of windows
        set-option -g allow-rename off

        # theme
        # loud or quiet?
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none
        set -g default-terminal "tmux-256color"

        #  modes
        setw -g clock-mode-colour colour5
        setw -g mode-style 'bold'
        setw -g mode-keys vi

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'dim'
        set -g status-right '%d/%m %H:%M:%S '
        set -g status-right-length 50
        set -g status-left-length 20

        setw -g window-status-current-style 'bold'
        setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

        setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

        setw -g window-status-bell-style 'bold'

        # messages
        set -g message-style 'bold'

        ## Plugins ##
        # set -g @plugin 'tmux-plugins/tmux-yank'
        # 
        # run -b '~/.tmux/plugins/tpm/tpm'
        
        # NOTE: you can use vars with $<var> and $\{<var>\} as long as the str is double quoted: ""
        # WARNING: hex colors can't contain capital letters
        
        # --> Catppuccin
        thm_bg="#1e1e28"
        thm_fg="#d7dae0"
        thm_cyan="#c2e7f0"
        thm_black="#15121c"
        thm_gray="#2d293b"
        thm_magenta="#c6aae8"
        thm_pink="#f0afe1"
        thm_red="#e28c8c"
        thm_green="#b3e1a3"
        thm_yellow="#eadda0"
        thm_blue="#a4b9ef"
        thm_orange="#f7c196"
        catppuccin12="#3e4058"

        # ----------------------------=== Theme ===--------------------------

        # status
        set -g status-position top
        set -g status "on"
        set -g status-bg "$thm_bg"
        set -g status-justify "left"
        set -g status-left-length "100"
        set -g status-right-length "100"

        # messages
        set -g message-style fg="$thm_cyan",bg="$thm_gray",align="centre"
        set -g message-command-style fg="$thm_cyan",bg="$thm_gray",align="centre"

        # panes
        set -g pane-border-style fg="$thm_gray"
        set -g pane-active-border-style fg="$thm_blue"

        # windows
        setw -g window-status-activity-style fg="$thm_fg",bg="$thm_bg",none
        setw -g window-status-separator ""
        setw -g window-status-style fg="$thm_fg",bg="$thm_bg",none

        # --------=== Statusline

        set -g status-left ""
        set -g status-right "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]  #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg]  #[fg=$thm_fg,bg=$thm_gray] #S "

        # current_dir
        setw -g window-status-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
        setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "

        # parent_dir/current_dir
        # setw -g window-status-format "#[fg=colour232,bg=colour111] #I #[fg=colour222,bg=colour235] #(uecho "#{pane_current_path}" | rev | cut -d'/' -f-2 | revu) "
        # setw -g window-status-current-format "#[fg=colour232,bg=colour208] #I #[fg=colour255,bg=colour237] #(echo "#{pane_current_path}" | rev | cut -d'/' -f-2 | rev) "

        # --------=== Modes
        setw -g clock-mode-colour "$thm_blue"
        setw -g mode-style "fg=$thm_pink bg=$catppuccin12 bold"


        # things for NVIM
        set-option -sg escape-time 10
        set-option -g focus-events on
        set-option -sa terminal-overrides ',xterm-256color:RGB'
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
            sha256 = "sha256-FJxz6zyz1N4F7EcGVPqqO6D9nzvB1GyDdOOvmNcewrI=";
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
        set -Ux GIT_ASKPASS ""
        set -Ux LD_LIBRARY_PATH "${pkgs.stdenv.cc.cc.lib}/lib"

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
        g = "git";
        m = "make";
        n = "nvim";
        o = "open";
        p = "python3";
      };
      functions = {
        fish_greeting = {
          description = "Greeting to show when starting a fish shell";
          body = "echo noot noot";
        };
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

      extensions = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "gnome-shell-screenshot@ttll.de" "clipboard-indicator@tudmotu.com" "appindicatorsupport@rgcjonas.gmail.com" ];
        };
      };
    in
    lib.mkMerge [ custom_shortcuts wm_keybinds extensions ];

}
