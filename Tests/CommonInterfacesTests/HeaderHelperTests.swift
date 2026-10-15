import CommonInterfaces
import Foundation
import XCTest

final class HeaderHelperTests: XCTestCase {
    func testNowStampsTheWallClockAndFrame() {
        let before = Date().timeIntervalSince1970
        let header = Header.now(frameId: "imu_link")
        let after = Date().timeIntervalSince1970
        let seconds = Double(header.timestampNanoseconds) / 1_000_000_000
        XCTAssertEqual(header.frameId, "imu_link")
        XCTAssertGreaterThanOrEqual(seconds, before.rounded(.down))
        XCTAssertLessThanOrEqual(seconds, after)
    }

    func testFlatStampAccessorsRoundTrip() {
        var header = Header(sec: 3_000_000_000, nanosec: 5, frameId: "map")
        XCTAssertEqual(header.sec, 3_000_000_000)
        XCTAssertEqual(header.stamp.sec, Int32(bitPattern: 3_000_000_000))
        header.nanosec = 7
        XCTAssertEqual(header.stamp.nanosec, 7)
    }
}
