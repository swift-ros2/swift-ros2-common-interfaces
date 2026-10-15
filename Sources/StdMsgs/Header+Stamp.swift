// Hand-written helpers for the generated `Header`. The generator writes only fields, the
// initializer and CDR encode / decode, so helpers live in files like this one, next to the
// generated sources.

import BuiltinInterfaces
import SwiftROS2CDR
import SwiftROS2Messages

extension Header {
    /// Creates a header from a flat `UInt32` seconds / nanoseconds stamp (the swift-ros2 2.x
    /// `Header` shape). `sec` is stored bit for bit in the `Int32` `stamp.sec`.
    public init(sec: UInt32 = 0, nanosec: UInt32 = 0, frameId: String = "") {
        self.init(stamp: Time(sec: Int32(bitPattern: sec), nanosec: nanosec), frameId: frameId)
    }

    /// `stamp.sec` reinterpreted as `UInt32`, the flat layout of the swift-ros2 2.x `Header`.
    public var sec: UInt32 {
        get { UInt32(bitPattern: stamp.sec) }
        set { stamp.sec = Int32(bitPattern: newValue) }
    }

    /// `stamp.nanosec`, the flat layout of the swift-ros2 2.x `Header`.
    public var nanosec: UInt32 {
        get { stamp.nanosec }
        set { stamp.nanosec = newValue }
    }

    /// Stamp the header with the current wall-clock time (`Time.now()`, which saturates
    /// after Jan 19 2038 03:14:07 UTC instead of trapping) and the given frame.
    public static func now(frameId: String) -> Header {
        Header(stamp: Time.now(), frameId: frameId)
    }

    /// Header timestamp expressed in nanoseconds since the Unix epoch.
    public var timestampNanoseconds: Int64 {
        Int64(stamp.sec) * 1_000_000_000 + Int64(stamp.nanosec)
    }
}
