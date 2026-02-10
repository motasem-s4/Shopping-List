//
//  EditItemView.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import SwiftUI
import SwiftData

struct EditItemView: View {
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    @Bindable var item: ShoppingItem

    @State private var editedName: String = ""
    @State private var editedCategory: ItemCategory = .milk
    
    private var isSaveDisabled: Bool {
        editedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Functions
    private func save() {
        item.name = editedName.trimmingCharacters(in: .whitespacesAndNewlines)
        item.category = editedCategory
        dismiss()
    }
    
    private func setItem() {
        editedName = item.name
        editedCategory = item.category
    }
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Name", text: $editedName)
                    Picker("Category", selection: $editedCategory) {
                        ForEach(ItemCategory.allCases) { category in
                            Text(category.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        save()
                    }
                    .disabled(isSaveDisabled)
                }
            }
            .onAppear {
                setItem()
            }
        }
    }
}

// MARK: - Previews
#Preview("EditItemView") {
    let container = PreviewStore.container()
    let context = container.mainContext
    let item = ShoppingItem(name: "Tomatoes", category: .vegetables, isCompleted: false)
    context.insert(item)

    return EditItemView(item: item)
        .modelContainer(container)
}
