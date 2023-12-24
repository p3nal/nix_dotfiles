{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["zathura.desktop"];
      "image/*" = ["sxiv.desktop"];
      "video/png" = ["vlc.desktop"];
      "video/jpg" = ["vlc.desktop"];
      "video/*" = ["vlc.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/chrome" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/x-extension-htm" = ["firefox.desktop"];
      "application/x-extension-html" = ["firefox.desktop"];
      "application/x-extension-shtml" = ["firefox.desktop"];
      "application/xhtml+xml" = ["firefox.desktop"];
      "application/x-extension-xhtml" = ["firefox.desktop"];
      "application/x-extension-xht" = ["firefox.desktop"];
    };
  };
}
