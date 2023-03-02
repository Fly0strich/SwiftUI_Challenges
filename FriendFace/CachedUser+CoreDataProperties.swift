//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Shae Willes on 9/10/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedID: UUID {
        id ?? UUID()
    }
    
    var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    var wrappedAbout: String {
        about ?? ""
    }
    
    var wrappedRegistrationDate: Date {
        registered ?? Date.now
    }
    
    var wrappedTags: String {
        tags ?? ""
    }
    
    var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
