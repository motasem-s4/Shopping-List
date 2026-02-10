//
//  ItemRow.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import SwiftUI
import SwiftData

struct ItemRow: View {
    // MARK: - Attributes
    @Bindable var item: ShoppingItem

    // MARK: - UI
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
            VStack(alignment: .leading) {
                Text(item.name)
                    .strikethrough(item.isCompleted)
                
                Text(item.categoryRaw)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

// MARK: - Previews
#Preview("ItemRow - Not completed") {
    let container = PreviewStore.container()
    let context = container.mainContext
    let item = ShoppingItem(name: "Apples", category: .fruits, isCompleted: false)
    context.insert(item)

    return ItemRow(item: item)
        .padding()
        .modelContainer(container)
}

#Preview("ItemRow - Completed") {
    let container = PreviewStore.container()
    let context = container.mainContext
    let item = ShoppingItem(name: "Milk 2L", category: .milk, isCompleted: true)
    context.insert(item)

    return ItemRow(item: item)
        .padding()
        .modelContainer(container)
}
