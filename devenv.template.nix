{ pkgs, lib, config, ... }:

let vars = {
    appProtocol = "__APP_PROTOCOL__";
    appUrl = "__APP_URL__";
    redisPort = __REDIS_PORT__;
    databasePort = __DATABASE_PORT__;
    adminerPort = __ADMINER_PORT__;
    installerPort = __INSTALLER_PORT__;
}; in {
    env.APP_URL = "${vars.appProtocol}://${vars.appUrl}";
    env.CYPRESS_baseUrl = "${vars.appProtocol}://${vars.appUrl}";

    scripts.caddy-setcap.exec = ''sudo setcap 'cap_net_bind_service=+eip' ${pkgs.caddy}/bin/caddy '';
    services.caddy = lib.mkForce {
        enable = true;

        virtualHosts."${vars.appProtocol}://${vars.appUrl}" = {
            extraConfig = ''
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

    services.redis.enable = lib.mkForce false;
    services.redis.port = vars.redisPort;
    languages.php.ini = ''
        ${lib.optionalString config.services.redis.enable ''
        session.save_handler = redis
        session.save_path = "tcp://127.0.0.1:${toString vars.redisPort}/0"
        ''}
    '';

    services.mysql.settings.mysqld.port = vars.databasePort;
    env.DATABASE_URL = "mysql://shopware:shopware@127.0.0.1:${toString vars.databasePort}/shopware?sslmode=disable&charset=utf8mb4";

    services.mailhog.enable = lib.mkForce false;

    services.adminer.enable = true;
    services.adminer.listen = "127.0.0.1:${toString vars.adminerPort}";

    env.INSTALL_URL = "http://localhost:${toString vars.installerPort}";
}