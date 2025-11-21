//
//  DeleteStickerSet.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Completely deletes a sticker set
public struct DeleteStickerSet: Codable, Equatable, Hashable {

    /// Sticker set name. The sticker set must be owned by the current user
    public let name: String?


    public init(name: String?) {
        self.name = name
    }
}

