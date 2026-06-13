{ config, pkgs, ... }:

{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "seeker";
      user.email = "seeker@gmail.com";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}
