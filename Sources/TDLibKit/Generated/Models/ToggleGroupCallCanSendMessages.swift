//
//  ToggleGroupCallCanSendMessages.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Toggles whether participants of a group call can send messages there. Requires groupCall.can_toggle_can_send_messages right
public struct ToggleGroupCallCanSendMessages: Codable, Equatable, Hashable {

    /// New value of the can_send_messages setting
    public let canSendMessages: Bool?

    /// Group call identifier
    public let groupCallId: Int?


    public init(
        canSendMessages: Bool?,
        groupCallId: Int?
    ) {
        self.canSendMessages = canSendMessages
        self.groupCallId = groupCallId
    }
}

