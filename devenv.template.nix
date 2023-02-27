{ pkgs, lib, config, ... }:

{

  services.mailhog.enable = false;

  services.caddy = {
    enable = lib.mkDefault true;

    virtualHosts.":__CADDY_PORT__" = lib.mkDefault {
      extraConfig = lib.mkDefault ''
        @default {
          not path /theme/* /media/* /thumbnail/* /bundles/* /css/* /fonts/* /js/* /sitemap/*
        }

        root * public
        php_fastcgi @default unix/${config.languages.php.fpm.pools.web.socket} {
            trusted_proxies private_ranges
        }
        file_server
      '';
    };
  };


  services.mysql = {
    enable = true;
    initialDatabases = lib.mkDefault [{ name = "shopware"; }];
    ensureUsers = lib.mkDefault [
      {
        name = "shopware";
        password = "shopware";
        ensurePermissions = {
          "shopware.*" = "ALL PRIVILEGES";
          "shopware_test.*" = "ALL PRIVILEGES";
        };
      }
    ];
    settings = {
      mysqld = {
        log_bin_trust_function_creators = 1;
        port = __DATABASE_PORT__;
      };
    };
  };

  services.adminer.listen = "127.0.0.1:__ADMINER_PORT__";
  services.redis.port = __REDIS_PORT__;

  env.APP_URL = "http://localhost:__CADDY_PORT__";
  env.DATABASE_URL = "mysql://shopware:shopware@127.0.0.1:__DATABASE_PORT__/shopware?sslmode=disable&charset=utf8mb4";
}