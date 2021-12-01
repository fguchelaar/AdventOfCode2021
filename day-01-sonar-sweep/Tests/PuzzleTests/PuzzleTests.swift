@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample() throws {
        let puzzle = Puzzle(input: """
199
200
208
210
200
207
240
269
260
263
""")
        XCTAssertEqual(puzzle.part1(), 7)
        XCTAssertEqual(puzzle.part2(), 5)
    }
}
