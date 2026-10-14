// Hand-written conveniences layered on top of the swift-ros2-gen output.
//
// The IDL emitter is intentionally minimal — it only writes fields, an `init`,
// and CDR encode/decode. Any helper / sentinel / convention-driven default that
// the rest of the codebase relies on lives here so the generated files stay
// regenerable without manual touch-ups.

import SwiftROS2Messages

extension Quaternion {
    /// Identity quaternion (`w == 1`). The generated `Quaternion()` is the same value, because
    /// `swift-ros2-gen` emits the `.msg` default of `w`; this name states the intent at call sites.
    public static var identity: Quaternion { Quaternion(w: 1.0) }
}
