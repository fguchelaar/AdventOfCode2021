//
//  Cube.swift
//
//
//  Created by Frank Guchelaar on 19/12/2021.
//

import Foundation

struct Cube {
    let id: Int
    let scanner: Position
    let beacons: [Position]

    private init(_ id: Int, _ scanner: Position, _ beacons: [Position]) {
        self.id = id
        self.scanner = scanner
        self.beacons = beacons
    }

    init(_ string: String) {
        let lines = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        let firstLine = lines
            .first!
            .trimmingCharacters(in: .punctuationCharacters
                .union(.letters)
                .union(.whitespacesAndNewlines))

        id = Int(firstLine)!
        scanner = Position.zero
        beacons = lines.dropFirst().reduce(into: []) {
            $0.append(Position($1))
        }
    }

    func at(rotation: Int) -> Cube {
        let rotatedBeacons = beacons.map {
            $0.allRotations[rotation]
        }
        return Cube(id, scanner, rotatedBeacons)
    }

    func translated(by position: Position) -> Cube {
        let translatedBeacons = beacons.map {
            $0.translate(by: position)
        }
        return Cube(id, scanner.translate(by: position), translatedBeacons)
    }
}

extension Cube: Hashable {}

extension Cube: CustomStringConvertible {
    var description: String {
        "id: \(id)\n\tscanner: \(scanner)\n\tbeacons: \(beacons.sorted(by: { $0.manhatton(to: scanner) < $1.manhatton(to: scanner) }))"
    }
}
