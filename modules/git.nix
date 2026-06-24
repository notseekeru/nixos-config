{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Use Home Manager's official options for user info
    settings.user.name = "Stephen Macabulos";
    settings.user.email = "myteseeker18@gmail.com";

    settings = {
      # Use the gh CLI as password manager for GitHub
      # Unscoped credential.helper works for all repos and is more reliable
      credential.helper = "!" + "${pkgs.gh}/bin/gh auth git-credential";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}

