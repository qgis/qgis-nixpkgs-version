# 📦 QGIS nixpkgs Versions

> Centralized nixpkgs version pinning for QGIS projects

[![Update nixpkgs](https://github.com/qgis/qgis-nixpkgs-version/actions/workflows/flake-update.yml/badge.svg)](https://github.com/qgis/qgis-nixpkgs-version/actions/workflows/flake-update.yml)

## 🎯 Overview

This repository serves as a central flake for pinning and synchronizing nixpkgs versions across multiple QGIS repositories. By using a shared nixpkgs version, we achieve:

- **🔄 Dependency Deduplication** – Avoids duplicate dependencies across projects
- **⚡ Efficient Binary Caching** – Improves build times through better cache utilization
- **🔒 Consistent Environments** – Ensures all projects use compatible package versions
- **🎛️ Centralized Management** – Update nixpkgs in one place, propagate everywhere

## 🏗️ Dependent Projects

This shared nixpkgs configuration is used across several QGIS infrastructure repositories:

| Project | Repository | Description |
|---------|-----------|-------------|
| **qgis.org** | [QGIS-Website](https://github.com/qgis/QGIS-Website) | QGIS Main Website |
| **planet.qgis.org** | [QGIS-Planet-Website](https://github.com/qgis/QGIS-Planet-Website) | QGIS Planet Blog Aggregator |
| **uc2025.qgis.org** | [QGIS-UC-Website](https://github.com/qgis/QGIS-UC-Website) | QGIS User Conference Website |

## 📋 Flake Structure

This flake exposes two nixpkgs inputs:

```nix
# flake.nix
{
  description = "Shared nixpkgs versions for QGIS";
  inputs.nixpkgs-25-11.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs-25-11, nixpkgs-unstable }: {
    inherit nixpkgs-25-11 nixpkgs-unstable;
  };
}
```

### Available Versions

- **`nixpkgs-25-11`** – Stable NixOS 25.11 release
- **`nixpkgs-unstable`** – Rolling unstable channel with latest packages

## 🚀 Usage

To use the shared nixpkgs in your QGIS-related project:

### 1️⃣ Add as Input

Add this repository as an input to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs-version.url = "github:QGIS/qgis-nixpkgs-version";
    nixpkgs.follows = "nixpkgs-version/nixpkgs-25-11";
  };
  
  outputs = { self, nixpkgs, nixpkgs-version, ... }: {
    # Your flake outputs here
  };
}
```

### 2️⃣ Update Lock File

After adding the input, update your lock file:

```bash
nix flake update nixpkgs-version
```

### 3️⃣ Follow Upstream Updates

When this repository updates its nixpkgs pins, update your dependent repository:

```bash
nix flake update nixpkgs
```

## 🤖 Automated Updates

This repository includes a GitHub Actions workflow that automatically keeps nixpkgs versions up to date.

### Workflow Details

- **Schedule**: Runs weekly every **Sunday at 1:00 AM UTC** (`0 1 * * 0`)
- **Manual Trigger**: Can be triggered manually via `workflow_dispatch`
- **Updates**: Both `nixpkgs-25-11` and `nixpkgs-unstable` (via matrix strategy)
- **Process**:
  1. Checks out the repository
  2. Installs Nix
  3. Runs `nix flake update` for each nixpkgs version
  4. Creates a pull request with the updated `flake.lock`

### PR Workflow

When updates are available, the workflow automatically:
1. Creates a pull request titled `flake: flake update [version]`
2. Includes instructions for dependent repositories
3. Waits for manual review and merge

After merging an update PR, remember to update dependent repositories with:

```bash
nix flake update nixpkgs-version
```

## 📚 Resources

- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [nixpkgs Repository](https://github.com/NixOS/nixpkgs)
- [NixOS Releases](https://nixos.org/manual/nixos/stable/release-notes)

## 👥 Contributors

- **Ivan Mincik** ([@imincik](https://github.com/imincik)) – Original author

---

<div align="center">
  <sub>Built with ❤️ for the QGIS community</sub>
</div>
