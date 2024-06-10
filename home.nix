{ pkgs, lib, ... }:

{
  home = {
    # *Do not touch this. Even if you're upgrading.*
    # This should stay at the version originally installed.
    stateVersion = "24.05";

    packages = [
      pkgs.devenv
      pkgs.nixd
    ];

    file = {
      ".gitignore".source = ./files/.gitignore;
      ".gitconfig".source = ./files/.gitconfig;
    };

    sessionVariables = {
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
