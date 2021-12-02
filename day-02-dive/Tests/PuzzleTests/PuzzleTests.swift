@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample() throws {
        let puzzle = Puzzle(input: """
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
        """)
        XCTAssertEqual(puzzle.part1(), 150)
        XCTAssertEqual(puzzle.part2 (), 900)
    }
}
