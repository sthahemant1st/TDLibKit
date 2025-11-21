import XCTest
@testable import TDLibKit

public final class StdOutLogger: Logger, TDLibLogger {
    
    let queue: DispatchQueue
    
    public init() {
        queue = DispatchQueue(label: "Logger", qos: .userInitiated)
    }
    
    public func log(_ message: String, type: LoggerMessageType?) {
        queue.async {
            var fisrtLine = ""
            if let type = type {
                fisrtLine = ">> \(type.description)"
            }
            NSLog("\(fisrtLine)\n\(message)\n---------------------------")
        }
    }
}

class TDLibKitUnitTests: XCTestCase {
    
    func testEquatableStructs() {
        let struct1 = AddContact(contact: Contact(firstName: "John", lastName: "Appleseed", phoneNumber: "+10000000000", userId: 123456789, vcard: "empty"), sharePhoneNumber: true)
        let struct2 = AddContact(contact: Contact(firstName: "Pavel", lastName: "Droider", phoneNumber: "+90000000000", userId: 777777777, vcard: "empty"), sharePhoneNumber: false)
        XCTAssertNotEqual(struct1, struct2)
        
        XCTAssertEqual(struct1, struct1)
    }
    
    func testEquatableStructsWithEnums() {
        let struct1 = EditMessageLiveLocation(
            chatId: 1234567, heading: 10, livePeriod: 0x7FFFFFFF, location: Location(horizontalAccuracy: 10.0, latitude: 358.0, longitude: 259.1), messageId: 12345, proximityAlertRadius: 30, replyMarkup: .replyMarkupInlineKeyboard(
                ReplyMarkupInlineKeyboard(
                    rows: [
                        [
                            InlineKeyboardButton(text: "Buy me!", type: .inlineKeyboardButtonTypeBuy)
                        ]
                    ]
                )
            )
        )
        
        let struct2 = EditMessageLiveLocation(
            chatId: 1234567, heading: 10, livePeriod: 0x7FFFFFFF, location: Location(horizontalAccuracy: 10.0, latitude: 358.0, longitude: 259.1), messageId: 12345, proximityAlertRadius: 30, replyMarkup: .replyMarkupInlineKeyboard(
                ReplyMarkupInlineKeyboard(
                    rows: [
                        [
                            InlineKeyboardButton(
                                text: "Ate me!",
                                type: .inlineKeyboardButtonTypeUrl(
                                    InlineKeyboardButtonTypeUrl(url: "https://telegram.org")
                                )
                            )
                        ]
                    ]
                )
            )
        )
        
        XCTAssertEqual(struct1, struct1)
        XCTAssertNotEqual(struct1, struct2)
    }
    
    func testEquatableErrors() {
        let error1 = Error(code: 500, message: "Internal Server Error")
        let error2 = Error(code: 403, message: "You're not alowed to do this")
        let error3 = Error(code: 500, message: "Server down")
        
        XCTAssertEqual(error1, error1)
        XCTAssertNotEqual(error1, error2)
        XCTAssertNotEqual(error1, error3)
    }
    
    func testTdDataDecoder() {
        let api = TDLibApi()
        let dataString = """
        {"@type":"data","@extra":"someExtraInfo","data":"AQIDBAUGBwgJCg=="}
        """.data(using: .utf8)!
        let dataObj = try! api.decoder.decode(DTO<TdData>.self, from: dataString)
        
        XCTAssertEqual(dataObj.type, "data")
        XCTAssertEqual(dataObj.extra, Optional("someExtraInfo"))
        XCTAssertEqual(dataObj.payload.data, Data(base64Encoded: "AQIDBAUGBwgJCg=="))
    }
    
    func testTdDataEncoder() {
        let api = TDLibApi()
        let data = Data(base64Encoded: "AQIDBAUGBwgJCg==")!
        let tdData = TdData(data: data)
        let dto = DTO(tdData, encoder: api.encoder)

        let encodedData = try! dto.make(with: "someExtraInfo")
        let encodedJson = try! JSONSerialization.jsonObject(with: encodedData) as! [String: Any]

        let expectedJsonString = """
        {"@extra":"someExtraInfo","@type":"data","data":"AQIDBAUGBwgJCg=="}
        """
        let expectedData = expectedJsonString.data(using: .utf8)!
        let expectedJson = try! JSONSerialization.jsonObject(with: expectedData) as! [String: Any]

        XCTAssertEqual(encodedJson as NSDictionary, expectedJson as NSDictionary)
    }

}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
class TDLibClientManagerTests: XCTestCase {
    
    func testMultipleClientsInitialization() async {
        let manager = TDLibClientManager(logger: StdOutLogger())
        var clientClosedExpectations: [XCTestExpectation] = []
        
        for i in 1...50 {
            let clientClosedExpectation = XCTestExpectation(description: "Client \(i) closed")
            clientClosedExpectations.append(clientClosedExpectation)
            let client = manager.createClient(updateHandler: {
                print("Size of Update type: \(MemoryLayout<Update>.size)")
                print("Stack size for client thread \(i): \(Thread.current.stackSize)")
                let update = try! $1.decoder.decode(Update.self, from: $0)
                switch (update) {
                    case .updateAuthorizationState(let updateAuthorizationState):
                        switch(updateAuthorizationState.authorizationState) {
                            case .authorizationStateClosed:
                                clientClosedExpectation.fulfill()
                            default:
                                break
                        }
                    default:
                        break
                }
            })
            let verbosityLevel = try! await client.getLogVerbosityLevel()
            if verbosityLevel.verbosityLevel != 5 {
                try! await client.setLogVerbosityLevel(newVerbosityLevel: 5)
            }
            guard let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                XCTFail("Unable to get cache path")
                return
            }
            let tdlibPath = cachesUrl.appendingPathComponent("tdlib-\(i)-\(UUID().uuidString)", isDirectory: true).path
            try! await client.setTdlibParameters(
                apiHash: "5e6d7b36f0e363cf0c07baf2deb26076", // https://core.telegram.org/api/obtaining_api_id
                apiId: 287311,
                applicationVersion: "1.0",
                databaseDirectory: tdlibPath,
                databaseEncryptionKey: nil,
                deviceModel: "iOS",
                filesDirectory: "",
                systemLanguageCode: "en",
                systemVersion: "Unknown",
                useChatInfoDatabase: true,
                useFileDatabase: true,
                useMessageDatabase: true,
                useSecretChats: true,
                useTestDc: false)
            let authState = try! await client.getAuthorizationState()
            switch (authState) {
            case .authorizationStateWaitPhoneNumber:
                break
            default:
                XCTFail("Auth state is not ready for client \(i). It's \(authState)")
            }
        }
        
        let currentLogVerbosityLevel = try! await manager.clients[1]!.getLogVerbosityLevel()
        XCTAssertEqual(currentLogVerbosityLevel.verbosityLevel, 5)
        
        manager.closeClients()
        #if swift(>=5.8)
            await fulfillment(of: clientClosedExpectations, timeout: 180.0)
        #else
            // TODO: We will update Xcode on CI one day
            wait(for: clientClosedExpectations, timeout: 180.0)
        #endif
    }
}
