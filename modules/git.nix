{pkgs, ...}: {
  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            name = "p3nal";
            email = "103528596+p3nal@users.noreply.github.com";
            signingkey = "/home/penal/.ssh/id_ed25519.pub";
          };
          commit = {
            gpgSign = true;
          };
          tag = {
            gpgSign = true;
          };
          init = {
            defaultBranch = "master";
          };
          gpg = {
            format = "ssh";
          };
          github = {
            user = "p3nal";
          };
          # gitlab = {};
        };
      }
    ];
  };
}
