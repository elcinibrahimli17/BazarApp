//
//  PinServiceProtocol.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


protocol PinServiceProtocol {
    var hasPin: Bool { get }
    func savePin(_ pin: String) throws
    func verifyPin(_ pin: String) -> Bool
    func deletePin()
}