//
//  ContentView.swift
//  ShareDataDemo
//
//  Created on ityike 2024/12/24.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Child.name, ascending: true)],
        animation: .default)
    private var children: FetchedResults<Child>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(children) { child in
                    NavigationLink {
                        ChildDetailView(child: child)
                    } label: {
                        Text(child.name ?? "")
                    }
                }
                .onDelete(perform: deleteChildren)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addChild) {
                        Label("Add Child", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Children")
        }
    }
    
    private func addChild() {
        withAnimation {
            let newChild = Child(context: viewContext)
            newChild.name = "New Child"
            newChild.birthDate = Date()
            newChild.recordSystemIdentifier = UUID().uuidString
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error saving context: \(nsError)")
            }
        }
    }
    
    private func deleteChildren(offsets: IndexSet) {
        withAnimation {
            offsets.map { children[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

