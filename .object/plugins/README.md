# QuinxOS Plugins

## How Plugins Work

Drop any `.sh` file into this directory. QuinxOS will auto-load it on terminal start.

## Creating a Plugin

1. Create a `.sh` file in this directory
2. Define your functions with `quinx-` prefix
3. They'll be available as commands in your terminal

### Example Plugin

```bash
#!/bin/bash
quinx-hello() {
    echo "Hello from QuinxOS!"
}
```

Save as `hello.sh` and restart your terminal. Now `quinx-hello` works!

## Built-in Plugins (14)

| Plugin | Commands | Description |
|--------|----------|-------------|
| `weather.sh` | `quinx-weather <city>` | Weather info |
| `extract.sh` | `quinx-extract <file>` | Universal archive extractor |
| `ports.sh` | `quinx-ports [host]` | Quick port scanner |
| `calc.sh` | `quinx-calc 'expr'` | Math calculator |
| `qrcode.sh` | `quinx-qr 'text'` | QR code generator |
| `timer.sh` | `quinx-timer <secs>`, `quinx-stopwatch` | Timer + stopwatch |
| `password.sh` | `quinx-pass [len]`, `quinx-passphrase [words]` | Password generator |
| `notes.sh` | `quinx-note add/list/search/clear` | Quick notes |
| `colorinfo.sh` | `quinx-color '#hex'` | Color converter with preview |
| `sysreport.sh` | `quinx-report` | Full system report to file |
| `dict.sh` | `quinx-define <word>` | Dictionary lookup |
| `github.sh` | `quinx-ghstats`, `quinx-ghnotifs`, `quinx-ghstreak`, `quinx-ghrepo` | GitHub integration |
| `matrix.sh` | `quinx-matrix [secs]` | Matrix rain animation |
| `anime.sh` | `quinx-anime-quote`, `quinx-waifu`, `quinx-anime-art`, `quinx-funfact` | Anime features |

## Naming Convention

- Prefix your functions with `quinx-` for easy discovery
- Use `quinx-` prefix to avoid conflicts with system commands

## Sharing

Share your plugins with the community:
https://github.com/Shineii86/QuinxOS/discussions
