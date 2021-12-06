@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    let input = "3,4,3,1,2"

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 5934)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 26_984_457_539)
    }
}
