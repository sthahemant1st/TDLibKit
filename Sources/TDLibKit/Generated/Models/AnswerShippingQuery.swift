//
//  AnswerShippingQuery.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.56-dd1b761f
//  https://github.com/tdlib/td/tree/dd1b761f
//

import Foundation


/// Sets the result of a shipping query; for bots only
public struct AnswerShippingQuery: Codable, Equatable, Hashable {

    /// An error message, empty on success
    public let errorMessage: String?

    /// Available shipping options
    public let shippingOptions: [ShippingOption]?

    /// Identifier of the shipping query
    public let shippingQueryId: TdInt64?


    public init(
        errorMessage: String?,
        shippingOptions: [ShippingOption]?,
        shippingQueryId: TdInt64?
    ) {
        self.errorMessage = errorMessage
        self.shippingOptions = shippingOptions
        self.shippingQueryId = shippingQueryId
    }
}

