//
//  GetKeywordEmojis.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Return emojis matching the keyword. Supported only if the file database is enabled. Order of results is unspecified
public struct GetKeywordEmojis: Codable, Equatable, Hashable {

    /// List of possible IETF language tags of the user's input language; may be empty if unknown
    public let inputLanguageCodes: [String]?

    /// Text to search for
    public let text: String?


    public init(
        inputLanguageCodes: [String]?,
        text: String?
    ) {
        self.inputLanguageCodes = inputLanguageCodes
        self.text = text
    }
}

