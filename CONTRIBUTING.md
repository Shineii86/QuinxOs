# 🤝 Contributing to QuinxOS

Thank you for your interest in contributing to **QuinxOS**! Every contribution matters — whether it's a new theme, a plugin, a bug fix, or a typo correction.

---

## 📑 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [Getting Started](#-getting-started)
- [How to Contribute](#-how-to-contribute)
- [Adding a Theme](#-adding-a-theme)
- [Adding a Plugin](#-adding-a-plugin)
- [Reporting Bugs](#-reporting-bugs)
- [Suggesting Features](#-suggesting-features)
- [Pull Request Process](#-pull-request-process)
- [Style Guidelines](#-style-guidelines)
- [Community](#-community)

---

## 📜 Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment. Be kind, constructive, and welcoming to everyone.

---

## 🚀 Getting Started

1. **Fork** the repository
2. **Clone** your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/QuinxOS.git
   cd QuinxOS
   ```
3. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes** and test them
5. **Commit and push**:
   ```bash
   git add .
   git commit -m "feat: describe your change"
   git push origin feature/your-feature-name
   ```
6. **Open a Pull Request** on GitHub

---

## 🎨 How to Contribute

### Adding a Theme

Themes are stored in `.object/themes/` as `.colors` files.

1. Create a new file: `.object/themes/your-theme-name.colors`
2. Follow the existing theme format:
   ```bash
   # Theme: Your Theme Name
   # Vibe: Short description

   BG_COLOR="#1a1b26"
   FG_COLOR="#c0caf5"
   ACCENT_COLOR="#7aa2f7"
   PROMPT_COLOR="#9ece6a"
   ERROR_COLOR="#f7768e"
   # ... (see existing themes for full format)
   ```
3. Test it by selecting your theme in QuinxOS → Theme Gallery
4. Submit a PR with a screenshot or description of the theme

**Theme Ideas:**
- Anime-inspired themes (character color palettes)
- Nature-inspired (ocean, forest, sunset)
- Editor-inspired (VS Code, Vim, Sublime)
- Retro/vintage aesthetics
- Minimalist monochrome

---

### Adding a Plugin

Plugins are stored in `.object/plugins/` as `.sh` files.

1. Create a new file: `.object/plugins/your-plugin.sh`
2. Follow this template:
   ```bash
   #!/bin/bash
   # Plugin: Your Plugin Name
   # Description: What your plugin does
   # Author: Your Name

   quinx-yourcommand() {
       # Your implementation here
       echo "Hello from your plugin!"
   }
   ```
3. **Plugin guidelines:**
   - Function name must start with `quinx-`
   - Keep it self-contained (no external dependencies unless necessary)
   - Handle errors gracefully
   - Include a help message (`quinx-yourcommand --help`)
   - Add comments explaining complex logic
4. Test by restarting your terminal and running the command
5. Submit a PR

---

### Reporting Bugs

Found a bug? Help us fix it!

1. Check [existing issues](https://github.com/Shineii86/QuinxOS/issues) to avoid duplicates
2. Open a new issue with:
   - **Title:** Clear, concise description
   - **Steps to reproduce** — what you did
   - **Expected behavior** — what should happen
   - **Actual behavior** — what actually happened
   - **Environment** — Termux version, Android version, device
   - **Screenshots** — if applicable

---

### Suggesting Features

Have an idea? We'd love to hear it!

1. Check [existing issues](https://github.com/Shineii86/QuinxOS/issues) for similar ideas
2. Open a feature request with:
   - **Problem** — what problem does this solve?
   - **Solution** — your proposed idea
   - **Alternatives** — any other approaches you considered
   - **Additional context** — mockups, examples, references

---

## 🔄 Pull Request Process

1. **Update documentation** — if your change affects usage, update README.md
2. **Test thoroughly** — make sure nothing breaks
3. **Write a clear commit message**:
   ```
   feat: add sunset theme          # new feature
   fix: resolve header display bug  # bug fix
   docs: update plugin guide        # documentation
   style: format install script     # code style
   refactor: simplify theme loader  # refactoring
   ```
4. **Keep PRs focused** — one feature/fix per PR
5. **Be responsive** to review feedback

### Commit Message Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

| Prefix | Use For |
|:-------|:--------|
| `feat:` | New features |
| `fix:` | Bug fixes |
| `docs:` | Documentation changes |
| `style:` | Code style (formatting, no logic change) |
| `refactor:` | Code refactoring |
| `perf:` | Performance improvements |
| `test:` | Adding or updating tests |
| `chore:` | Maintenance tasks |

---

## ✏️ Style Guidelines

### Bash Scripts

- Use **4 spaces** for indentation (no tabs)
- Quote all variables: `"$variable"` not `$variable`
- Use `[[ ]]` for conditionals (not `[ ]`)
- Add comments for non-obvious logic
- Use functions for reusable code
- Handle errors with `|| { echo "error"; exit 1; }`
- Keep functions small and focused

### Documentation

- Use clear, concise language
- Include code examples where helpful
- Keep line length under 120 characters
- Use proper Markdown formatting

---

## 🌐 Community

- **Issues:** [GitHub Issues](https://github.com/Shineii86/QuinxOS/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Shineii86/QuinxOS/discussions)
- **Author:** [Shineii86](https://github.com/Shineii86)

---

## 🙏 Thank You

Your contributions make QuinxOS better for everyone. Whether it's a one-line fix or a major feature — we appreciate your time and effort!

<div align="center">

**[⬆ Back to Top](#-contributing-to-quinxos)**

</div>
