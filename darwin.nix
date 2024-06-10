{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/projects/dotfiles"

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;

    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };

    # Auto optimise the nix store daily at 3:15am.
    optimise = {
      automatic = true;
      interval = { Hour = 3; Minute = 15; };
    };

    # Auto clean the nix store weekly.
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.monaspace
  ];

  services = {
  };

  homebrew = {
    enable = true;

    casks = [
      "1password"
      "firefox"
    ];

    masApps = {
      "Things" = 904280696;
    };
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        minimize-to-application = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXDefaultSearchScope = "SCcf"; # Search current folder
        FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
      };
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3; # Full Keyboard Mode
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };
}
