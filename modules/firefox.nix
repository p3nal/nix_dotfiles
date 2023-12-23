{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      # https://mozilla.github.io/policy-templates/
      DontCheckDefaultBrowser = true;
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
      HardwareAcceleration = true;
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
        # use Hardware WebRender
        "gfx.webrender.all" = true;
        # use vaapi
        "media.ffmpeg.vaapi.enabled" = true;
        # use xdg portals for everything
        "widget.use-xdg-desktop-portal.mime-handler" = true;
        "widget.use-xdg-desktop-portal.file-picker" = true;
        "widget.use-xdg-desktop-portal.settings" = true;
        "widget.use-xdg-desktop-portal.location" = true;
        "widget.use-xdg-desktop-portal.open-uri" = true;
        # force dark theme
        "ui.systemUsesDarkTheme" = 1;
        # nicer look
        "browser.uidensity" = 1;
        # save to /tmp
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.download.always_ask_before_handling_new_types" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "network.protocol-handler.expose.magnet" = false;
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
        * {
          font-size: 8pt !important;
          font-family: JetBrainsMono Nerd Font Mono !important;
        }

        /* Tab bar */
        toolbarbutton#scrollbutton-up, toolbarbutton#scrollbutton-down {
            /* Hide tab scroll buttons */
            display: none !important;
        }

        .browser-toolbar > * #alltabs-button {
            /* Hide tab drop-down list */
            display: none !important;
        }

        .browser-toolbar > * #new-tab-button {
            /* Hide new-tab button does not work for some reason so..*/
            display: none !important;
        }

        /*** Proton Tabs Tweaks ***/

        /* Adjust tab corner shape, optionally remove space below tabs */

        #tabbrowser-tabs {
            --user-tab-rounding: 12px;
        }

        .tab-background {
            border-radius: var(--user-tab-rounding) !important;
        }

        /* 1/16/2022 Tone down the Fx96 tab border with add-on themes in certain fallback situations */
        .tab-background:is([selected], [multiselected]):-moz-lwtheme {
            --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
        }
        [brighttext="true"] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
            --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
        }

        menupopup:not(.in-menulist) > menuitem,
        menupopup:not(.in-menulist) > menu {
          padding-block: 4px !important; /* reduce to 3px, 2px, 1px or 0px as needed */
          min-height: unset !important; /* v92.0 - for padding below 4px */
        }
        :root {
          --arrowpanel-menuitem-padding: 4px 8px !important;
        }
      '';
    };
  };
}
