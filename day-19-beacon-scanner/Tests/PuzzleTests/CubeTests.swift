@testable import Puzzle
import XCTest

final class CubeTests: XCTestCase {
    func testCubeStringInit() throws {
        let cube = Cube("""
        --- scanner 1 ---
        686,422,578
        605,423,415
        515,917,-361
        """)
        XCTAssertEqual(cube.id, 1)
        XCTAssertEqual(cube.beacons.count, 3)
    }
}
