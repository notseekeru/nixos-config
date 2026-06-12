     outputs = { self, nixpkgs, ... }: {
       nixosConfigurations = {
         nixos = nixpkgs.lib.nixosSystem {
           system = "x86_64-linux";
           modules = [
             ./configuration.nix # <-- This MUST be relative to the flake.nix
           ];
         };
       };
     };
