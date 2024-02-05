import ArgumentParser
import InputMethodKit

func getInputSources() -> [TISInputSource] {
    guard let inputSourceNSArray = TISCreateInputSourceList(nil, false)?.takeRetainedValue() as? [TISInputSource] else {
        return []
    }

    let keyboardInputSources = inputSourceNSArray.filter { $0.isKeyboardInputSource }
    let selectableInputSources = keyboardInputSources.filter { $0.isSelectable }

    return selectableInputSources
}

func printMessage(_ message: String, silent: Bool = false) {
    if !silent {
        print(message)
    }
}

struct ListLayouts: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "ls",
      abstract: "List all layout IDs"
    )

    func run() {
        let layoutIDs = getInputSources().map { $0.id }
        printMessage(layoutIDs.joined(separator: "\n"))
    }
}

struct CurrentLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "current",
        abstract: "Print the ID of the currently selected layout"
    )

    func run() throws {
        let inputSources = getInputSources()

        guard let currentLayout = inputSources.first(where: { $0.isSelected }) else {
            printMessage("Error: Unable to determine the current layout.")
            throw ExitCode.failure
        }

        printMessage(currentLayout.id)
    }
}

struct ChangeLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "ch",
      abstract: "Change to the specified layout"
    )

    @Argument(help: "Layout ID to change to")
    var layoutID: String

    @Flag(name: .shortAndLong, help: "Force change the layout even if it's already selected")
    var force: Bool = false

    @Flag(name: .shortAndLong, help: "Suppress output messages")
    var silent: Bool = false

    func run() throws {
        let inputSources = getInputSources()

        guard let targetLayout = inputSources.first(where: { $0.id == layoutID }) else {
            printMessage("Error: Layout with ID \(layoutID) not found.", silent: silent)
            throw ExitCode.failure
        }

        if targetLayout.isSelected && !force {
            printMessage("Error: Layout \(targetLayout.id) is already selected. Use --force to override.", silent: silent)
            throw ExitCode.failure
        }

        if targetLayout.select() {
            printMessage("Layout switched to: \(targetLayout.id)", silent: silent)
        } else {
            printMessage("Error: Failed to change layout.", silent: silent)
            throw ExitCode.failure
        }
    }
}


struct PrevLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "prev",
        abstract: "Switch to the previous layout"
    )

    @Flag(name: .shortAndLong, help: "Suppress output messages")
    var silent: Bool = false

    func run() {
        let inputSources = getInputSources()

        guard let currentIndex = inputSources.firstIndex(where: { $0.isSelected }) else {
            printMessage("Error: Unable to determine the current layout.", silent: silent)
            return
        }

        let previousIndex = (currentIndex - 1 + inputSources.count) % inputSources.count
        let previousLayout = inputSources[previousIndex]

        if previousLayout.select() {
            printMessage("Switched to the previous layout: \(previousLayout.id)", silent: silent)
        } else {
            printMessage("Error: Failed to switch to the previous layout.", silent: silent)
        }
    }
}

struct NextLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "next",
        abstract: "Switch to the next layout"
    )

    @Flag(name: .shortAndLong, help: "Suppress output messages")
    var silent: Bool = false

    func run() {
        let inputSources = getInputSources()

        guard let currentIndex = inputSources.firstIndex(where: { $0.isSelected }) else {
            printMessage("Error: Unable to determine the current layout.", silent: silent)
            return
        }

        let nextIndex = (currentIndex + 1) % inputSources.count
        let nextLayout = inputSources[nextIndex]

        if nextLayout.select() {
            printMessage("Switched to the next layout: \(nextLayout.id)", silent: silent)
        } else {
            printMessage("Error: Failed to switch to the next layout.", silent: silent)
        }
    }
}

struct Langch: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "langch",
        abstract: "Langch is a command-line tool to change keyboard layouts on macOS.",
        subcommands: [ListLayouts.self, ChangeLayout.self, PrevLayout.self, NextLayout.self, CurrentLayout.self]
    )
}

Langch.main()
