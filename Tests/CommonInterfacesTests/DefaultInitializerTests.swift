import CommonInterfaces
import XCTest

/// The zero-argument form of a message is the generated initializer with every default, so a
/// type has one default value whether or not a label is written.
final class DefaultInitializerTests: XCTestCase {
    /// `Quaternion()` is the identity (the IDL default `w = 1`), so a default `Imu` publishes a
    /// valid orientation without a hand-written initializer.
    func testImuZeroArgumentHasIdentityOrientation() {
        XCTAssertEqual(Imu(), Imu(header: Header()))
        XCTAssertEqual(Imu().orientation, Quaternion(x: 0, y: 0, z: 0, w: 1))
    }

    func testCameraInfoZeroArgumentMatchesLabelledDefaults() {
        XCTAssertEqual(CameraInfo(), CameraInfo(header: Header()))
        XCTAssertEqual(CameraInfo().distortionModel, "")
        XCTAssertEqual(CameraInfo().r, Array(repeating: 0.0, count: 9))
    }

    func testNavSatStatusZeroArgumentMatchesLabelledDefaults() {
        XCTAssertEqual(NavSatStatus(), NavSatStatus(service: 0))
        XCTAssertEqual(NavSatStatus(), NavSatStatus(status: NavSatStatus.STATUS_UNKNOWN))
        XCTAssertEqual(NavSatStatus().service, 0)
    }

    func testBatteryStateZeroArgumentMatchesLabelledDefaults() {
        XCTAssertEqual(BatteryState(), BatteryState(header: Header()))
        XCTAssertEqual(BatteryState().powerSupplyStatus, BatteryState.POWER_SUPPLY_STATUS_UNKNOWN)
        XCTAssertFalse(BatteryState().present)
    }

    /// Each of these used to fail with "ambiguous use of init(header:voltage:…)".
    func testBatteryStateWithOneLabelledArgumentCompiles() {
        XCTAssertEqual(BatteryState(header: Header(frameId: "battery")).header.frameId, "battery")
        XCTAssertEqual(BatteryState(voltage: 3.7).voltage, 3.7)
        XCTAssertEqual(BatteryState(percentage: 0.5).percentage, 0.5)
        XCTAssertEqual(BatteryState(percentage: 0.5).temperature, 0.0)
    }

    func testBatteryStateTypedInitializerKeepsItsDefaults() {
        let state = BatteryState(percentage: 0.5, powerSupplyStatus: .charging)
        XCTAssertEqual(state.powerSupplyStatus, BatteryState.POWER_SUPPLY_STATUS_CHARGING)
        XCTAssertEqual(state.percentage, 0.5)
        XCTAssertTrue(state.temperature.isNaN)
        XCTAssertTrue(state.present)

        let health = BatteryState(powerSupplyHealth: .good)
        XCTAssertEqual(health.powerSupplyHealth, BatteryState.POWER_SUPPLY_HEALTH_GOOD)
        XCTAssertEqual(health.powerSupplyStatus, BatteryState.POWER_SUPPLY_STATUS_UNKNOWN)
    }

    /// The full typed call, as an app that maps a device battery would write it.
    func testBatteryStateTypedInitializerWithEveryArgument() {
        let state = BatteryState(
            header: Header(), voltage: .nan, temperature: .nan, current: .nan, charge: .nan, capacity: .nan,
            designCapacity: .nan, percentage: 0.8, powerSupplyStatus: .discharging, powerSupplyHealth: .unknown,
            powerSupplyTechnology: .lion, present: true, cellVoltage: [], cellTemperature: [], location: "main",
            serialNumber: "")
        XCTAssertEqual(state.powerSupplyTechnology, BatteryState.POWER_SUPPLY_TECHNOLOGY_LION)
        XCTAssertEqual(state.location, "main")
    }
}
