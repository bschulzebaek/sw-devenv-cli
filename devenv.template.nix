{ pkgs, lib, config, ... }:

{

  languages.php.ini = ''
      memory_limit = 2G
      realpath_cache_ttl = 3600
      session.gc_probability = 0
      ${lib.optionalString config.services.redis.enable ''
      session.save_handler = redis
      session.save_path = "tcp://127.0.0.1:__REDIS_PORT__/0"
      ''}
      display_errors = On
      error_reporting = E_ALL
      assert.active = 0
      opcache.memory_consumption = 256M
      opcache.interned_strings_buffer = 20
      zend.assertions = 0
      short_open_tag = 0
      zend.detect_unicode = 0
      realpath_cache_ttl = 3600
    '';

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

  services.mysql.settings.mysqld.port = __DATABASE_PORT__;

  services.redis.port = __REDIS_PORT__;

  services.adminer.enable = true;
  services.adminer.listen = "127.0.0.1:__ADMINER_PORT__";

  services.mailhog.enable = false;

  env.APP_URL = "http://localhost:__CADDY_PORT__";
  env.DATABASE_URL = "mysql://shopware:shopware@127.0.0.1:__DATABASE_PORT__/shopware?sslmode=disable&charset=utf8mb4";
  env.CYPRESS_baseUrl = "http://localhost:__CADDY_PORT__";
}