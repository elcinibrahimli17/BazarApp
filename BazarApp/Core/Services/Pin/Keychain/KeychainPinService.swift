//
//  KeychainPinService.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import Foundation
import Security
import CryptoKit

final class KeychainPinService: PinServiceProtocol {
    private let service = "com.info.BazarApp.pin"
    private let account = "userPin"

    nonisolated init() {}

    var hasPin: Bool {
        readHash() != nil
    }

    func savePin(_ pin: String) throws {
        deletePin()

        var query = baseQuery
        query[kSecValueData as String] = hash(pin)
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw PinError.saveFailed
        }
    }

    func verifyPin(_ pin: String) -> Bool {
        readHash() == hash(pin)
    }

    func deletePin() {
        SecItemDelete(baseQuery as CFDictionary)
    }

    private var baseQuery: [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
    }

    private func readHash() -> Data? {
        var query = baseQuery
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else { return nil }
        return result as? Data
    }

    private func hash(_ pin: String) -> Data {
        Data(SHA256.hash(data: Data(pin.utf8)))
    }
}
