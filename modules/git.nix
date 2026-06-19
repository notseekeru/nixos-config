{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Use Home Manager's official options for user info
    settings.user.name = "Stephen Macabulos";
    settings.user.email = "myteseeker18@gmail.com";

    settings = {
      # 1. Use the gh CLI as your password manager for GitHub
      credential."https://github.com".helper = "!" + "${pkgs.gh}/bin/gh auth git-credential";

      # 2. Your custom settings moved to the correct spot
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}

