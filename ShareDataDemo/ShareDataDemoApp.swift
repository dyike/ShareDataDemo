//
//  ShareDataDemoApp.swift
//  ShareDataDemo
//  
//  Created on ityike 2024/12/24.
//


import SwiftUI

@main
struct ShareDataDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
