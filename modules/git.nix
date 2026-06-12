{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "seeker";
    userEmail = "seeker@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}
