# seeker/nixos-config

Three machines, one flake. Declarative NixOS with shared modules and per-host overrides.

## Hosts

| Host     | Hardware              | GPU       | Display              |
|----------|-----------------------|-----------|----------------------|
| desktop  | AMD CPU, NVIDIA GPU   | NVIDIA    | DP-1 + HDMI-A-1      |
| laptop   | Intel CPU             | Intel iGPU| Single               |
| server   | (headless)            | —         | —                    |

## Layout

```
├── flake.nix                   # Entry point: desktop / laptop / server
├── configuration.nix           # Shared NixOS config (boot, network, users, docker, fstrim)
├── home.nix                    # Shared home-manager config (shell, git, neovim, tmux)
├── AGENTS.md                   # AI coding assistant instructions (synced to all projects)
├── hosts/
│   ├── desktop/                # Dual monitor, NVIDIA, WiFi dongle
│   ├── laptop/                 # Intel GPU, Bluetooth
│   └── server/                 # Minimal headless
├── modules/
│   ├── hyprland.nix            # NixOS-level: hyprland, graphics, polkit, libinput
│   ├── hyprland-home.nix       # User-level: keybinds, env, exec-once
│   ├── waybar/                 # Waybar config + style
│   ├── kitty/                  # Kitty terminal config
│   ├── greeter.nix             # Login manager
│   ├── pipewire.nix            # Audio
│   ├── nvidia.nix              # NVIDIA driver config
│   ├── intel-gpu.nix           # Intel GPU config
│   ├── steam.nix               # Steam + 32-bit
│   ├── syncthing.nix           # Syncthing
│   ├── networking.nix          # tcpdump, wireshark
│   ├── git.nix                 # Global git config
│   ├── direnv.nix              # Direnv
│   ├── zsh.nix                 # Zsh
│   ├── tmux.nix                # Tmux
│   ├── tmux-init.nix           # tmux sessionizer
│   └── neovim/                 # Neovim with LSP
├── images/                     # Wallpapers
└── scripts/
    └── sync-agents.sh          # Sync AGENTS.md to projects
```

## Build

```sh
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#server
```

## Principles

- **Shared base, per-host deltas.** Common config lives in `configuration.nix` + `home.nix`. Hosts import and override.
- **No secrets in repo.** GH token loaded from `~/gh-token` at activation time (see `home.nix`).
- **Minimal dependencies.** No flakes-utils, no nix-colors, no home-manager lib wrapper.

## Notable Config

- Hyprland workspaces: `1,2` on DP-1 (main), `3,4` on HDMI-A-1 — persistent in waybar, no wildcards.
- WiFi on the desktop uses `rtl88x2bu` (out-of-tree driver, blacklisted the broken stock modules).
- Tailscale on desktop + laptop — firewall trusts `tailscale0` on all hosts for simplicity.
- Docker on all hosts, NVIDIA container toolkit on desktop.
- GC daily, delete older than 1 day.
- `default.jpg` wallpaper on login via `awww` (pid 1-safe wallpaper setter).
