@testable import Puzzle
import XCTest

final class PositionTests: XCTestCase {
    func testPositionStringInit() throws {
        let position = Position("686,422,578")
        XCTAssertEqual(position.x, 686)
        XCTAssertEqual(position.y, 422)
        XCTAssertEqual(position.z, 578)
    }

    func testDifference() throws {
        let p1 = Position(2, 2, 2)
        let p2 = Position(5, 5, 5)
        let diff = p1.difference(to: p2)
        XCTAssertEqual(diff, Position(3, 3, 3))
    }

    func testDifferenceNegative() throws {
        let p1 = Position(5, 5, 5)
        let p2 = Position(2, 2, 2)
        let diff = p1.difference(to: p2)
        XCTAssertEqual(diff, Position(-3, -3, -3))
    }

    func testInvert() throws {
        XCTAssertEqual(Position(68, -1246, -43).inverted, Position(-68, 1246, 43))
    }
}
