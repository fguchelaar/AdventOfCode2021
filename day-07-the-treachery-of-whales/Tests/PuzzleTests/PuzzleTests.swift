@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    let input = "16,1,2,0,4,2,7,1,2,14"

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 37)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 168)
    }
}
