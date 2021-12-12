@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let inputSmall = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    let inputMedium = """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """

    let inputLarge = """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """

    func testPart1Small() throws {
        let puzzle = Puzzle(input: inputSmall)
        XCTAssertEqual(puzzle.part1(), 10)
    }

    func testPart1Medium() throws {
        let puzzle = Puzzle(input: inputMedium)
        XCTAssertEqual(puzzle.part1(), 19)
    }

    func testPart1Large() throws {
        let puzzle = Puzzle(input: inputLarge)
        XCTAssertEqual(puzzle.part1(), 226)
    }

    func testPart2Small() throws {
        let puzzle = Puzzle(input: inputSmall)
        XCTAssertEqual(puzzle.part2(), 36)
    }

    func testPar21Medium() throws {
        let puzzle = Puzzle(input: inputMedium)
        XCTAssertEqual(puzzle.part2(), 103)
    }

    func testPart2Large() throws {
        let puzzle = Puzzle(input: inputLarge)
        XCTAssertEqual(puzzle.part2(), 3509)
    }
}
