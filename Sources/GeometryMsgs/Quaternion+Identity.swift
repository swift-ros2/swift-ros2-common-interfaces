// Hand-written helpers for the generated `Quaternion`.

import SwiftROS2Messages

extension Quaternion {
    /// Identity quaternion (`w == 1`). The generated `Quaternion()` is the same value, because
    /// `swift-ros2-gen` emits the `.msg` default of `w`; this name states the intent at call sites.
    public static var identity: Quaternion { Quaternion(w: 1.0) }
}
