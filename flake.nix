   {
     inputs = {
       nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
       # Add Home Manager
       home-manager.url = "github:nix-community/home-manager";
       home-manager.inputs.nixpkgs.follows = "nixpkgs";
     };

     outputs = { self, nixpkgs, home-manager, ... }: {
       nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
           ./configuration.nix
           home-manager.nixosModules.home-manager {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.users.seeker = import ./home.nix;
           }
         ];
       };
     };
   }
