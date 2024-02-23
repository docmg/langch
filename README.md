# Langch

Langch is a command-line tool designed to simplify the process of changing keyboard layouts on macOS using shell. It provides a convenient interface to list available layouts, change to a specific layout or circle trough.

![Demonstration](/docs/images/demo.gif)

## Features

- List all selectable keyboard layouts on your macOS system.
- Change to the next, previous, or a specific keyboard layout with a simple command.

## Install

Langch can be easily installed and used as follows:

```
# Clone the repository
git clone https://github.com/docmg/langch.git

# Build the executable
cd langch
make build

# Create use specific bin directory and move langch into``
sudo mkdir -p /usr/local/bin
sudo mv ./langch /usr/local/bin/langch
```

## Usage

List available layouts
```
langch ls
```

Print current layout id
```
langch current
```

Change layout
```
langch ch <layoutID>
```

Switch to next layout
```
langch next
```

Switch to previous layout
```
langch prev
```

## Examples
Langch is designed to make it possible to bind layouts directly to specific keys.
For example, binding the US layout to **fn** + **1**, German to **fn** + **2** and so on...

Example configurations:
[skhd](/docs/skhd.md), [raycast](/docs/raycast.md)

## Uninstall
Simply remove langch executable.
```
sudo rm /usr/local/bin/langch
```

## Contribution
Feel free to contribute by opening issues or submitting pull requests.

## Todo
- [x] Add --silent flag for ch, next, prev
- [x] Add --readable flag for ch, next, prev
- [ ] Add brew formula

## License
[MIT](LICENSE)
