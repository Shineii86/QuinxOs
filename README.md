<div align="center">

<img src="https://user-images.githubusercontent.com/46929618/150730092-337cd5de-f376-454a-9418-c884bdb5f5e0.png" width="100%">

# **QuinxOS**

### **The Ultimate Termux Customization Suite**

<br>

<img src="https://img.shields.io/badge/Version-5.0-00e5ff?style=for-the-badge&logo=semver">
<img src="https://img.shields.io/badge/Themes-15-a855f7?style=for-the-badge&logo=materialdesign">
<img src="https://img.shields.io/badge/Plugins-11-2ed573?style=for-the-badge&logo=gnometerminal">
<img src="https://img.shields.io/badge/Menu_Options-34-ff4757?style=for-the-badge&logo=linux">
<img src="https://img.shields.io/badge/License-GNU-0088ff?style=for-the-badge&logo=gnu">

<br>

<img src="https://img.shields.io/badge/Maintained-Yes-2ed573?style=flat-square">
<img src="https://img.shields.io/badge/Bash-5.0+-4eaa25?style=flat-square&logo=gnubash">
<img src="https://img.shields.io/badge/Termux-Required-000000?style=flat-square&logo=android">
<img src="https://img.shields.io/github/stars/Shineii86/QuinxOS?style=flat-square&logo=github">
<img src="https://img.shields.io/github/forks/Shineii86/QuinxOS?style=flat-square&logo=github">

<br>

