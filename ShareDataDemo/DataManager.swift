//
//  DataManager.swift
//  ShareDataDemo
//
//  Created on ityike 2024/12/24.
//


import Foundation
import CoreData
import CloudKit


class HeightRecordManager {
    static let shared = HeightRecordManager()
    private let context = CoreDataStack.shared.viewContext
    
    // 添加小朋友
    func addChild(name: String, birthDate: Date) throws -> Child {
        let child = Child(context: context)
        child.name = name
        child.birthDate = birthDate
        child.recordSystemIdentifier = UUID().uuidString
        try context.save()
        return child
    }
    
    // 添加身高记录
    func addHeightRecord(height: Double, date: Date, for child: Child) throws -> HeightRecord {
        let record = HeightRecord(context: context)
        record.height = height
        record.date = date
        record.child = child
        record.recordSystemIdentifier = UUID().uuidString
        try context.save()
        return record
    }
    
//    // 邀请用户共享
//    func inviteUser(email: String, for child: Child) throws {
//        // 检查用户是否存在
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
//        
//        let user: User
//        if let existingUser = try context.fetch(fetchRequest).first {
//            user = existingUser
//        } else {
//            user = User(context: context)
//            user.email = email
//            user.recordSystemIdentifier = UUID().uuidString
//        }
//        
//        child.addToSharedUsers(user)
//        try context.save()
//        
//        // 发送CloudKit共享邀请
//        sendCloudKitInvitation(to: email, for: child)
//    }
//    
//    private func sendCloudKitInvitation(to email: String, for child: Child) {
//        guard let recordId = child.recordSystemIdentifier else { return }
//        
//        let container = CKContainer(identifier: "iCloud.com.crosszan.ShareDataDemo")
//        let recordID = CKRecord.ID(recordName: recordId)
//        let record = CKRecord(recordType: "Child", recordID: recordID)
//        
//        let share = CKShare(rootRecord: record)
//        share.publicPermission = .readWrite
//        
//        let operation = CKModifyRecordsOperation()
//        operation.recordsToSave = [record, share]
//        
//        operation.perRecordProgressBlock = { record, progress in
//            print("Progress: \(progress)")
//        }
//        
//        operation.perRecordCompletionBlock = { record, error in
//            if let error {
//                print("Error with record: \(error)")
//                return
//            }
//            
//            // 创建分享参与者
//            let participant = CKShare.Participant(userIdentity: CKUserIdentity(), permission: .readWrite)
//            share.addParticipant(participant)
//            
//            // 保存分享设置
//            let saveOperation = CKModifyRecordsOperation(recordsToSave: [share], recordIDsToDelete: nil)
//            container.privateCloudDatabase.add(saveOperation)
//        }
//        
//        container.privateCloudDatabase.add(operation)
//    }
}
