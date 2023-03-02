{ pkgs, lib, config, ... }:

let vars = {
    app = {
        protocol = "__APP_PROTOCOL__";
        url = "__APP_URL__";
        port = __APP_PORT__;
    };

    redis = {
        port = __REDIS_PORT__;
    };

    database = {
        port = __DATABASE_PORT__;
    };

    adminer = {
        port = __ADMINER_PORT__;
    };

    installer = {
        port = __INSTALLER_PORT__;
    };
}; in {
    env.APP_URL = "${vars.app.protocol}://${vars.app.url}:${toString vars.app.port}";
    env.CYPRESS_baseUrl = "${vars.app.protocol}://${vars.app.url}:${toString vars.app.port}";
    services.caddy.config = ''
        ${vars.app.protocol}://${vars.app.url}:${toString vars.app.port} {
            root * public
            php_fastcgi unix/${config.languages.php.fpm.pools.web.socket}
            file_server
        }
    '';

    services.redis.port = vars.redis.port;
    languages.php.ini = ''
        session.save_path = "tcp://127.0.0.1:${toString vars.redis.port}/0"
    '';

    services.mysql.settings.mysqld.port = vars.database.port;
    env.DATABASE_URL = "mysql://shopware:shopware@127.0.0.1:${toString vars.database.port}/shopware?sslmode=disable&charset=utf8mb4";

    services.adminer.enable = true;
    services.adminer.listen = "127.0.0.1:${toString vars.adminer.port}";

    env.INSTALL_URL = "http://localhost:${toString vars.installer.port}";
}