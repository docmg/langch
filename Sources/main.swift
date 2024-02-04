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

struct ListLayouts: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "ls",
      abstract: "List all layout IDs"
    )

    func run() {
        let layoutIDs = getInputSources().map { $0.id }
        print(layoutIDs.joined(separator: "\n"))
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
            print("Error: Unable to determine the current layout.")
            throw ExitCode.failure
        }

        print(currentLayout.id)
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

    func run() throws {
        let inputSources = getInputSources()

        guard let targetLayout = inputSources.first(where: { $0.id == layoutID }) else {
            print("Error: Layout with ID \(layoutID) not found.")
            throw ExitCode.failure
        }

        if targetLayout.isSelected && !force {
            print("Error: Layout \(targetLayout.id) is already selected. Use --force to override.")
            throw ExitCode.failure
        }

        if targetLayout.select() {
            print("Layout switched to: \(targetLayout.id)")
        } else {
            print("Error: Failed to change layout.")
            throw ExitCode.failure
        }
    }
}


struct PrevLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "prev",
        abstract: "Switch to the previous layout"
    )

    func run() {
        let allLayouts = getInputSources()

        guard let currentIndex = allLayouts.firstIndex(where: { $0.isSelected }) else {
            print("Error: Unable to determine the current layout.")
            return
        }

        let previousIndex = (currentIndex - 1 + allLayouts.count) % allLayouts.count
        let previousLayout = allLayouts[previousIndex]

        if previousLayout.select() {
            print("Switched to the previous layout: \(previousLayout.id)")
        } else {
            print("Error: Failed to switch to the previous layout.")
        }
    }
}

struct NextLayout: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "next",
        abstract: "Switch to the next layout"
    )

    func run() {
        let allLayouts = getInputSources()

        guard let currentIndex = allLayouts.firstIndex(where: { $0.isSelected }) else {
            print("Error: Unable to determine the current layout.")
            return
        }

        let nextIndex = (currentIndex + 1) % allLayouts.count
        let nextLayout = allLayouts[nextIndex]

        if nextLayout.select() {
            print("Switched to the next layout: \(nextLayout.id)")
        } else {
            print("Error: Failed to switch to the next layout.")
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
