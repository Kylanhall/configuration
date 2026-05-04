# My NixOS Configuration
My two hosts are my Desktop (Topaz), and I generally have a mobile device. Currently it's a Macbook Pro, but I intend on selling it as I don't have a use case for it anymore. Going to end up getting the Framework Pro 13 probably next year.

## Use Cases
Topaz is my main desktop for development and light gaming these days. My mobile device is strictly development, with no gaming at all.

## TODO
I want to setup Neovim using the nix language, so my neovim configuration is consistent across devices. I may also setup a generic "server" host, so I can deploy virtual machines much more quickly. The server host would naturally not have a desktop environment.

- Neovim setup
- General UI improvements (waybar, consistent theme, maybe a different browser)

## Deploying
1. Install NixOS
2. Copy SSH key onto the machine
3. Clone this repo:
```bash
nix-shell -p git
git clone git@github.com:kylanhall/nixos-config.git ~/.config/nixos
```
4. Generate hardware config:
```bash
sudo nixos-generate-config --root /
cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/hosts/<hostname>/
```
5. Rebuild:
```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#<hostname>
```

## Alias
From any machine, just run:
```bash
rebuild
```

## Troubleshooting
if `rebuild` does not work, use the full command `sudo nixos-rebuild switch --flake ~/.config/nixos#<hostname>` if that fails, it's likely the backup. In that case, run this command `find ~ -name "*.backup" -delete`
