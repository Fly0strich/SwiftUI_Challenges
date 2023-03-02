//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Shae Willes on 9/10/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friendOf: NSSet?
    
    var wrappedID: UUID {
        id ?? UUID()
    }
    
    var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    var friendOfArray: [CachedUser] {
        let set = friendOf as? Set<CachedUser> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friendOf
extension CachedFriend {

    @objc(addFriendOfObject:)
    @NSManaged public func addToFriendOf(_ value: CachedUser)

    @objc(removeFriendOfObject:)
    @NSManaged public func removeFromFriendOf(_ value: CachedUser)

    @objc(addFriendOf:)
    @NSManaged public func addToFriendOf(_ values: NSSet)

    @objc(removeFriendOf:)
    @NSManaged public func removeFromFriendOf(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
