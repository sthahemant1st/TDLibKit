//
//  ClearRecentStickers.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Clears the list of recently used stickers
public struct ClearRecentStickers: Codable, Equatable, Hashable {

    /// Pass true to clear the list of stickers recently attached to photo or video files; pass false to clear the list of recently sent stickers
    public let isAttached: Bool?


    public init(isAttached: Bool?) {
        self.isAttached = isAttached
    }
}

