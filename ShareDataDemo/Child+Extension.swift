//
//  Child+Extension.swift
//  ShareDataDemo
//
//  Created on ityike 2024/12/24.
//


import SwiftUI
import CoreData

extension Child {
    //    func addToSharedUsers(_ user: User) {
    //        var users = sharedUsers?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
    //        users.add(user)
    //        sharedUsers = users
    //    }
    //
    //    func removeFromSharedUsers(_ user: User) {
    //        var users = sharedUsers?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
    //        users.remove(user)
    //        sharedUsers = users
    //    }
    
    @objc(addSharedUsersObject:)
    @NSManaged public func addToSharedUsers(_ value: User)
    
    @objc(removeSharedUsersObject:)
    @NSManaged public func removeFromSharedUsers(_ value: User)
    
    @objc(addSharedUsers:)
    @NSManaged public func addToSharedUsers(_ values: NSSet)
    
    @objc(removeSharedUsers:)
    @NSManaged public func removeFromSharedUsers(_ values: NSSet)
}
