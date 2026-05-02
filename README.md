<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150730092-337cd5de-f376-454a-9418-c884bdb5f5e0.png" width="900">
</p>

<h1 align="center">QuinxOS</h1>
<p align="center">
  <strong>Termux Optimization & Customization Suite</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Tool-QuinxOS-00e5ff?style=flat-square&logo=linux">
  <img src="https://img.shields.io/badge/Version-4.2-purple?style=flat-square">
  <img src="https://img.shields.io/badge/Themes-15-2ed573?style=flat-square">
  <img src="https://img.shields.io/badge/Maintained-Yes-2ed573?style=flat-square">
  <img src="https://img.shields.io/badge/License-GNU-blue?style=flat-square">
</p>

<p align="center">
  <a href="https://github.com/Shineii86">
    <img src="https://img.shields.io/badge/GitHub-Shineii86-00e5ff?style=for-the-badge&logo=github">
  </a>
</p>

---

## What is QuinxOS?

**QuinxOS** is the most feature-rich terminal customization suite for Termux. 23 menu options, 15 color themes, plugin system, live dashboard, and guided setup — all in one script.

---

## ✨ Features at a Glance

| Feature | Description |
|---------|-------------|
| 🎨 **15 Theme Presets** | Cyber Midnight, Matrix Green, Gruvbox, Tokyo Night, Catppuccin, Nord, Synthwave, and 8 more |
| 📌 **Persistent Header** | System info bar survives `clear` — shows time, IP, battery, RAM, git branch |
| 🌐 **Dynamic Boot Banner** | Live IP, date, battery, RAM displayed at boot |
| 🎵 **Login Sound** | Play audio or terminal bell on boot |
| 🎭 **RGB Animation** | Color-cycling loading sequence |
| 🛠️ **Dev Tools Installer** | One-click Python, Node, Go, Rust, Ruby, PHP, Neovim, tmux |
| ⚡ **Quick Commands** | Git init, compress, find large files, kill port, HTTP serve, SSH keygen |
| ⚡ **Aliases Manager** | Create, list, delete shell aliases + common presets |
| 🧩 **Plugin System** | Drop `.sh` files in plugins folder — auto-loaded on boot |
| 🖼️ **Custom ASCII Art** | Set your own banner text |
| 🔒 **Quinx Shield** | Terminal lock with recovery system |
| 📊 **System Info** | Architecture, kernel, uptime, CPU, RAM, disk, packages |
| 🌐 **Network Info** | IP, DNS, hostname, connectivity tests |
| 💾 **Backup/Restore** | Save & load all configs |
| 📝 **MOTD Editor** | Custom boot message |
| 🧙 **First-Run Wizard** | 4-step guided setup on first launch |
| 🔄 **Auto-Update Check** | Daily check for new versions |
| 🗑️ **Uninstaller** | Clean removal |

---

## 🎨 Theme Gallery (15 Themes)

| # | Theme | Style |
|---|-------|-------|
| 1 | Cyber Midnight | Deep space with neon accents |
| 2 | Matrix Green | Classic hacker terminal |
| 3 | Solar Flare | Warm dark with orange/gold |
| 4 | Arctic Blue | Cool blue and ice tones |
| 5 | Purple Haze | Deep purple with magenta |
| 6 | Dracacula | Dracula-inspired dark theme |
| 7 | Nord | Arctic north-blue clean theme |
| 8 | Gruvbox | Retro groove warm theme |
| 9 | Tokyo Night | Clean VS Code dark |
| 10 | Catppuccin Mocha | Smooth pastel dark |
| 11 | Everforest | Nature-inspired green |
| 12 | Monokai | Classic code editor |
| 13 | Synthwave | Neon retro 80s |
| 14 | Rosé Pine | Gentle pine/rose/gold |
| 15 | Kanagawa | Japanese ink painting |

---

## 🧩 Plugin System

Drop `.sh` files in `.object/plugins/` — they auto-load on terminal start.

**Built-in plugins:**
- `quinx-weather <city>` — Weather info
- `quinx-extract <file>` — Universal archive extractor
- `quinx-ports [host]` — Quick port scanner

Create your own! See `.object/plugins/README.md` for details.

---

## 📌 Persistent Header

After `clear`, you still see:
```
┌──[14:32:07] IP:192.168.1.5 BAT:85% RAM:1.2G/4G Git:[main]───────┘
```

---

## Installation

```bash
git clone https://github.com/Shineii86/QuinxOS.git
cd QuinxOS
bash install.sh
```

> **First launch?** The setup wizard guides you through shell, theme, banner, and name.

---

## Menu Options (23)

| # | Feature | # | Feature |
|---|---------|---|---------|
| 01 | Core Setup | 13 | Custom ASCII Art |
| 02 | Zsh Config | 14 | Login Sound |
| 03 | Switch → Zsh | 15 | System Info |
| 04 | Switch → Bash | 16 | Network Info |
| 05 | Banner Style | 17 | MOTD Editor |
| 06 | Custom Theme | 18 | Backup/Restore |
| 07 | Zsh Plugins | 19 | Quinx Shield |
| 08 | Theme Gallery (15) | 20 | Remove Lock |
| 09 | Dev Tools | 21 | Update |
| 10 | Quick Commands | 22 | Uninstall |
| 11 | Aliases Manager | 23 | RGB Animation Preview |
| 12 | Plugin System | 00 | Exit |

---

## Credits

- [Oh My Zsh](https://ohmyz.sh/)
- Original concept: [Termux-OS](https://github.com/h4ck3r0/Termux-os) by H4CK3R
- Redesigned & maintained by **Shineii86**

---

<p align="center">
  <a href="https://github.com/Shineii86">
    <img src="https://img.shields.io/badge/GitHub-Shineii86-00e5ff?style=for-the-badge&logo=github">
  </a>
</p>
