//
//  ShoppingItem.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import Foundation
import SwiftData

@Model
final class ShoppingItem {
    var name: String
    var categoryRaw: String
    var isCompleted: Bool
    var createdAt: Date

    init(name: String, category: ItemCategory, isCompleted: Bool = false) {
        self.name = name
        self.categoryRaw = category.rawValue
        self.isCompleted = isCompleted
        self.createdAt = Date()
    }

    var category: ItemCategory {
        get { ItemCategory(rawValue: categoryRaw) ?? .milk }
        set { categoryRaw = newValue.rawValue }
    }
}
