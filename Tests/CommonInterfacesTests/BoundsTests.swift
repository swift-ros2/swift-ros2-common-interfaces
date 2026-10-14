import CommonInterfaces
import SwiftROS2CDR
import XCTest

final class BoundsTests: XCTestCase {
    func testMarkerArrayRejectsHugeSequenceCount() throws {
        let encoder = CDREncoder()
        encoder.writeEncapsulationHeader()
        encoder.writeUInt32(UInt32.max)
        XCTAssertThrowsError(try MarkerArray(from: CDRDecoder(data: encoder.getData())))
    }
}
