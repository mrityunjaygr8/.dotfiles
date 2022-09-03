{ config, pkgs, ... }:

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
    alacritty
    neovim
    git-crypt
    gnupg
    tmux
    pinentry
    lazygit
    gcc
    rustc
    (nerdfonts.override { fonts = [ "FiraCode" ];})
  ];

  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Mrityunjay Saxena";
    userEmail = "mrityunjaysaxena1996@gmail.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs.fish = {
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
    ];
    shellInit = ''
      # Set syntax highlighting colours; var names defined here:
      # http://fishshell.com/docs/current/index.html#variables-color
      set fish_color_autosuggestion brblack
    '';
    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
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
        body = "";
      };
      mkdcd = {
        description = "Make a directory tree and enter it";
        body = "mkdir -p $argv[1]; and cd $argv[1]";
      };
    };
  };

  xdg.configFile.nvim = {
    source = ./config/nvim;
    recursive = true;
  };


  home.file = {
    "tmux.conf".source = ./config/tmux.conf;
    ".config/alacritty/alacritty.yaml".text = ''
      env:
        TERM: xterm-256color
    '';
  };
}
