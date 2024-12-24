//
//  ShareView.swift
//  ShareDataDemo
//  
//  Created on ityike 2024/12/24.
//


import SwiftUI
import CloudKit

struct ShareView: UIViewControllerRepresentable {
    let child: Child
    
    func makeUIViewController(context: Context) -> UICloudSharingController {
        let container = CKContainer(identifier: "iCloud.com.crosszan.ShareDataDemo")
        let recordID = CKRecord.ID(recordName: child.recordSystemIdentifier ?? UUID().uuidString)
        let record = CKRecord(recordType: "Child", recordID: recordID)
        let share = CKShare(rootRecord: record)
        
        let sharingController = UICloudSharingController(preparationHandler: { (controller, preparationCompletionHandler) in
            container.privateCloudDatabase.save(record) { (_, error) in
                if let error = error {
                    preparationCompletionHandler(nil, container, error)
                    return
                }
                
                container.privateCloudDatabase.save(share) { (_, error) in
                    preparationCompletionHandler(share, container, error)
                }
            }
        })
        
        sharingController.availablePermissions = [.allowReadWrite]
        return sharingController
    }
    
    func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {}
}

