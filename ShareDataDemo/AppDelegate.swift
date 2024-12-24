//
//  AppDelegate.swift
//  ShareDataDemo
//  
//  Created on ityike 2024/12/25.
//


import Foundation
import SwiftUI
import CloudKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        let container = CKContainer(identifier: "iCloud.com.crosszan.ShareDataDemo")
        container.accept(cloudKitShareMetadata) { _, error in
            if let error = error {
                print("Accept share error: \(error)")
            }
        }
    }
}
