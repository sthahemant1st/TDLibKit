//
//  EmojiKeyword.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Represents an emoji with its keyword
public struct EmojiKeyword: Codable, Equatable, Hashable {

    /// The emoji
    public let emoji: String

    /// The keyword
    public let keyword: String


    public init(
        emoji: String,
        keyword: String
    ) {
        self.emoji = emoji
        self.keyword = keyword
    }
}

