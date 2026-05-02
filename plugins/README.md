# 🧩 QuinxOS Plugin API

Create your own plugins for QuinxOS! Drop a `.sh` file in `.object/plugins/` and it auto-loads on terminal start.

---

## Quick Start

```bash
# .object/plugins/my-plugin.sh
#!/bin/bash
# Plugin: My Plugin
# Description: Does something awesome
# Author: Your Name

quinx-mycommand() {
    echo "Hello from my plugin!"
}
```

Restart your terminal → `quinx-mycommand` works immediately.

---

## Naming Convention

- **File:** `my-plugin.sh` (kebab-case)
- **Function:** `quinx-mycommand()` (must start with `quinx-`)
- **Help:** Support `quinx-mycommand --help` or `quinx-mycommand -h`

---

## Available Environment

Your plugin runs inside the QuinxOS shell environment. These variables are available:

| Variable | Description |
|:---------|:------------|
| `$QUINX_HOME` | QuinxOS install directory (`~/QuinxOS`) |
| `$QUINX_VERSION` | Current QuinxOS version |
| `$QUINX_THEMES` | Themes directory path |
| `$QUINX_PLUGINS` | Plugins directory path |

### Helper Functions

These functions are available from the core install script:

| Function | Description |
|:---------|:-------------|
| `print_line "text" "$COLOR"` | Print a centered line in a box |
| `draw_top` / `draw_bot` / `draw_sep` | Draw box borders |
| `show_banner` | Display the QuinxOS banner |

---

## Best Practices

1. **Self-contained** — avoid external dependencies unless necessary
2. **Error handling** — use `|| { echo "error"; return 1; }`
3. **Help message** — respond to `--help` with usage info
4. **Colored output** — use ANSI codes for consistency:
   ```bash
   R='\033[1;31m'; G='\033[1;32m'; C='\033[1;96m'; RS='\033[0m'
   ```
5. **Keep it fast** — plugins load on every terminal start
6. **Comments** — header comment with plugin name, description, author

---

## Example: QR Code Plugin

```bash
#!/bin/bash
# Plugin: QR Code
# Description: Generate QR codes from text
# Author: Shineii86

quinx-qr() {
    if [ -z "$1" ]; then
        echo "Usage: quinx-qr <text>"
        return 1
    fi
    echo "$1" | curl -s -o - "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$1" > /tmp/qr.png
    echo "QR code saved to /tmp/qr.png"
}
```

---

## Submitting a Plugin

1. Create your plugin in `.object/plugins/`
2. Test it by restarting your terminal
3. Submit a Pull Request with:
   - The plugin file
   - A description of what it does
   - Example usage

See [CONTRIBUTING.md](../CONTRIBUTING.md) for full guidelines.

---

<div align="center">

**[⬆ Back to QuinxOS](../README.md)**

</div>
