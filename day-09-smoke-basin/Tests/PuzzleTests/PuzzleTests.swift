@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 15)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 1134)
    }
}
