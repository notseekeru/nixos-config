{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Add Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # pi-coding-agent only: the main nixpkgs pin predates pi 1.0, and bumping it
    # would rebuild the system. Pinned to the nixpkgs commit that shipped 1.0.3.
    # Drop this input once nixpkgs is bumped past 2026-10-05.
    nixpkgs-pi.url = "github:nixos/nixpkgs/5e867b1db0f219e0e906574cca1175f421a87834";
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
