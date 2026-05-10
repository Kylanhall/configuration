{
  description = "github.com/kylanhall";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs: {
    nixosConfigurations = {
      topaz = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/Topaz/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.kylan = {
              imports = [
                ./modules/home/kylan.nix
                ./modules/home/programs/plasma/common.nix
                ./modules/home/programs/plasma/topaz.nix
              ];
            };
          }
        ];
      };

      # Framework
      # framework = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/Framework/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.backupFileExtension = "backup";
      #       home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
      #       home-manager.users.kylan = {
      #         imports = [
      #           ./modules/home/kylan.nix
      #           ./modules/home/programs/plasma/common.nix
      #           ./modules/home/programs/plasma/framework.nix
      #         ];
      #       };
      #     }
      #   ];
      # };
    };
  };
}