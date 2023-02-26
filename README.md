# swdev-cli

## Commands

| Command | Arguments | Description |
| ------- | --------- | ----------- |
| swdev create | --name --branch | Clones a new instance and prepares devenv config. |
| swdev help | - | List all available commands. |
| swdev list | - | List all local instances. |
| swdev setup | --name | Re-run the setup process for an already existing project. |
| swdev start | --name | Starts the devenv process, it will be attached to the current terminal session. |
| swdev stop | --name | ? |

## Installation

### Prerequisites

* Git
* Devenv ([Follow the sw guide](https://developer.shopware.com/docs/guides/installation/devenv))

### Setup

```bash
git clone https://github.com/bschulzebaek/sw-devenv-cli
sudo ln -s /<absolute-repo-path>/sw-devenv-cli /usr/local/bin/swdev

swdev <subcommand> [options]
```


### Configuration

Properties can be changed in the `config.yaml` file.

| Property | Description |
| ------- | ----------- |
| base.directory | The directory where instances are stored. |
| base.remote | The Git remote to use. |
