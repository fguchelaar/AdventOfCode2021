@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 198)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 230)
    }
}
