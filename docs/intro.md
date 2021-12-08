---
sidebar_position: 1
---

# Installation

## Wally based workflow

To retrieve any packages through this workflow, [Wally](https://github.com/UpliftGames/wally) is required.

| Package | Dependency | Description |
| -- | -- | -- |
| NumberUtil | `"finobinos/numberutil@1.1.5"` | NumberUtil |
| UserInput | `"finobinos/userinput@1.3.0"` | UserInputUtil |
| TableUtil | `"finobinos/tableutil@1.1.6"` | TableUtil |
| Maid | `"finobinos/Maid@1.2.4"` | Maid class |
| Timer | `"finobinos/timer@1.3.0"` | Timer class |
| Signal | `"finobinos/signal@1.2.2` | Signal class |
| Remote | `"finobinos/remote@1.3.6"` | RemoteUtil |

Run `wally init` on your project's directory, and then add the various utility modules through the `wally.toml` file. For e.g, the following would be a `wally.toml` file for a project that needs a signal and a maid module:

```
[package]
name = "finobinos/Project"
version = "0.1.0"
registry = "https://github.com/UpliftGames/wally-index"
realm = "shared"

[dependencies]
Signal = "finobinos/signal@1.1.9"
Maid = "finobinos/maid@1.2.3"
``` 

These dependencies can be then installed to your project through `wally install`, which will create a folder `Packages` in your project containing the dependencies.

The package folder created can then be synced into Roblox Studio through [Rojo](https://rojo.space/). The following `default.project.json` file would be used to sync the package folder into Roblox Studio:

```json
{
    "name": "Project",
    "tree": {
        "$className": "DataModel",
        
        "ReplicatedStorage": {
            "$className": "ReplicatedStorage",
            "Packages": {
                "$path": "Packages"
            }
        }
    }
}
```

## Roblox based workflow

You can retrieve the packages from [here](https://www.roblox.com/library/7930326233).