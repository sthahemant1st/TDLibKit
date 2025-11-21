//
//  AvailableGifts.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Contains a list of gifts that can be sent to another user or channel chat
public struct AvailableGifts: Codable, Equatable, Hashable {

    /// The list of gifts
    public let gifts: [AvailableGift]


    public init(gifts: [AvailableGift]) {
        self.gifts = gifts
    }
}

