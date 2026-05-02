# QuinxOS Plugins

## How Plugins Work

Drop any `.sh` file into this directory. QuinxOS will auto-load it on terminal start.

## Creating a Plugin

1. Create a `.sh` file in this directory
2. Define your functions
3. They'll be available as commands in your terminal

### Example Plugin

```bash
#!/bin/bash
# My custom command

quinx-hello() {
    echo "Hello from QuinxOS!"
}
```

Save as `hello.sh` and restart your terminal. Now `quinx-hello` works!

## Naming Convention

- Prefix your functions with `quinx-` for easy discovery
- Use `quinx-` prefix to avoid conflicts with system commands

## Built-in Plugins

- `weather.sh` — `quinx-weather <city>` for weather info
- `extract.sh` — `quinx-extract <file>` universal archive extractor
- `ports.sh` — `quinx-ports [host]` quick port scanner

## Sharing

Share your plugins with the community:
https://github.com/Shineii86/QuinxOS/discussions
