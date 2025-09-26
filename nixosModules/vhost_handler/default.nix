{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.spreetin.cert_manager;
  mkVHost = item: {
    useACMEHost = mkIf cfg.useSSL "${cfg.domain}";
    forceSSL = mkIf cfg.useSSL true;
    locations."/" = {
      proxyPass = "${item.http_type}://${item.ip}:${builtins.toString item.port}${item.subpath}";
      recommendedProxySettings = true;
      proxyWebsockets = true;
    };
    listen = [
      {
        addr = cfg.host;
        port = if cfg.useSSL then 443 else 80;
        ssl = cfg.useSSL;
      }
    ];
  };
  expand_name = name: "${name}.${cfg.domain}";
  mkHomepageServices =
    let
      mkHPServices =
        items: predicate:
        map (
          { name, value }:
          let
            hc = value.homepage;
            shortname = if (hc.shortName == "") then name else hc.shortName;
            uname = lib.toUpper (substring 0 1 shortname) + (substring 1 (stringLength shortname) shortname);
            top = if (hc.fullName == "") then uname else hc.fullName;
            fqdn = ((if cfg.useSSL then "https" else "http") + "://${name}.${cfg.domain}");
          in
          {
            "${top}" = {
              description = if hc.description == "" then "${uname}" else hc.description;
              href = "${fqdn}";
              icon = "${shortname}.png";
              widget = mkIf hc.widget.enable (
                {
                  type = "${shortname}";
                  url = "${fqdn}";
                }
                // hc.widget.extraArgs
              );
            };
          }
        ) (attrsToList (genAttrs (filteredItems items predicate) (subname: cfg.subdomains.${subname})));
      filteredItems =
        items: predicate:
        filter (
          rubric:
          if
            (
              cfg.subdomains."${rubric}".homepage.enable
              && cfg.subdomains."${rubric}".homepage.category == predicate
            )
          then
            true
          else
            false
        ) (attrNames items);
    in
    map
      (x: {
        ${x} = mkHPServices cfg.subdomains x;
      })
      (
        unique (
          concatLists (
            map (
              name:
              if (cfg.subdomains.${name}.homepage.enable && cfg.subdomains.${name} ? homepage.category) then
                [ cfg.subdomains.${name}.homepage.category ]
              else
                [ ]
            ) (attrNames cfg.subdomains)
          )
        )
      );
  subdomain_module = types.submodule {
    options = {
      ip = mkOption {
        type = types.str;
        description = "IP address to bind to";
        default = "127.0.0.1";
      };
      port = mkOption {
        type = types.int;
        description = "Port to bind to";
      };
      subpath = mkOption {
        type = types.str;
        description = "Path at the server to redirect / to";
        default = "";
      };
      http_type = mkOption {
        type = types.str;
        description = "Url prefix for target, http or https.";
        default = "http";
      };
      homepage = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "Show on homepage";
            category = mkOption {
              type = types.str;
              description = "Under what header to show";
              default = "Other";
            };
            shortName = mkOption {
              type = types.str;
              description = "The name the service is known under for homepage";
              default = "";
            };
            fullName = mkOption {
              type = types.str;
              description = "The full name to use as a header";
              default = "";
            };
            description = mkOption {
              type = types.str;
              default = "";
            };
            widget = mkOption {
              type = types.submodule {
                options = {
                  enable = mkOption {
                    type = types.bool;
                    description = "Use widget";
                    default = true;
                  };
                  extraArgs = mkOption {
                    type = types.attrsOf types.anything;
                    description = "Addition widget configuration (keys/tokens/user)";
                    default = { };
                  };
                };
              };
            };
          };
        };
        default = { };
      };
    };
  };
in
{
  options.spreetin.cert_manager = {
    enable = mkEnableOption "Enable certificate handling";
    useSSL = mkOption {
      type = types.bool;
      description = "Should virtualHosts be using HTTPS";
      default = true;
    };
    certificateEmail = mkOption {
      type = types.str;
      description = "Let's Encrypt account email";
    };
    certDNSProvider = mkOption {
      type = types.str;
      default = "loopia";
    };
    certDNSCredentialsFile = mkOption {
      type = types.path;
      description = "File containing password for Loopia API";
    };
    certDNSResolver = mkOption {
      type = types.str;
      default = "93.188.0.20:53";
    };
    domain = mkOption {
      type = types.str;
      description = "Domain to handle";
      default = "";
    };
    host = mkOption {
      type = types.str;
      description = "Hostname (or IP) to bind to";
      default = "0.0.0.0";
    };
    subdomains = mkOption {
      type = types.attrsOf subdomain_module;
      default = { };
      description = ''
        Subdomains to configure.
        Example:
        test = {
          ip = "192.168.0.1";
          port = 443;
        };
      '';
    };
    homepageAdress = mkOption {
      type = types.str;
      description = "The hostname or IP that homepage will be reached at";
      default = "homepage.${cfg.domain}";
    };
    latitude = mkOption {
      type = types.str or types.null;
      description = "Current latitude";
      default = null;
    };
    longitude = mkOption {
      type = types.str or types.null;
      description = "Current longitude";
      default = null;
    };
  };
  config = mkIf cfg.enable {
    security.acme = mkIf cfg.useSSL {
      certs."${cfg.domain}" = {
        domain = "*.${cfg.domain}";
        email = "${cfg.certificateEmail}";
        dnsProvider = cfg.certDNSProvider;
        environmentFile = cfg.certDNSCredentialsFile;
        dnsResolver = cfg.certDNSResolver;
        group = config.services.nginx.group;
      };
      acceptTerms = true;
    };
    services.nginx = {
      enable = true;
      virtualHosts = lib.listToAttrs (
        builtins.map (item: {
          name = (expand_name item.name);
          value = mkVHost item.value;
        }) (lib.attrsToList cfg.subdomains)
      );
    };
    services.homepage-dashboard = mkIf (lessThan 0 (length mkHomepageServices)) {
      enable = true;
      openFirewall = true;
      allowedHosts =
        "0.0.0.0:"
        + (toString config.services.homepage-dashboard.listenPort)
        + ",127.0.0.1:"
        + (toString config.services.homepage-dashboard.listenPort)
        + ","
        + cfg.homepageAdress;
      widgets = [
        {
          glances = {
            url = "https://127.0.0.1:" + (toString config.services.glances.port);
            version = 4;
            cpu = true;
            mem = true;
            uptime = true;
            disk = "/disk";
          };
        }
        {
          search = {
            provider = "custom";
            url = "https://search.nixos.org/packages?channel=unstable&query=";
            target = "_blank";
            focus = true;
          };
        }
      ]
      ++ optional (cfg.latitude != null && cfg.longitude != null) {
        openmeteo = {
          latitude = cfg.latitude;
          longitude = cfg.longitude;
          timezone = config.time.timeZone;
          units = "metric";
          cache = 5;
        };
      };
      services = mkHomepageServices;
    };
    services.glances = mkIf config.services.homepage-dashboard.enable {
      enable = true;
      openFirewall = true;
      extraArgs = [
        "--webserver"
        "--disable-webui"
      ];
    };
  };
}
