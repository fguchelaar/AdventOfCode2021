import AdventKit
import Foundation

let puzzle = Puzzle(input: try! String(contentsOfFile: "/Users/frank/Workspace/github/fguchelaar/AdventOfCode2021/day-12-passage-pathing/input.txt"))

print("Part 1: \(puzzle.part1())")
print("Part 2: \(puzzle.part2())")
