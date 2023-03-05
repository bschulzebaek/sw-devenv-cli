# swdev (sw-devenv-cli)

This repository contains a helper CLI for managing Shopware 6 devenv instances. It's main purpose is to make the creation of multiple (short-lived) instances easier. This repository assumes that you have successfully setup all prerequisites, which are also described in this [official Shopware guide](https://developer.shopware.com/docs/guides/installation/devenv).

<u>[Detailed information can be found in the wiki.](https://github.com/bschulzebaek/sw-devenv-cli/wiki)</u>

## Quickstart

```bash
git clone https://github.com/bschulzebaek/sw-devenv-cli
sudo ln -s /<full-path>/sw-devenv-cli/swdev /usr/local/bin/swdev

# Create a new instance
swdev create 65-test --branch 6.5.0.0

# This will execute 'devenv up' in the project directory
swdev start 65-test

# Now you can open http://65-test.dev.localhost and should see a PHP error page
# In a second terminal session: Enter the devenv shell to execute Symfony commands like 'composer setup'
swdev shell 65-test
composer setup
```

## Command Reference

All listed commands are a subcommand to `swdev`, so they are called like `swdev create 65-test --branch 6.5.0.0`.

| Command | Description | Arguments | |
| ------- | --------- | ----------- |-- |
| `create <name>` | Create a new shopware platform clone and add pre-configured devenv config files to it. | --branch | Optional: Clone a specific Shopware branch. |
| `create-config <name>` | Create a new devenv.local.nix config file.<br>This is useful, if you manually cloned Shopware or want to reset the config.<br>Note: This command will assign new ports to setup. | -y | Confirm overriding config. |
| `delete <name>` | Completely remove the project directory including all local git branches. Make sure to push any changes beforehand! | -y | Confirm deleting project. |
| `help` | List all available commands. |||
| `info <name>` | List all services for the specified instance. |||
| `list` | List all local instances. |||
| `open <name>` | Open the specified instance in your default browser. WIP: This command might not work depending on your operating system. Use `swdev info <name>` in this case. |||
| `self-update` | Runs `git fetch && git pull` in the swdev directory. |||
| `shell <name>` | Open the devenv shell for the specified instance. Requires `swdev start` to be run first and in parallel.<br>Calls `devenv shell` internally. |||
| `start <name>` | Start the devenv process for the specified instance.<br>Calls `devenv up` internally. |||
| `stop <name>` | Stops the devenv process of the specified instance.<br>You can also  hit `CTRL+C` in the terminal if the `swdev start` process is not hidden. |||

## ToDo

* Auto-completion for subcommands
* Implement background process handling for `devenv up`, used by `start -q` and `stop` commands ([see also](https://github.com/cachix/devenv/pull/83))
* Improve `self-update` command UX
* Add interactive mode (-i) to `create-config` command to specify ports/urls and to enable/disable services (mailhog, redis, adminer)