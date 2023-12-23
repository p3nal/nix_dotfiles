{ config
, pkgs
, ...
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

        "browser.contentblocking.category" = "strict";
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.purge_trackers.enabled" = true;

        "services.sync.prefs.sync.browser.uiCustomization.state" = true;
        "signon.rememberSignons" = false;
        "browser.onboarding.enabled" = false; # "New to Firefox? Let's get started!" tour
        "browser.aboutConfig.showWarning" = false; # Warning when opening about:config
        # Reduce File IO / SSD abuse
        # Otherwise, Firefox bombards the HD with writes. Not so nice for SSDs.
        # This forces it to write every 5 minutes, rather than 15 seconds.
        "browser.sessionstore.interval" = "300000";
        # Disable "beacon" asynchronous HTTP transfers (used for analytics)
        # https://developer.mozilla.org/en-US/docs/Web/API/navigator.sendBeacon
        "beacon.enabled" = false;
        # Disable telemetry
        # https://wiki.mozilla.org/Platform/Features/Telemetry
        # https://wiki.mozilla.org/Privacy/Reviews/Telemetry
        # https://wiki.mozilla.org/Telemetry
        # https://www.mozilla.org/en-US/legal/privacy/firefox.html#telemetry
        # https://support.mozilla.org/t5/Firefox-crashes/Mozilla-Crash-Reporter/ta-p/1715
        # https://wiki.mozilla.org/Security/Reviews/Firefox6/ReviewNotes/telemetry
        # https://gecko.readthedocs.io/en/latest/browser/experiments/experiments/manifest.html
        # https://wiki.mozilla.org/Telemetry/Experiments
        # https://support.mozilla.org/en-US/questions/1197144
        # https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html#id1
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "browser.ping-centre.telemetry" = false;
        # https://mozilla.github.io/normandy/
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "app.shield.optoutstudies.enabled" = false;
        # Disable health reports (basically more telemetry)
        # https://support.mozilla.org/en-US/kb/firefox-health-report-understand-your-browser-perf
        # https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        # Disable crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;  # don't submit backlogged reports
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
            definedAliases = [ "@np" ];
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
            definedAliases = [ "@g" ];
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

        .browser-toolbar > * #close-tab-button {
          /* testing this out */
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
