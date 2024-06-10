{
  description = "Zavan's Nix System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    darwin,
    home-manager,
    ...
  } @ inputs: {
    darwinConfigurations = {
      # M1 MacBook Air
      "Joicys-MacBook-Air" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.zavan = import ./home.nix;
              backupFileExtension = "hm-backup";
            };
            users.users.zavan.home = "/Users/zavan";
          }
        ];
      };

      # Intel MacBook Pro
      "Felipes-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.zavan = import ./home.nix;
              backupFileExtension = "hm-backup";
            };
            users.users.zavan.home = "/Users/zavan";
          }
        ];
      };
    };
  };
}
