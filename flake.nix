{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Add Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Declarative pi coding-agent (extensions/settings/args)
    pi.url = "github:lukasl-dev/pi.nix";

  };

  outputs = { nixpkgs, home-manager, pi, ... }:
    let
      system = "x86_64-linux";
      sharedModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.seeker = import ./home.nix {
            inherit pi;
            pkgs = nixpkgs.legacyPackages.${system};
          };
        }

        {
          # Desktop with NVIDIA GPU + Obsidian — unfree is necessary
          nixpkgs.config.allowUnfree = true;
        }
      ];
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop/configuration.nix
          ] ++ sharedModules;
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/configuration.nix
          ] ++ sharedModules;
        };

        server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/server/configuration.nix
          ] ++ sharedModules;
        };
      };
    };
}
