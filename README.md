# swdev (sw-devenv-cli)

This repository contains a helper CLI for managing Shopware 6 devenv instances. It's main purpose is to make the creation of multiple (short-lived) instances easier. This repository assumes that you have successfully setup all prerequisites, which are also described in this [official Shopware guide](https://developer.shopware.com/docs/guides/installation/devenv).

## Table of Contents

* [Quickstart](#quickstart)
* [Command Reference](#command-reference)
* [Setup](#setup)
    * [Prerequisites](#prerequisites)
    * [Installation](#installation)
    * [Configuration](#configuration)
* [Troubleshooting](#troubleshooting)
* [ToDo](#todo)

## Quickstart
For setting up a new Shopware 6 instance.

```bash
# Create a new instance
swdev create --name 6.5-test --branch 6.5.0.0

# This will execute 'devenv up' in the project directory
swdev start --name 6.5-test

# In a second terminal session: Enter the devenv shell to execute Symfony commands like 'composer setup'
swdev shell --name 6.5-test
composer setup
```

## Command Reference

| Command | Description | Arguments | |
| ------- | --------- | ----------- |-- |
| swdev create | foo bar | --name | Name of the project directory. The name will be used for most further commands.  |
||| --branch | Clone a specific Shopware branch. |
| swdev create-config | Create a new devenv.local.nix config file.<br>This is useful, if you manually cloned Shopware or want to reset the config.<br>This command will assign new ports for to setup. | --name | |
| swdev delete | Completely remove the project directory and all local git branches. | --name | |
| swdev help | List all available commands. |-||
| swdev list | List all local instances. |-||
| swdev shell | Open the devenv shell for the specified instance. Requires `swdev start` to be run first and in parallel. Depending on your shell configuration this command will prompt your password.<br>Calls `devenv shell` internally. | --name ||
| swdev start | Start the devenv process for the specified instance.<br>Calls `devenv up` internally. | --name ||
||| --quiet, -q | **WIP**: Run `devenv up` in the background. |
| swdev stop | Stops the devenv process of the specified instance. | --name ||
## Setup

### Prerequisites

* [Git](https://git-scm.com/)
* [Nix, devenv](https://devenv.sh/getting-started/)
* [Optional: Cachix](https://devenv.sh/getting-started/) (Speed up installations)
* [Optional: direnv](https://developer.shopware.com/docs/guides/installation/devenv#direnv) (If accessing projects manually, skip running `devenv shell`)

### Installation

```bash
# e.g. cd /home/$USER/tools/
git clone https://github.com/bschulzebaek/sw-devenv-cli

# Symlink to the executable so you can call 'swdev' anywhere
sudo ln -s /<full-path>/sw-devenv-cli/swdev /usr/local/bin/swdev

# Validate installation
swdev
```


### Configuration

Create a `config.local.yaml` file to override default properties.

| Property | Description | Default |
| ------- | ----------- | -------- |
| base.directory | Shopware instances are stored here. | "/home/$USER/.swdev-projects" |
| base.remote | The Git remote to use for cloning new instances. | "git@github.com:shopware/platform.git" |
| devenv.ports.start | Only use ports in this range for new instances. Use with `devenv.ports.end` | 8000 |
| devenv.ports.end | Only use ports in this range for new instances. Use with `devenv.ports.start` | 10000 |

## Troubleshooting

> Q: Devenv can't restart if original terminal is closed ([see also](https://github.com/cachix/devenv/issues/303))

> A: Currently this needs to be resolved manually, e.g. by deleting the `.dirvenv` directory inside the project, and by killing the remaining processes manually. The used ports can be found in the projects `direnv.local.nix` file.<br><br>In some cases this can be resolved by sending SIGTERM (`kill -15 $pid`) to the pid found in `<project-dir>/.devenv/state/devenv.pid`.

## ToDo

* Auto-completion for subcommands
* Simplify `devenv.template.nix` to bare minimum
* Implement merge of `devenv.template.local.nix` into `devenv.template.nix` in function `create_config` for customization
* Implement background process handling for `devenv up`, used by `start -q` and `stop` commands ([see also](https://github.com/cachix/devenv/pull/83))
* Automatically create v-hosts via `devenv.template.nix` and project name
* Add `services` command to list all used service hosts of a project