@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
    [[[5,[2,8]],4],[5,[[9,9],0]]]
    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
    [[[[5,4],[7,7]],8],[[8,3],8]]
    [[9,3],[[9,9],[6,[4,9]]]]
    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
    """

    func testMagnitude() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.magnitude(of: "[[1,2],[[3,4],5]]"), 143)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"), 1384)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[1,1],[2,2]],[3,3]],[4,4]]"), 445)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[3,0],[5,3]],[4,4]],[5,5]]"), 791)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[5,0],[7,4]],[5,5]],[6,6]]"), 1137)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"), 3488)
        XCTAssertEqual(puzzle.magnitude(of: "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]"), 4140)
    }

    func testPart1SimpleInput() throws {
        let puzzle = Puzzle(input: """
        [[[[4,3],4],4],[7,[[8,4],9]]]
        [1,1]
        """)
        XCTAssertEqual(puzzle.part1(), 1384)
    }

    func testPart1SmallInput1() throws {
        let puzzle = Puzzle(input: """
        [1,1]
        [2,2]
        [3,3]
        [4,4]
        """)
        XCTAssertEqual(puzzle.part1(), 445)
    }

    func testPart1SmallInput2() throws {
        let puzzle = Puzzle(input: """
        [1,1]
        [2,2]
        [3,3]
        [4,4]
        [5,5]
        """)
        XCTAssertEqual(puzzle.part1(), 791)
    }

    func testPart1SmallInput3() throws {
        let puzzle = Puzzle(input: """
        [1,1]
        [2,2]
        [3,3]
        [4,4]
        [5,5]
        [6,6]
        """)
        XCTAssertEqual(puzzle.part1(), 1137)
    }

    func testPart1SlightlyLarger() throws {
        let puzzle = Puzzle(input: """
        [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
        [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
        [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
        [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
        [7,[5,[[3,8],[1,4]]]]
        [[2,[2,2]],[8,[8,1]]]
        [2,9]
        [1,[[[9,3],9],[[9,0],[0,7]]]]
        [[[5,[7,4]],7],1]
        [[[[4,2],2],6],[8,7]]
        """)
        XCTAssertEqual(puzzle.part1(), 3488)
    }

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 4140)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 3993)
    }
}
