import CommonInterfaces
import SwiftROS2CDR
import SwiftROS2Messages
import XCTest

final class DistroShapeTests: XCTestCase {
    func testHumbleRangeOmitsVarianceAndRoundTrips() throws {
        var range = RangeMsg()
        range.range = 1.25
        range.variance = 0.5
        let humble = CDREncoder(isLegacySchema: true)
        humble.writeEncapsulationHeader()
        try range.encode(to: humble)
        let modern = CDREncoder()
        modern.writeEncapsulationHeader()
        try range.encode(to: modern)
        XCTAssertEqual(modern.getData().count - humble.getData().count, 4)
        let decoded = try RangeMsg(from: CDRDecoder(data: humble.getData(), isLegacySchema: true))
        XCTAssertEqual(decoded.range, 1.25)
        XCTAssertEqual(decoded.variance, 0)
    }

    func testRangeHashPerDistribution() {
        XCTAssertNil(RangeMsg.typeInfo(for: .humble).typeHash)
        XCTAssertEqual(RangeMsg.typeInfo(for: .lyrical).typeHash, RangeMsg.typeInfo.typeHash)
        XCTAssertEqual(RangeMsg.typeInfo(for: .rolling).typeHash, RangeMsg.typeInfo.typeHash)
        XCTAssertNotNil(RangeMsg.typeInfo.typeHash)
    }

    func testDefaultQuaternionIsIdentity() {
        // rosidl emits .msg defaults, so Quaternion() is the identity (2.3.2 gave w == 0).
        XCTAssertEqual(Quaternion().w, 1.0)
        XCTAssertEqual(Quaternion(), Quaternion.identity)
        XCTAssertEqual(Pose().orientation.w, 1.0)
    }
}
