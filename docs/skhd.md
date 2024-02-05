# Langch Integration with skhd

> skhd is a simple hotkey daemon for macOS that focuses on responsiveness and performance.  

[https://github.com/koekeishiya/skhd](https://github.com/koekeishiya/skhd). 

Check example configuration in [../examples/skhd](../examples/skhd)

## Prerequisites

To use custom keybindings for layouts, you need to disable system default shortcuts. In `System Preferences > Keyboard`, change the Option `Press the Glob key to` to `do nothing` and disable the shortcuts in `Keyboard Shortcuts > Input Sources`.

## Examples

### A – Change Layouts Directly

```sh
fn - 1 : langch ch --force com.apple.keylayout.US
fn - 2 : langch ch --force com.apple.keylayout.German
fn - 3 : langch ch --force com.apple.keylayout.Ukrainian-PC
fn - 4 : langch ch --force com.apple.keylayout.Russian
```

#### Description:
Pressing **fn** + **1** switches to the US keyboard layout.  
Pressing **fn** + **2** switches to the German keyboard layout.  
Pressing **fn** + **3** switches to the Ukrainian-PC keyboard layout.  
Pressing **fn** + **4** switches to the Russian keyboard layout.  

### B – Switch to Next Layout
```sh
fn - space : langch next
```

#### Description:
Pressing **fn** + **space** switches to the next layout in the list.  
Note: It works faster than the system default.
