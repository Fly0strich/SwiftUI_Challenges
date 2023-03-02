//
//  User.swift
//  FriendFace
//
//  Created by Shae Willes on 9/5/22.
//

import Foundation

struct User: Identifiable, Codable {
    struct Friend: Identifiable, Codable {
        let id: UUID
        let name: String
    }
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int16
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedRegistrationDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}
