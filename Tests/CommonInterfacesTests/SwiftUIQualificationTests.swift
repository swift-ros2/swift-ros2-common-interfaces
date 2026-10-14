#if canImport(SwiftUI)
    import NavMsgs
    import SensorMsgs
    import SwiftUI
    import XCTest

    final class SwiftUIQualificationTests: XCTestCase {
        func testModuleQualifiedNamesCompileNextToSwiftUI() {
            let image = SensorMsgs.Image()
            let path = NavMsgs.Path()
            XCTAssertEqual(image.height, 0)
            XCTAssertTrue(path.poses.isEmpty)
        }
    }
#endif
