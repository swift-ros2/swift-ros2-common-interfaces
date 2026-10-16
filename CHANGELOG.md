# Changelog

## 1.0.0-rc.3

Last release candidate before the 1.0.0 API freeze.

- Requires swift-ros2-rosidl 1.0.0-rc.3 and is regenerated with it: generated `encode(to:)`
  throws `CDRSerializationError` for fixed arrays and bounded sequences of the wrong length
  instead of trapping, bounded strings are length-checked on encode and decode, service umbrella
  files no longer import `SwiftROS2CDR`, and `// Source:` lines use `<pkg>/<kind>/<Type>.<kind>`.
  Type hashes and field layouts are unchanged (#15).
- **Behavior change (sensor_msgs):** the zero-argument initializers `CameraInfo()`,
  `NavSatStatus()`, `BatteryState()` and `Imu()` now give the IDL default values, like the
  generated initializers (`NavSatStatus()` is `STATUS_UNKNOWN` / 0; `CameraInfo()` no longer sets
  `plumb_bob` and identity matrices). The typed `BatteryState` convenience initializer keeps its
  2.x defaults and is a disfavored overload, so partial-argument calls such as
  `BatteryState(voltage: 3.7)` compile (#9).
- `Header.now` reuses `Time.now`; helper documentation describes them as API (#10).
- Tests that duplicated others or covered swift-ros2-rosidl code are removed (#11).
- CI builds DocC for every module, keeps the oracle workflow pin and product lists in sync with
  `Package.swift`, caches the Swift toolchain and SDK downloads, and runs on PRs into any branch
  (#12, #13, #14).

## 1.0.0-rc.2

- Requires swift-ros2-rosidl 1.0.0-rc.2.
- Every service carries its service-level type hash (`ROS2ServiceTypeInfo.serviceTypeHash`),
  and `Tf2Msgs.LookupTransformAction` its SendGoal and GetResult service hashes; rmw_zenoh_cpp
  keys services and action services by these hashes. No other generated value changed.

## 1.0.0-rc.1

- All of ros2/common_interfaces except actionlib_msgs, plus tf2_msgs, generated from Humble,
  Jazzy, Kilted and Lyrical IDL; one module per ROS package and the CommonInterfaces umbrella.
- Message helpers carried over from swift-ros2 2.3.2.
- sensor_msgs/Range is RangeMsg.
- Behaviour change: the generator now emits .msg default values, so `Quaternion()` is the
  identity (`w == 1.0`; swift-ros2 2.3.2 gave `w == 0.0`). Default-constructed `Pose`, `Transform`,
  `QuaternionStamped`, `Imu` and `InteractiveMarkerControl` change with it, and so does any
  caller that defaults a field to `Quaternion()`.
- Upstream IDL pinned in idl.lock and fetched by Scripts/fetch-idl.sh; no submodules, so
  consumers receive no IDL.
