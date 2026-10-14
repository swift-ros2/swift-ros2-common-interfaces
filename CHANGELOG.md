# Changelog

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
