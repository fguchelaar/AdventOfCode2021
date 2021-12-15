import AdventKit
import Collections
import Foundation

extension Point {
    func n4() -> [Point] {
        [Point(x: x, y: y - 1),
         Point(x: x + 1, y: y),
         Point(x: x, y: y + 1),
         Point(x: x - 1, y: y)]
    }
}

public class Puzzle {
    var grid: [Point: Int]
    var rowCount: Int = 0
    var columnCount: Int = 0
    public init(input: String) {
        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        rowCount = lines.count
        columnCount = lines[0].count
        grid = [:]

        for row in lines.enumerated() {
            for column in row.element.enumerated() {
                grid[Point(x: column.offset, y: row.offset)] = Int("\(column.element)")!
            }
        }
    }

    public func part1() -> Int {
        let start = Point(x: 0, y: 0)
        let goal = Point(x: columnCount - 1, y: rowCount - 1)
        let path = astar(graph: grid, start: start, goal: goal)
        return path.reduce(0) { $0 + grid[$1]! } - grid[start]!
    }

    public func part2() -> Int {
        let start = Point(x: 0, y: 0)

        let expandedGrid = grid.reduce(into: [Point: Int]()) { map, point in

            for x in 0..<5 {
                for y in 0..<5 {
                    let p = Point(x: point.key.x + x * columnCount, y: point.key.y + y * rowCount)
                    let v1 = (grid[point.key]! + x + y)
                    let v2 = v1 > 9 ? v1 - 9 : v1
                    map[p] = v2
                }
            }
        }

        let goal = Point(x: columnCount * 5 - 1, y: rowCount * 5 - 1)
        let path = astar(graph: expandedGrid, start: start, goal: goal)
        let score = path.reduce(0) { $0 + expandedGrid[$1]! } - expandedGrid[start]!
        return score
    }

    // https://en.wikipedia.org/wiki/A*_search_algorithm
    func astar(graph: [Point: Int], start: Point, goal: Point) -> [Point] {
        func reconstructPath(cameFrom: [Point: Point], current: Point) -> [Point] {
            var totalPath: [Point] = []
            var _current: Point? = current
            while _current != nil {
                totalPath.append(_current!)
                _current = cameFrom[_current!]
            }
            return totalPath
        }

        let h: (Point) -> Int = { _ in
            0 // tried various heuristics, but 0 seems to be best 🤔
        }

        var openSet = PriorityQueue<Point, Int>()
        openSet.insert(start, priority: 0)

        var cameFrom: [Point: Point] = [:]

        var gScore: [Point: Int] = [:]
        gScore[start] = 0

        while let current = openSet.popMin() {
            if current == goal {
                return reconstructPath(cameFrom: cameFrom, current: current)
            }

            for neighbor in current.n4() {
                if let d = graph[neighbor] { // when nil, it's a neighbor outside of the graph
                    let tentativeGScore = gScore[current]! + d
                    if tentativeGScore < gScore[neighbor, default: Int.max] {
                        cameFrom[neighbor] = current
                        gScore[neighbor] = tentativeGScore
                        let fScore = tentativeGScore + h(neighbor)
                        openSet.insert(neighbor, priority: fScore)
                    }
                }
            }
        }
        fatalError("no path from \(start) to \(goal)")
    }
}
