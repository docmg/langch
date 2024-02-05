# Langch Integration with Raycast

> Raycast is a blazingly fast, totally extendable launcher.

[https://www.raycast.com/](https://www.raycast.com/)

Langch seamlessly integrates with Raycast, providing a convenient way to manage keyboard layouts using Raycast commands.

## Prerequisites

To use custom keybindings for layouts, you need to disable system default shortcuts. In `System Preferences > Keyboard`, change the Option `Press the Glob key to` to `do nothing` and disable the shortcuts in `Keyboard Shortcuts > Input Sources`.

## Create scripts 
1. Open your preferred text editor.

2. Create a new file for each layout script, for example:
   - `langch-us.sh` for the US keyboard layout.
   - `langch-de.sh` for the German keyboard layout.
   - `langch-uk.sh` for the Ukrainian keyboard layout.
   - `langch-ru.sh` for the Russian keyboard layout.

3. In each script file, add the following command:
   ```sh
    #!/bin/bash

    # Required parameters:
    # @raycast.schemaVersion 1
    # @raycast.title Layout US
    # @raycast.mode silent

    # Optional parameters:
    # @raycast.icon 🤖

    langch ch --force --silent <layoutID> # Replace <layoutID> with the desired keyboard layout ID
   ```

4. Save each script file.

5. Make the scripts executable using `chmod +x`.

Check examples in [../examples/raycast](../examples/raycast)

## Setting Up Langch Commands in Raycast

1. Open Raycast Preferences.
2. Navigate to the "Extensions" tab.
3. Click on the "+" button and select "Add script Directory."
4. Choose the directory where you saved your Langch scripts.
5. Now, you can use Raycast to easily switch between layouts by executing your custom scripts.

Adjust the keybindings according to your preferences.

## Result

![Screenshot of imported scripts in Raycast settings](/docs/images/raycast.png)