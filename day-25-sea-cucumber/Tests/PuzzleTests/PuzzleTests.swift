@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    let input = """
    v...>>.vv>
    .vv>>.vv..
    >>.>v>...v
    >>v>>.>.v.
    v>v.vv.v..
    >.>>..v...
    .vv..>.>v.
    v.v..>>v.v
    ....v..v.>
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 58)
    }
}
