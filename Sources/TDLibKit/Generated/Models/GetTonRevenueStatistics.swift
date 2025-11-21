//
//  GetTonRevenueStatistics.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Returns detailed Toncoin revenue statistics of the current user
public struct GetTonRevenueStatistics: Codable, Equatable, Hashable {

    /// Pass true if a dark theme is used by the application
    public let isDark: Bool?


    public init(isDark: Bool?) {
        self.isDark = isDark
    }
}

