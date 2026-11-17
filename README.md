# Peripheral Battery

Battery levels of your wireless mouse, headset, keyboard or controller, right on the KDE Plasma panel, plus a notification before they die mid-game.

```
🖱 54%  🎧 73%⚡
```

## Supported devices

| Source | Covers | Needs |
|---|---|---|
| `openrazer` | Razer wireless mice and keyboards | `openrazer-daemon` (and your user in the `openrazer` group) |
| `headsetcontrol` | SteelSeries, Logitech, Corsair, HyperX and other headsets | `headsetcontrol` |
| `upower` | Bluetooth devices, Logitech Unifying/Bolt, game controllers | `upower` (usually already installed) |
| `command` | Anything else: your own command that prints a number | — |

## Install (Arch / CachyOS / Manjaro)

```bash
paru -S peripheral-battery
```

Or build from this repo with `makepkg -si` in the `pkg/` folder, or `sudo make install` anywhere.

Then:

1. Right-click the panel → **Add Widgets** → **Peripheral Battery**.
2. Turn on low-battery notifications:
   ```bash
   systemctl --user enable --now peripheral-battery-alert.timer
   ```

## Size and look

Right-click the widget → **Configure Peripheral Battery** to set the text size, bold, spacing between devices, and how often it refreshes.

## Choose your devices

With no config, every detected device is shown. To pick devices, labels, icons and warning levels, click the widget or run:

```bash
peripheral-battery setup
```

`peripheral-battery list` shows everything that can be detected. The config lives at `~/.config/peripheral-battery/devices.conf` and can be edited by hand:

```ini
[settings]
low = 15

[device:Mouse]
source = openrazer
match = Naga            ; part of the device name
icon = 🖱
low = 20

[device:Headset]
source = headsetcontrol
match = 1038:2232       ; USB vendor:product, or part of the name
icon = 🎧

[device:Controller]
source = command
command = cat /sys/class/power_supply/ps-controller-battery-xx:xx/capacity
icon = 🎮
```

Devices appear on the panel in the order they're listed.

## License

MIT
