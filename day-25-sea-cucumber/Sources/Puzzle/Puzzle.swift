import AdventKit
import Foundation

public class Puzzle {
    let map: [Point: Character]
    let width: Int
    let height: Int

    public init(input: String) {
        let lines = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        var _map = [Point: Character]()
        for row in lines.enumerated() {
            for column in row.element.enumerated() {
                _map[Point(x: column.offset, y: row.offset)] = column.element
            }
        }
        map = _map
        height = lines.count
        width = lines[0].count
    }

    public func part1() -> Int {
        var _map = map
        for i in 1... {
            let r = moveRight(state: _map)
            _map = r.0
            let d = moveDown(state: _map)
            _map = d.0
            if r.1 == 0, d.1 == 0 {
                return i
            }
        }
        return -1
    }

    func moveRight(state: [Point: Character]) -> ([Point: Character], Int) {
        var newState = state
        var changed = 0
        for y in 0..<height {
            for x in 0..<width {
                let c = Point(x: x, y: y)
                let r = Point(x: (x + 1) % width, y: y)
                if state[c] == ">", state[r] == "." {
                    newState[c] = "."
                    newState[r] = ">"
                    changed += 1
                }
            }
        }

        return (newState, changed)
    }

    func moveDown(state: [Point: Character]) -> ([Point: Character], Int) {
        var newState = state
        var changed = 0
        for y in 0..<height {
            for x in 0..<width {
                let c = Point(x: x, y: y)
                let d = Point(x: x, y: (y + 1) % height)
                if state[c] == "v", state[d] == "." {
                    newState[c] = "."
                    newState[d] = "v"
                    changed += 1
                }
            }
        }

        return (newState, changed)
    }
}
