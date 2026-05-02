# 📋 Changelog

All notable changes to **QuinxOS** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [6.0] — 2026-05-02

### 🎨 Added
- **Anime Theme Gallery** — 6 new anime-inspired color schemes (Evangelion, Attack on Titan, Naruto, Dragon Ball, Demon Slayer, One Piece)
- **Anime ASCII Art** — Anime character ASCII banners with random display on terminal start
- **Anime Quotes** — Motivational anime quotes shown on each new terminal session
- **Fun Facts** — Random fun facts displayed alongside daily quotes
- **GitHub Integration Plugin** (`quinx-ghstats`) — GitHub stats, notifications, streaks, repos
- **Matrix Rain Plugin** (`quinx-matrix`) — Matrix-style terminal animation
- **Anime Plugin** (`quinx-anime-quote`, `quinx-waifu`, `quinx-anime-art`) — Anime content
- **System Tweaks** — Performance optimizations and developer-friendly shell defaults
- GitHub Pages documentation site
- Custom SVG banner with gradient effects
- Terminal screenshots for README
- CHANGELOG.md, CONTRIBUTING.md, .gitignore
- GitHub issue/PR templates, ShellCheck CI workflow
- Plugin API documentation (plugins/README.md)
- Star history badge in README

### 🔄 Changed
- Replaced all box-drawing ASCII art (╔╗╚╝║═) with ASCII-safe characters (+-|) for universal terminal compatibility
- Rebuilt all SVG screenshots to use rect-based rendering (no overlapping characters)
- README updated with accurate theme list (22 themes), plugin list (14 plugins), and feature table
- docs/index.html updated with correct stats, OG meta tags, and favicon
- Menu options expanded from 34 to **38**
- Theme count: 22 (16 classic + 6 anime)
- Plugin count: 14
- Banner styles: 5 (all ASCII-safe)
- Menu options expanded from 34 to **38**
- Theme count increased from 15 to **22**
- Plugin count increased from 11 to **14**
- Updated README with accurate stats, anime features, and docs link
- Improved project documentation structure

---

## [5.0] — 2026-05-02

### 🖥️ Added
- **Live Dashboard** — Full-screen real-time system monitor (CPU, RAM, battery, network, processes)
- **Fingerprint Lock** — Biometric authentication via Termux API
- **Command Palette** — Fuzzy-search across all features, aliases, and plugins
- **Dotfiles Sync** — Push/pull configs to/from a private GitHub repo
- **Theme Builder** — Interactive color picker with live preview
- **Profile System** — Multiple profiles (Work, Personal, Hacking) with separate configs
- **Git Dashboard** — Full repo info (branch, commits, changes, stashes, tags)
- **Termux API Hooks** — Battery status, GPS location, clipboard, torch, vibration
- **QuinxBench** — System benchmark (CPU, disk, network speed scoring)
- **Startup Timer** — Measure shell load time
- **Color Export** — Export themes to Windows Terminal, iTerm2, Alacritty, Kitty
- **8 New Plugins** — Calculator, QR code, timer, password gen, notes, color info, dictionary, system report
- Professional README with badges, tables, and feature gallery

### 🔄 Changed
- Menu options expanded from 25 to **34**
- Plugin count increased from 3 to **11**
- Major install script improvements

---

## [4.2] — 2026-05-02

### 🎨 Added
- 15 handcrafted color themes (Cyber Midnight, Matrix Green, Solar Flare, Arctic Blue, etc.)
- Plugin system with auto-loading from `.object/plugins/`
- 3 built-in plugins (Weather, Extract, Ports)
- Theme gallery with preview

### 🔄 Changed
- 10 major upgrades to core functionality
- Expanded menu from 17 to 25 options

---

## [4.1] — 2026-05-02

### 🔄 Changed
- 8 major upgrades to existing features
- Improved shell configuration
- Better alias management

---

## [4.0] — 2026-05-02

### 🎨 Added
- Complete UI redesign
- Quinx Shield — encrypted terminal lock with 3-attempt lockout
- Recovery key system
- Standalone `quinx-unlock` script
- Persistent header with system status
- Custom banner styles (3 options)
- Login sound support

### 🔄 Changed
- Complete rewrite of install script
- New modular architecture

---

## [3.0] — 2026-05-02

### 🎨 Added
- Zsh and Bash dual shell support
- Quick commands menu
- Dev tools installer
- SSH keygen integration
- Process monitor

---

## [2.0] — 2026-05-02

### 🎨 Added
- Basic theme customization
- Alias manager
- System info display
- Network info display

---

## [1.0] — 2026-05-02

### 🎨 Added
- Initial release
- Core Termux setup and optimization
- Basic shell configuration
- Install script

---

<div align="center">

**[⬆ Back to Top](#-changelog)**

<sub>For full details, see the [commit history](https://github.com/Shineii86/QuinxOS/commits/main)</sub>

</div>
