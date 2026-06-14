{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    extraConfig = {
      credential.helper = "cache"; # Or remove this if already set
    };

    settings = {
      user.name = "Stephen Macabulos";
      user.email = "myteseeker18@gmail.com";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}
