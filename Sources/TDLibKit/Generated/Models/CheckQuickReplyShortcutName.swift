//
//  CheckQuickReplyShortcutName.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Checks validness of a name for a quick reply shortcut. Can be called synchronously
public struct CheckQuickReplyShortcutName: Codable, Equatable, Hashable {

    /// The name of the shortcut; 1-32 characters
    public let name: String?


    public init(name: String?) {
        self.name = name
    }
}

