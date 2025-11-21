//
//  GetPaidMessageRevenue.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Returns the total number of Telegram Stars received by the current user for paid messages from the given user
public struct GetPaidMessageRevenue: Codable, Equatable, Hashable {

    /// Identifier of the user
    public let userId: Int64?


    public init(userId: Int64?) {
        self.userId = userId
    }
}

