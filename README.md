# swdev-cli

This repository contains a helper CLI for managing Shopware 6 devenv instances. It's main purpose is to make the creation of multiple (short-lived) instances easier. This repository assumes that you have successfully setup all prerequisites, which are also described in this [official Shopware guide](https://developer.shopware.com/docs/guides/installation/devenv).

## Quickstart

```
swdev create --name 6.5.0.0-test --branch 6.5.0.0
```

## Commands

| Command | Arguments | Description |
| ------- | --------- | ----------- |
| swdev create | --name<br>--branch | Clones a new instance and prepare devenv config. |
| swdev create-config | --name | Optional: Creates a new devenv.local.nix config file. This is useful, if you manually setup a project directory or want to reset the config. This commands finds unused ports for the setup. |
| swdev delete | --name | Completely remove the project directory and all local git branches. |
| swdev get-dir | --name | Prints the absolute path to the specified instance. |
| swdev help | - | List all available commands. |
| swdev list | - | List all local instances. |
| swdev start | --name | Starts the devenv process, it will be attached to the current terminal session. |
| swdev shell | --name | Open the devenv shell for the specified instance. |

## Setup

### Prerequisites

* [Git](https://git-scm.com/)
* [Nix, Cachix (optional), devenv](https://devenv.sh/getting-started/)

### Installation

```bash
# e.g. cd /home/<user>/tools/
git clone https://github.com/bschulzebaek/sw-devenv-cli

# Optional: Symlink to the executable so you can call 'swdev' from everywhere
sudo ln -s /<full-path>/sw-devenv-cli/swdev /usr/local/bin/swdev

swdev <subcommand> [options]
```


### Configuration

Properties can be changed in the `config.yaml` file.

| Property | Description |
| ------- | ----------- |
| base.directory | The directory where instances are stored in. |
| base.remote | The Git remote to use for cloning new instances. |
