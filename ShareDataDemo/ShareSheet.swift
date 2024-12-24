//
//  ShareSheet.swift
//  ShareDataDemo
//  
//  Created on ityike 2024/12/24.
//


import SwiftUI
import CoreData
import CloudKit

struct ShareSheet: View {
    @ObservedObject var child: Child
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ShareView(child: child)
                .navigationTitle("Share")
                .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
