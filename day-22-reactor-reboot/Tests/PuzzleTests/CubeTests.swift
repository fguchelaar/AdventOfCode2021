@testable import Puzzle
import XCTest

class CubeTests: XCTestCase {
    func testVolume() {
        XCTAssertEqual(27, Cube(10, 12, 10, 12, 10, 12).volume)
        XCTAssertEqual(27, Cube(-12, -10, -12, -10, -12, -10).volume)
        XCTAssertEqual(64, Cube(-2, 1, -17, -14, 112, 115).volume)
    }

    func testIntersectionTest1() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(5, 15, 5, 15, 5, 15)
        XCTAssertEqual(Cube(5, 10, 5, 10, 5, 10), cube1.intersection(with: cube2))
    }

    func testIntersectionTest2() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(10, 15, 10, 15, 10, 15)
        XCTAssertEqual(Cube(10, 10, 10, 10, 10, 10), cube1.intersection(with: cube2))
    }

    func testIntersectionTest3() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(0, 10, 0, 10, 0, 10)
        XCTAssertEqual(Cube(0, 10, 0, 10, 0, 10), cube1.intersection(with: cube2))
    }

    func testIntersectionTest4() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(0, 10, 0, 10, -5, 2)
        XCTAssertEqual(Cube(0, 10, 0, 10, 0, 2), cube1.intersection(with: cube2))
    }

    func testIntersectionTest5() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(0, 10, 0, 10, -5, -1)
        XCTAssertNil(cube1.intersection(with: cube2))
    }

    func testIntersectionTestNil() {
        let cube1 = Cube(0, 10, 0, 10, 0, 10)
        let cube2 = Cube(12, 15, 12, 15, 12, 15)
        XCTAssertNil(cube1.intersection(with: cube2))
    }
}
