// CovarianceConstants.swift
// Sentinel values and helpers for ROS 2 covariance matrices.

import Foundation

/// Sentinel values and helpers for ROS 2 covariance matrices.
///
/// Use ``unknown`` (−1.0) to indicate that covariance is not available,
/// following the ROS 2 sensor-message convention.
public enum CovarianceConstants {
    /// Covariance sentinel meaning "not available" (−1.0).
    public static let unknown: Double = -1.0

    /// A row-major 3x3 covariance matrix with every element set to ``unknown``.
    public static func unknownCovariance3x3() -> [Double] {
        Array(repeating: unknown, count: 9)
    }

    /// A row-major 3x3 covariance matrix of zeros.
    public static func zeroCovariance3x3() -> [Double] {
        Array(repeating: 0.0, count: 9)
    }
}
