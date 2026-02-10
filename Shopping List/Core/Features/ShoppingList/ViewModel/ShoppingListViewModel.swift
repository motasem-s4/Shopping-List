//
//  ShoppingListViewModel.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//


import Foundation
import SwiftData
import Combine

@MainActor
class ShoppingListViewModel: ObservableObject {

    // MARK: - UI State
    @Published var name: String = ""
    @Published var selectedCategory: ItemCategory = .milk
    @Published var filter: CategoryFilter = .all
    @Published var editingItem: ShoppingItem?

    // MARK: - Data
    @Published private(set) var items: [ShoppingItem] = []

    private var context: ModelContext?

    // MARK: - Setup
    func setContext(_ context: ModelContext) {
        self.context = context
        refresh()
    }

    // MARK: - CRUD
    func addItem() {
        guard let context else { return }

        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let newItem = ShoppingItem(name: trimmed, category: selectedCategory)
        context.insert(newItem)

        name = ""
        refresh()
    }

    func delete(_ item: ShoppingItem) {
        guard let context else { return }
        context.delete(item)
        refresh()
    }

    func toggleCompleted(_ item: ShoppingItem) {
        item.isCompleted.toggle()
        refresh()
    }

    func startEditing(_ item: ShoppingItem) {
        editingItem = item
    }

    // MARK: - Fetch / Refresh
    func refresh() {
        guard let context else { return }

        do {
            let descriptor = FetchDescriptor<ShoppingItem>(
                sortBy: [SortDescriptor(\.createdAt, order: .forward)]
            )
            items = try context.fetch(descriptor)
        } catch {
            debugPrint("Failed to fetch items: \(error)")
            items = []
        }
    }

    // MARK: - Filter + Group
    var filterIcon: String {
        filter == .all ?
              "line.3.horizontal.decrease.circle" :
                "line.3.horizontal.decrease.circle.fill"
    }
    
    var filteredItems: [ShoppingItem] {
        switch filter {
        case .all:
            return items
        case .category(let c):
            return items.filter { $0.categoryRaw == c.rawValue }
        }
    }

    var groupedItems: [ItemCategory: [ShoppingItem]] {
        Dictionary(grouping: filteredItems, by: { $0.category })
    }

    var groupedKeys: [ItemCategory] {
        ItemCategory.allCases.filter { groupedItems[$0]?.isEmpty == false }
    }

    var isAddDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
