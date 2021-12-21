@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    Player 1 starting position: 4
    Player 2 starting position: 8
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 739785)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 444_356_092_776_315)
    }
}
