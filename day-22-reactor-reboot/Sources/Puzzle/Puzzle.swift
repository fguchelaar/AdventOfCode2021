import AdventKit
import Foundation

struct Instruction {
    let cube: Cube
    let turnOn: Bool
}

enum Action {
    case add
    case ignore
    case subtract
}

public class Puzzle {
    let instructions: [Instruction]
    public init(input: String) {
        self.instructions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let turnOn = line.starts(with: "on")
                let ints = line
                    .matches(pattern: #"-?\d+"#)
                    .compactMap(Int.init)
                let cube = Cube(ints[0], ints[1], ints[2], ints[3], ints[4], ints[5])
                return Instruction(cube: cube, turnOn: turnOn)
            }
    }

    public func part1() -> Int {
        var placedCubes = [Cube: Int]()
        for instruction in instructions {
            guard let cube = instruction.cube.constrained(to: Cube(-50, 50, -50, 50, -50, 50)) else {
                continue
            }

            for (other, count) in placedCubes {
                if let intersection = cube.intersection(with: other) {
                    let a = placedCubes[intersection, default: 0]
                    placedCubes[intersection, default: 0] -= count
                    print("a: \(a); b: \(count); c: \(placedCubes[intersection, default: 0])")
                }
            }

            if instruction.turnOn {
                placedCubes[cube, default: 0] += 1
            }
        }
        return placedCubes.reduce(0) { $0 + ($1.value * $1.key.volume) }
    }

    public func part2() -> Int {
        var placedCubes = [Cube: Int]()
        for instruction in instructions {
            let cube = instruction.cube

            for (other, count) in placedCubes {
                if let intersection = cube.intersection(with: other) {
                    placedCubes[intersection, default: 0] -= count
                }
            }

            if instruction.turnOn {
                placedCubes[cube, default: 0] += 1
            }
        }
        return placedCubes.reduce(0) { $0 + ($1.value * $1.key.volume) }
    }
}
