import AdventKit
import Foundation

public class Puzzle {
    let map: [String: [String]]
    public init(input: String) {
        self.map = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [String: [String]]()) { dict, line in
                let caves = line.components(separatedBy: "-")
                if caves[0] == "start" {
                    dict["start", default: []].append(caves[1])
                } else if caves[1] == "start" {
                    dict["start", default: []].append(caves[0])
                } else if caves[0] == "end" {
                    dict[caves[1], default: []].append("end")
                } else if caves[1] == "end" {
                    dict[caves[0], default: []].append("end")
                } else {
                    dict[caves[0], default: []].append(caves[1])
                    dict[caves[1], default: []].append(caves[0])
                }
            }
    }

    var paths = 0
    func traverse(current: String, visited: [String]) {
        var _visited = visited
        _visited.append(current)

        if current == "end" {
            paths += 1
        } else {
            let neighbors = map[current]!.filter { cave in
                String.isUppercase(string: cave)
                    || !_visited.contains(cave)
            }
            for n in neighbors {
                traverse(current: n, visited: _visited)
            }
        }
    }

    public func part1() -> Int {
        traverse(current: "start", visited: [])
        return paths
    }

    func hasDoubleVistedLowercaseCaves(path: [String]) -> Bool {
        var v = Set<String>()
        for cave in path.filter({ String.isLowercase(string: $0) }) {
            if !v.insert(cave).inserted {
                return true
            }
        }
        return false
    }

    var paths2 = 0
    func traverse2(current: String, visited: [String], hasDouble: Bool) {
        var _visited = visited
        _visited.append(current)
        let canAddDouble = !hasDouble && !hasDoubleVistedLowercaseCaves(path: _visited)
        if current == "end" {
            paths2 += 1
        } else {
            map[current]!
                .lazy
                .filter { cave in
                    String.isUppercase(string: cave)
                        || !_visited.contains(cave)
                        || canAddDouble
                }
                .forEach { n in
                    traverse2(current: n, visited: _visited, hasDouble: !canAddDouble)
                }
        }
    }

    public func part2() -> Int {
        traverse2(current: "start", visited: [], hasDouble: false)
        return paths2
    }
}
