import AdventKit
import Foundation

struct Cave {
    var name: String
    var isBig: Bool

    init(_ name: String) {
        self.name = name
        self.isBig = name == name.uppercased()
    }
}

extension Cave: Hashable {}

class CaveNode {
    var cave: Cave
    var parent: CaveNode?
    var children: [CaveNode]

    var isEnd: Bool

    init(_ cave: Cave) {
        self.cave = cave
        self.isEnd = cave.name == "end"
        self.children = []
    }

    func addChild(caveNode: CaveNode) {
        caveNode.parent = self
        children.append(caveNode)
    }

    func pathContains(cave: Cave) -> Bool {
        self.cave == cave || (parent?.pathContains(cave: cave) ?? false)
    }

    func pathContainsDoubleVisitedSmallCaves() -> Bool {
        return pathContainsDoubleVisitedSmallCaves(set: Set<Cave>())
    }

    private func pathContainsDoubleVisitedSmallCaves(set: Set<Cave>) -> Bool {
        var _set = set
        if !_set.insert(cave).inserted, !cave.isBig {
            return true
        } else if let parent = parent {
            return parent.pathContainsDoubleVisitedSmallCaves(set: _set)
        } else {
            return false
        }
    }
}

public class Puzzle {
    let map: [Cave: [Cave]]

    public init(input: String) {
        self.map = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [Cave: [Cave]]()) { dict, line in
                let caves = line.components(separatedBy: "-").map(Cave.init)
                if caves[0].name == "start" {
                    dict[caves[0], default: []].append(caves[1])
                } else if caves[1].name == "start" {
                    dict[caves[1], default: []].append(caves[0])
                } else if caves[0].name == "end" {
                    dict[caves[1], default: []].append(caves[0])
                } else if caves[1].name == "end" {
                    dict[caves[0], default: []].append(caves[1])
                } else {
                    dict[caves[0], default: []].append(caves[1])
                    dict[caves[1], default: []].append(caves[0])
                }
            }
    }

    var paths = 0
    func traverse(current: CaveNode) {
        if current.isEnd {
            paths += 1
        } else {
            map[current.cave]!
                .lazy
                .filter { cave in
                    cave.isBig
                        || !current.pathContains(cave: cave)
                }
                .forEach { cave in
                    let node = CaveNode(cave)
                    current.addChild(caveNode: node)
                    traverse(current: node)
                }
        }
    }

    public func part1() -> Int {
        traverse(current: CaveNode(Cave("start")))
        return paths
    }

    var paths2 = 0
    func traverse2(current: CaveNode, hasDouble: Bool) {
        let canAddDouble = !hasDouble && !current.pathContainsDoubleVisitedSmallCaves()
        if current.isEnd {
            paths2 += 1
        } else {
            map[current.cave]!
                .lazy
                .filter { cave in
                    cave.isBig
                        || !current.pathContains(cave: cave)
                        || canAddDouble
                }
                .forEach { cave in
                    let node = CaveNode(cave)
                    current.addChild(caveNode: node)
                    traverse2(current: node, hasDouble: !canAddDouble)
                }
        }
    }

    public func part2() -> Int {
        traverse2(current: CaveNode(Cave("start")), hasDouble: false)
        return paths2
    }
}
