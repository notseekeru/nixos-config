{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Use Home Manager's official options for user info
    userName = "Stephen Macabulos";
    userEmail = "myteseeker18@gmail.com";

    extraConfig = {
      # 1. Use the gh CLI as your password manager for GitHub
      credential."https://github.com".helper = "!" + "${pkgs.gh}/bin/gh auth git-credential";

      # 2. Your custom settings moved to the correct spot
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}

