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
    uget
    pre-commit
    xclip
    fzf
    wl-clipboard
    direnv
    lazygit
    lazydocker
    neofetch
    ripgrep
    zoxide
    fd
    exa
    python3
    docker
    docker-compose
    zip
    unzip
    awscli2
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
      languages = {
        language = [{
          name = "go";
          config = {goimports = true; gofumpt = true; staticcheck = true; analyses = { unusedparams = true; unreachable = true; };};
        }];
      };
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
          esc = ["collapse_selection" "keep_primary_selection"];
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
    nix-index = {
      enable = true;
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
