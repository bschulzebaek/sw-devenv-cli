# swdev (sw-devenv-cli)

This repository contains a helper CLI for managing Shopware 6 devenv instances. It's main purpose is to make the creation of multiple (short-lived) instances easier. This repository assumes that you have successfully setup all prerequisites, which are also described in this [official Shopware guide](https://developer.shopware.com/docs/guides/installation/devenv).

<u>[Detailed information can be found in the wiki.](https://github.com/bschulzebaek/sw-devenv-cli/wiki)</u>

## Quickstart

```bash
git clone https://github.com/bschulzebaek/sw-devenv-cli
sudo ln -s /<full-path>/sw-devenv-cli/swdev /usr/local/bin/swdev

# Create a new instance
swdev create --name 6.5-test --branch 6.5.0.0

# This will execute 'devenv up' in the project directory
swdev start --name 6.5-test

# In a second terminal session: Enter the devenv shell to execute Symfony commands like 'composer setup'
swdev shell --name 6.5-test
composer setup
```

## Command Reference

All listed commands are a subcommand to `swdev`, so they are called like `swdev create --name 6.5-test --branch 6.5.0.0`.

| Command | Description | Arguments | |
| ------- | --------- | ----------- |-- |
| create | Create a new shopware platform clone and add pre-configured devenv config files to it. | --name | Name of the project directory. The name will be used for most further commands.  |
||| --branch | Optional: Clone a specific Shopware branch. |
| create-config | Create a new devenv.local.nix config file.<br>This is useful, if you manually cloned Shopware or want to reset the config.<br>Note: This command will assign new ports to setup. | --name | |
| delete | Completely remove the project directory including all local git branches. Make sure to push any changes beforehand! | --name | |
| help | List all available commands. |-||
| list | List all local instances. |-||
| self-update | Run `git fetch && git pull` in the swdev directory. |-||
| shell | Open the devenv shell for the specified instance. Requires `swdev start` to be run first and in parallel.<br>Note: Depending on your shell configuration this command will prompt your password.<br>Calls `devenv shell` internally. | --name ||
| start | Start the devenv process for the specified instance.<br>Calls `devenv up` internally. | --name ||
||| --quiet, -q | **WIP**: Run `devenv up` in the background. |
| stop | Stops the devenv process of the specified instance.<br>You can also just hit `CTRL+C` if the process is not hidden. | --name ||

## ToDo

* Auto-completion for subcommands
* Simplify `devenv.template.nix` to bare minimum
* Implement background process handling for `devenv up`, used by `start -q` and `stop` commands ([see also](https://github.com/cachix/devenv/pull/83))
* Automatically create v-hosts via `devenv.template.nix` and project name
* Add `services` command to list all used service hosts of a project
* Improve `self-update` command UX
