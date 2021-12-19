import AdventKit
import Algorithms
import Foundation

public class Puzzle {
    let solved: [Cube]
    public init(input: String) {
        let unsolved = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .reduce(into: []) {
                $0.append(Cube($1))
            }
        solved = Puzzle.solveScanners(cubes: unsolved)
    }

    static func solveScanners(cubes: [Cube]) -> [Cube] {
        var cubesPlaced = [cubes[0]]
        var cubesLeft = Set(cubes.dropFirst())

        while !cubesLeft.isEmpty {
            outerloop: for cubeToTry in cubesLeft {
                for placedCube in cubesPlaced {
                    // this set can be easily used to intersect with a rotated trycube
                    // translate it back to .zero first. We'll reconstruct the position later
                    let placedBeaconSet = Set(placedCube.translated(by: placedCube.scanner.inverted).beacons)

                    // try all rotations
                    for i in 0 ..< 24 {
                        let cube = cubeToTry.at(rotation: i)
                        for placedBeacon in placedBeaconSet {
                            for beacon in cube.beacons {
                                let diff = beacon.difference(to: placedBeacon)
                                let translated = cube.translated(by: diff)
                                let translatedBeacons = Set(translated.beacons)
                                let intersection = placedBeaconSet.intersection(translatedBeacons)
                                if intersection.count >= 12 {
                                    print("Found #\(cubeToTry.id) at rotation \(i) with diff \(diff)")
                                    // translate by the position of the scanner of the placed cube
                                    cubesPlaced.append(translated.translated(by: placedCube.scanner))
                                    cubesLeft.remove(cubeToTry)
                                    break outerloop
                                }
                            }
                        }
                    }
                }
            }
        }
        return cubesPlaced
    }

    public func part1() -> Int {
        Set(solved.flatMap { $0.beacons }).count
    }

    public func part2() -> Int {
        solved
            .combinations(ofCount: 2)
            .reduce(Int.min) {
                max($0, $1[0].scanner.manhatton(to: $1[1].scanner))
            }
    }
}