[**📥 Install**](#-installation) &nbsp;|&nbsp; [**🎨 Themes**](#-theme-gallery) &nbsp;|&nbsp; [**🧩 Plugins**](#-plugin-system) &nbsp;|&nbsp; [**📖 Docs**](#-all-features) &nbsp;|&nbsp; [**🤝 Contribute**](#-contributing)

</div>

---

## What is QuinxOS?

**QuinxOS** is the most feature-rich terminal optimization and customization suite for **Termux**. It transforms your boring terminal into a polished, secure, and powerful development environment — with **34 menu options**, **15 built-in themes**, a **plugin system**, **live dashboard**, **biometric lock**, and much more.

> One script. One command. Total transformation.

---

## ⚡ Quick Start

```bash
pkg update && pkg upgrade -y && pkg install git -y
git clone https://github.com/Shineii86/QuinxOS.git
cd QuinxOS && bash install.sh
```

> 🧙 **First launch?** A guided wizard walks you through shell, theme, banner, and name selection.

---

## 🎯 What's New in v5.0

| Feature | Description |
|:--------|:------------|
| 🖥️ **Live Dashboard** | Full-screen real-time system monitor — CPU, RAM, battery, network, processes |
| 🔐 **Fingerprint Lock** | Biometric authentication via Termux API |
| 🔍 **Command Palette** | Fuzzy-search across all features, aliases, and plugins |
| ☁️ **Dotfiles Sync** | Push/pull your configs to/from a private GitHub repo |
| 🎨 **Theme Builder** | Interactive color picker — create custom themes with live preview |
| 👤 **Profile System** | Multiple profiles (Work, Personal, Hacking) with separate configs |
| 📊 **Git Dashboard** | Full repo info — branch, commits, changes, stashes, tags |
| 📡 **Termux API Hooks** | Battery status, GPS location, clipboard, torch, vibration |
| ⏱️ **QuinxBench** | System benchmark — CPU, disk, network speed scoring |
| ⏲️ **Startup Timer** | Measure how fast your shell loads |
| 📦 **Color Export** | Export themes to Windows Terminal, iTerm2, Alacritty, Kitty |
| 🧩 **8 New Plugins** | Calculator, QR code, timer, password gen, notes, color info, dictionary, system report |

---

## 🎨 Theme Gallery

**15 handcrafted color schemes** — from cyberpunk neon to nature-inspired calm.

| # | Theme | Vibe | # | Theme | Vibe |
|:-:|:------|:-----|:-:|:------|:-----|
| 1 | **Cyber Midnight** | Deep space neon | 9 | **Tokyo Night** | Clean VS Code |
| 2 | **Matrix Green** | Classic hacker | 10 | **Catppuccin Mocha** | Smooth pastel |
| 3 | **Solar Flare** | Warm orange dark | 11 | **Everforest** | Nature green |
| 4 | **Arctic Blue** | Cool ice tones | 12 | **Monokai** | Classic editor |
| 5 | **Purple Haze** | Purple magenta | 13 | **Synthwave** | Neon 80s retro |
| 6 | **Dracacula** | Dracula-inspired | 14 | **Rosé Pine** | Gentle rose/gold |
| 7 | **Nord** | Arctic north-blue | 15 | **Kanagawa** | Japanese ink |
| 8 | **Gruvbox** | Retro groove | | | |

> 💡 **Theme Builder** lets you create unlimited custom themes beyond these 15.

---

## 🧩 Plugin System

Drop `.sh` files in `.object/plugins/` — they auto-load on terminal start.

### Built-in Plugins (11)

| Command | Plugin | What It Does |
|:--------|:-------|:-------------|
| `quinx-weather <city>` | Weather | Current weather for any city |
| `quinx-extract <file>` | Extract | Universal archive extractor (tar, zip, rar, 7z, etc.) |
| `quinx-ports [host]` | Ports | Quick port scanner |
| `quinx-calc 'expr'` | Calculator | Math expressions with bc |
| `quinx-qr 'text'` | QR Code | Generate QR codes |
| `quinx-timer <secs>` | Timer | Countdown timer + stopwatch |
| `quinx-pass [len]` | Password | Random password generator |
| `quinx-note add/list` | Notes | Quick note-taking system |
| `quinx-color '#hex'` | Color Info | Color converter with preview |
| `quinx-report` | Sys Report | Full system report (saved to file) |
| `quinx-define <word>` | Dictionary | English dictionary lookup |

### Creating Your Own

```bash
# .object/plugins/my-plugin.sh
#!/bin/bash
quinx-hello() {
    echo "Hello from QuinxOS!"
}
```

Restart terminal → `quinx-hello` works immediately.

---

## 📌 Persistent Header

After pressing `clear`, you still see your system status:

```
┌──[14:32:07] IP:192.168.1.5 BAT:85% RAM:1.2G/4G Git:[main]───────┘
```

Time, IP address, battery, RAM usage, and git branch — always visible.

---

## 🖥️ Live Dashboard

Full-screen real-time system monitor (refreshes every 2 seconds):

```
╔══════════════════════════════════════════════════════════╗
║              QUINXOS LIVE DASHBOARD v5.0                 ║
╠══════════════════════════════════════════════════════════╣
║  ▸ Time:      2026-05-02 14:32:07                       ║
║  ▸ CPU:       12%   Load: 0.5 0.3 0.2                   ║
║  ▸ Memory:    1200MB/4096MB (29%)                        ║
║  ▸ Disk:      8.2G/64G (13%)                            ║
║  ▸ Battery:   85%                                        ║
║  ▸ Network:   IP: 192.168.1.5                           ║
╚══════════════════════════════════════════════════════════╝
```

---

## 📡 Termux API Integration

Requires `pkg install termux-api` + [Termux:API app](https://f-droid.org/packages/com.termux.api/).

| Hook | What It Does |
|:-----|:-------------|
| Battery Status | Show charge level, temperature, health |
| GPS Location | Latitude, longitude, altitude, accuracy |
| Notifications | List device notifications |
| Clipboard | Get/set clipboard contents |
| Torch | Toggle flashlight on/off |
| Vibrate | Vibrate the device |

---

## 📦 Color Export

Export any QuinxOS theme to work in other terminals:

| Format | Terminal |
|:-------|:---------|
| JSON | Windows Terminal |
| PLIST | iTerm2 (macOS) |
| YAML | Alacritty |
| CONF | Kitty |

---

## 📋 All Features

| # | Feature | # | Feature |
|:-:|:--------|:-:|:--------|
| 01 | Core Setup | 18 | Git Dashboard |
| 02 | Zsh Config | 19 | System Info |
| 03 | Switch → Zsh | 20 | Network Info |
| 04 | Switch → Bash | 21 | QuinxBench |
| 05 | Banner Style (3) | 22 | Profile System |
| 06 | Custom Theme | 23 | Dotfiles Sync |
| 07 | Zsh Plugins | 24 | Termux API Hooks |
| 08 | Theme Gallery (15) | 25 | MOTD Editor |
| 09 | Theme Builder | 26 | Backup/Restore |
| 10 | Color Export | 27 | Startup Timer |
| 11 | Dev Tools | 28 | Quinx Shield |
| 12 | Quick Commands | 29 | Fingerprint Lock |
| 13 | Aliases Manager | 30 | Remove Lock |
| 14 | Plugin System | 31 | Command Palette |
| 15 | Custom ASCII Art | 32 | Update |
| 16 | Login Sound | 33 | Uninstall |
| 17 | Live Dashboard | 34 | RGB Animation |

---

## 🛠️ Dev Tools Installer

One-click installation for popular development tools:

| Tool | Includes | Tool | Includes |
|:-----|:---------|:-----|:---------|
| **Python 3** | pip, ipython, virtualenv | **Go** | golang compiler |
| **Node.js** | npm, yarn | **Rust** | cargo, rustc |
| **Ruby** | gem, bundler | **PHP** | php |
| **Git + SSH** | git, openssh | **Neovim** | Modern editor |
| **tmux** | Terminal multiplexer | **Stacks** | All Python, All Web |

---

## ⚡ Quick Commands

Common operations without leaving QuinxOS:

- **Git Init + Push** — Initialize and push a new repo
- **Compress Folder** — Create .tar.gz archive
- **Find Large Files** — Top 10 biggest files on disk
- **Kill Port** — Kill process on any port
- **HTTP Serve** — Start local web server
- **SSH Keygen** — Generate ed25519 keypair
- **Process Monitor** — Top processes by CPU
- **WiFi Info** — Network details

---

## 🔒 Security Features

### Quinx Shield
Encrypted terminal lock with:
- 3-attempt lockout with session termination
- Auto-generated 16-char recovery key
- Standalone `quinx-unlock` script
- Recovery options after lockout

### Fingerprint Lock
Biometric authentication using Termux API — no passwords needed.

---

## 👤 Profile System

Switch between different configurations instantly:

- **Work** — Clean theme, dev aliases, Python plugins
- **Personal** — Neon theme, custom banner, all plugins
- **Hacking** — Matrix Green, security tools, OSINT plugins

Each profile stores: theme, banner, aliases, zshrc, plugins.

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork** this repository
2. **Create** a feature branch (`git checkout -b feature/amazing`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing`)
5. **Open** a Pull Request

### Ideas for Contributions
- New themes (submit `.colors` files)
- New plugins (submit `.sh` files)
- Bug fixes and improvements
- Documentation translations

---

## 📊 Project Stats

| Metric | Value |
|:-------|:------|
| Menu Options | 34 |
| Color Themes | 15 |
| Built-in Plugins | 11 |
| Shell Supported | Zsh + Bash |
| Install Script | ~1,800 lines |
| Dependencies | Pure Bash (no Python/Node required for core) |

---

## 🙏 Credits

- [Oh My Zsh](https://ohmyz.sh/) — Zsh framework
- [Termux](https://termux.dev/) — Android terminal emulator
- Original concept: [Termux-OS](https://github.com/h4ck3r0/Termux-os) by H4CK3R
- Built with ❤️ by **[Shineii86](https://github.com/Shineii86)**

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**[⬆ Back to Top](#quinxos)**

<br>

<a href="https://github.com/Shineii86/QuinxOS">
<img src="https://img.shields.io/badge/⭐_Star_this_repo-Shineii86/QuinxOS-00e5ff?style=for-the-badge&logo=github">
</a>

<br>

<sub>Built for Termux • Powered by Bash • Made by Shineii86</sub>

</div>
