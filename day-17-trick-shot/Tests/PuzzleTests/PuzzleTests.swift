@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    let input = "target area: x=20..30, y=-10..-5"

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 45)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 112)
    }
}
