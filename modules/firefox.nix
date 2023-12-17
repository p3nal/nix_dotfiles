{config, pkgs, ...}:
{
  programs.firefox = {
    enable = true;
    profiles.penal = {
      settings = {
        "browser.backspace_action" = 0;
	"browser.tabs.closeWindowWithLastTab" = false;
	"browser.download.panel.shown" = true;
      };
      search = {
        engines = {
	      "Nix Packages" = {
		      urls = [{
			      template = "https://search.nixos.org/packages";
			      params = [
			      { name = "type"; value = "packages"; }
			      { name = "query"; value = "{searchTerms}"; }
			      ];
		      }];

		      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
		      definedAliases = [ "@np" ];
	      };
	      # add startpage
        };
	order = [
	  "DuckDuckGo"
	];
	default = "DuckDuckGo";
      };
    };
  };
}
