//
//  ChildDetailView.swift
//  ShareDataDemo
//  
//  Created on ityike 2024/12/24.
//


import SwiftUI
import CoreData


struct ChildDetailView: View {
    @ObservedObject var child: Child
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddHeight = false
    @State private var showingShareSheet = false
    @State private var newHeight: String = ""
    
    var heightRecords: [HeightRecord] {
        let fetchRequest: NSFetchRequest<HeightRecord> = HeightRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "child == %@", child)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \HeightRecord.date, ascending: false)]
        
        return (try? viewContext.fetch(fetchRequest)) ?? []
    }
    
    var body: some View {
        List {
            Section("Details") {
                HStack {
                    Text("Name:")
                    TextField("Name", text: Binding(
                        get: { child.name ?? "" },
                        set: {
                            child.name = $0
                            try? viewContext.save()
                        }
                    ))
                }
                DatePicker(
                    "Birth Date",
                    selection: Binding(
                        get: { child.birthDate ?? Date() },
                        set: {
                            child.birthDate = $0
                            try? viewContext.save()
                        }
                    ),
                    displayedComponents: .date
                )
            }
            
            Section("Height Records") {
                ForEach(heightRecords, id: \.self) { record in
                    HStack {
                        Text(record.date ?? Date(), style: .date)
                        Spacer()
                        Text("\(record.height) cm")
                    }
                }
                .onDelete(perform: deleteHeightRecords)
            }
        }
        .navigationTitle(child.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingShareSheet = true }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddHeight = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddHeight) {
            NavigationView {
                Form {
                    TextField("Height (cm)", text: $newHeight)
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("Add Height Record")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        showingAddHeight = false
                    },
                    trailing: Button("Save") {
                        addHeightRecord()
                        showingAddHeight = false
                    }
                )
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(child: child)
        }
    }
    
    private func addHeightRecord() {
        guard let height = Double(newHeight) else { return }
        
        let record = HeightRecord(context: viewContext)
        record.height = height
        record.date = Date()
        record.child = child
        record.recordSystemIdentifier = UUID().uuidString
        
        try? viewContext.save()
        newHeight = ""
    }
    
    private func deleteHeightRecords(at offsets: IndexSet) {
        offsets.map { heightRecords[$0] }.forEach(viewContext.delete)
        try? viewContext.save()
    }
}
