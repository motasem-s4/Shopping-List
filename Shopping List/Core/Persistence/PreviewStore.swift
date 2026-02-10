//
//  PreviewStore.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//


import SwiftUI
import SwiftData

@MainActor
enum PreviewStore {

    static func container() -> ModelContainer {
        let schema = Schema([ShoppingItem.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }

    static func makeItems(in context: ModelContext) {
        let samples: [ShoppingItem] = [
            .init(name: "Milk 2L", category: .milk, isCompleted: false),
            .init(name: "Tomatoes", category: .vegetables, isCompleted: true),
            .init(name: "Bananas", category: .fruits, isCompleted: false),
            .init(name: "Bread", category: .breads, isCompleted: false),
            .init(name: "Chicken", category: .meats, isCompleted: true)
        ]
        samples.forEach { context.insert($0) }
    }
}
