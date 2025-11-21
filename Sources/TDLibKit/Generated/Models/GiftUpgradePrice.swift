//
//  GiftUpgradePrice.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Describes a price required to pay to upgrade a gift
public struct GiftUpgradePrice: Codable, Equatable, Hashable {

    /// Point in time (Unix timestamp) when the price will be in effect
    public let date: Int

    /// The amount of Telegram Stars required to pay to upgrade the gift
    public let starCount: Int64


    public init(
        date: Int,
        starCount: Int64
    ) {
        self.date = date
        self.starCount = starCount
    }
}

