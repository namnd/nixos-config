{ config, pkgs, lib, ... }:

let
  isVm = pkgs.stdenv.hostPlatform.isLinux;
  isHost = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
  programs.gpg.enable = true;

  home.packages = with pkgs; [
    neovim
    lemonade
    rnix-lsp
    cht-sh
  ] ++ lib.optionals (isVm) [
    awscli2
    aws-vault
    coreutils
    csvkit
    jq
    fd
    fzf
    tldr
    tree
    cloc
    hugo
    ripgrep
    gcc
    unzip
  ] ++ lib.optionals (isHost) [
    pass
  ];

  programs.direnv = {
    enable = true;
    config = {
      global = {
        warn_timeout = "10m";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    signing = {
      key = "3E656F30";
      signByDefault = true;
    };
    aliases = {
      undo = "!git reset HEAD~1 --mixed";
      graph = "!f()  { git log --graph --abbrev-commit --decorate --all; }; f";
    };
    extraConfig = {
      color = {
        ui = true;
        diff = true;
        status = true;
        branch = true;
        interactive = true;
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.default = "current";
      format.pretty = "%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)";
    };
    ignores = [
      "Session.vim"
      ".direnv"
    ] ++ lib.optionals (isHost) [
      ".DS_Store"
    ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    dotDir = "./.config/zsh";
    history = {
      expireDuplicatesFirst = true;
      save = 10000;
      share = true;
      size = 10000;
    };
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      vim = "nvim";
      ls = "ls --color=auto";
      ll = "ls -l";
      all = "ls -al";
      ".." = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      ga = "git add --patch";
      gs = "git status";
      gc = "git checkout";
      gp = "git pull";
      gP = "git push";
      gd = "git diff";
      gl = "git log";
      gg = "git graph";
      gb = "_git_branch";
      gL = "_git_log";
      mcd = "f() { mkdir -p $1 && cd $1 }; f";
      v = "aws-vault exec --debug --backend=file --duration=1h";
      ssh = "kitty +kitten ssh -R 2489:127.0.0.1:2489";
    };
  };

  imports = [
    ./custom.nix
  ];
}

