//
//  SendGroupCallMessage.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Sends a message to other participants of a group call. Requires groupCall.can_send_messages right
public struct SendGroupCallMessage: Codable, Equatable, Hashable {

    /// Group call identifier
    public let groupCallId: Int?

    /// Text of the message to send; 1-getOption("group_call_message_text_length_max") characters
    public let text: FormattedText?


    public init(
        groupCallId: Int?,
        text: FormattedText?
    ) {
        self.groupCallId = groupCallId
        self.text = text
    }
}

