{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Add Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # pi-coding-agent only: the main nixpkgs pin predates pi 1.0, and bumping it
    # would rebuild the system. Pinned to the nixpkgs commit that shipped 1.0.4.
    # Drop this input once nixpkgs is bumped past 2026-10-06.
    nixpkgs-pi.url = "github:nixos/nixpkgs/73e11bb9754652b05324c6f7270a1629cfb7be3d";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-pi, ... }:
    let
      system = "x86_64-linux";
      sharedModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.seeker = import ./home.nix;
        }

        {
          # Desktop with NVIDIA GPU + Obsidian — unfree is necessary
          nixpkgs.config.allowUnfree = true;
        }

        {
          nixpkgs.overlays = [
            (final: prev: {
              pi-coding-agent = nixpkgs-pi.legacyPackages.${system}.pi-coding-agent;
            })
          ];
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
