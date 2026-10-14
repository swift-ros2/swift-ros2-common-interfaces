import CommonInterfaces
import XCTest

final class UmbrellaTests: XCTestCase {
    func testUmbrellaExposesEveryPackage() {
        XCTAssertEqual(StringMsg.typeInfo.typeName, "std_msgs/msg/String")
        XCTAssertEqual(TriggerSrv.typeInfo.serviceName, "std_srvs/srv/Trigger")
        XCTAssertEqual(PoseStamped.typeInfo.typeName, "geometry_msgs/msg/PoseStamped")
        XCTAssertEqual(RangeMsg.typeInfo.typeName, "sensor_msgs/msg/Range")
        XCTAssertEqual(Odometry.typeInfo.typeName, "nav_msgs/msg/Odometry")
        XCTAssertEqual(DiagnosticArray.typeInfo.typeName, "diagnostic_msgs/msg/DiagnosticArray")
        XCTAssertEqual(SolidPrimitive.typeInfo.typeName, "shape_msgs/msg/SolidPrimitive")
        XCTAssertEqual(DisparityImage.typeInfo.typeName, "stereo_msgs/msg/DisparityImage")
        XCTAssertEqual(JointTrajectory.typeInfo.typeName, "trajectory_msgs/msg/JointTrajectory")
        XCTAssertEqual(MarkerArray.typeInfo.typeName, "visualization_msgs/msg/MarkerArray")
        XCTAssertEqual(TFMessage.typeInfo.typeName, "tf2_msgs/msg/TFMessage")
        XCTAssertEqual(Time().sec, 0)
        XCTAssertEqual(DurationMsg().sec, 0)
    }
}
