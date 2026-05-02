<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150730092-337cd5de-f376-454a-9418-c884bdb5f5e0.png" width="900">
</p>

<h1 align="center">QuinxOS</h1>
<p align="center">
  <strong>Termux Optimization & Customization Suite</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Tool-QuinxOS-00e5ff?style=flat-square&logo=linux">
  <img src="https://img.shields.io/badge/Version-4.1-purple?style=flat-square">
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

**QuinxOS** is an all-in-one terminal customization suite for Termux. Transform your default shell into a polished, modern, and secure development environment with guided setup and one-click configuration.

### What's New in v4.1

| Feature | Description |
|---------|-------------|
| 🎨 **Theme Presets** | 7 built-in color schemes — switch with one key |
| 🛠️ **Dev Tools Installer** | Quick-install Python, Node, Go, Rust, Ruby, PHP, Neovim, tmux |
| 🌐 **Network Info** | View IP, DNS, hostname, and connectivity tests |
| 🧙 **First-Run Wizard** | Guided 4-step setup on first launch |
| 🔄 **Auto-Update Check** | Notifies when new version is available |
| 🖼️ **Multiple Banners** | 3 ASCII art styles to choose from |
| 📝 **MOTD Editor** | Custom boot message for your terminal |
| 🗑️ **Uninstaller** | Clean removal of all QuinxOS components |

---

## All Features

### 🎨 Theme Presets (7 Schemes)
| Theme | Style |
|-------|-------|
| Cyber Midnight | Deep space with neon accents |
| Matrix Green | Classic hacker terminal |
| Solar Flare | Warm dark with orange/gold |
| Arctic Blue | Cool blue and ice tones |
| Purple Haze | Deep purple with magenta |
| Dracacula | Dracula-inspired dark theme |
| Nord | Arctic north-blue clean theme |

### 🛠️ Dev Tools Installer
One-click install for popular development tools:
- **Languages:** Python 3, Node.js, Go, Rust, Ruby, PHP
- **Tools:** Git + SSH, Neovim, tmux
- **Stacks:** All Python (numpy, pandas, flask), All Web (node + php + ruby)

### 🔒 Quinx Shield (Security)
Terminal lock with encrypted access key. Features:
- 3-attempt lockout with session termination
- **Recovery system:** auto-generated recovery key + standalone unlock script
- Recovery options displayed after lockout

### 🌐 Network Info
- Local & public IP addresses
- DNS server
- Hostname
- Connectivity tests (Google DNS, Cloudflare)

### 🧙 First-Run Wizard
Automatically launches on first install. Guides through:
1. Shell selection (Zsh / Bash)
2. Theme selection (7 presets)
3. Banner style (3 options)
4. Display name

### 📊 System Info
View architecture, kernel, uptime, CPU, memory, disk usage, and installed packages.

### 💾 Backup & Restore
Save and restore your complete configuration including theme, banner, and shell config.

### 📝 MOTD Editor
Set a custom Message of the Day, use the default QuinxOS message, or disable it.

### 🔄 Auto-Update Check
Checks GitHub for new versions once per day and notifies you in the menu.

### 🖼️ Banner Styles
Choose from 3 ASCII art banner designs for your boot screen.

### 🗑️ Uninstaller
Clean removal that preserves Oh My Zsh and your shell configs.

---

## Installation

```bash
git clone https://github.com/Shineii86/QuinxOS.git
cd QuinxOS
bash install.sh
```

> **First launch?** The setup wizard will guide you through everything automatically.

---

## Menu Options

| # | Feature | Description |
|---|---------|-------------|
| 01 | Core Setup | Install dependencies, fonts, Oh My Zsh |
| 02 | Zsh Config | Reset Zsh environment |
| 03 | Switch → Zsh | Set Zsh as default shell |
| 04 | Switch → Bash | Set Bash as default shell |
| 05 | Banner Style | Choose from 3 banner designs |
| 06 | Custom Theme | Set shell prompt name |
| 07 | Zsh Plugins | Install syntax highlighting + autosuggestions |
| 08 | Theme Presets | Choose from 7 color schemes |
| 09 | Dev Tools | Install Python, Node, Go, Rust, etc. |
| 10 | System Info | View system details |
| 11 | Network Info | IP, DNS, connectivity tests |
| 12 | MOTD Editor | Custom boot message |
| 13 | Backup/Restore | Save or load configurations |
| 14 | Quinx Shield | Activate terminal lock |
| 15 | Remove Lock | Deactivate Quinx Shield |
| 16 | Update | Pull latest QuinxOS version |
| 17 | Uninstall | Remove QuinxOS completely |

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
