{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = false;
      NoDefaultBookmarks = true;
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.nextdns.io/7b342b";
        Locked = false;
      };
    };
    profiles.penal = {
      settings = {
        "browser.backspace_action" = 0;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.download.panel.shown" = true;
        "general.smoothScroll" = true;
        # Turn off the disk cache
        # https://wiki.archlinux.org/title/Firefox/Tweaks#Turn_off_the_disk_cache
        "browser.cache.memory.enable" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.capacity" = 36196;
        # disable pocket
        "extensions.pocket.enabled" = false;
        # force system DPI
        "layout.css.dpi" = 0;
      };
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/do/search";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@g"];
            metaData.alias = "@g";
          };
          "DuckDuckGo".metaData.hidden = false;
        };
        order = [
          "Startpage"
          "DuckDuckGo"
        ];
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
      };
      userChrome = ''
        /* Tab bar */

        toolbarbutton#scrollbutton-up, toolbarbutton#scrollbutton-down {
            /* Hide tab scroll buttons */
            display: none;
        }

        .browser-toolbar > * #alltabs-button {
            /* Hide tab drop-down list */
            display: none;
        }

        .browser-toolbar > * #new-tab-button {
            /* Hide new-tab button */
            display: none;
        }
      '';
    };
  };
}
