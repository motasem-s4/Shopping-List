//
//  CategoryFilter.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//


import SwiftUI
import SwiftData

enum CategoryFilter: Identifiable, Equatable, Hashable {
    case all
    case category(ItemCategory)

    var id: String {
        switch self {
        case .all: return "all"
        case .category(let c): return c.rawValue
        }
    }

    var title: String {
        switch self {
        case .all: return "All"
        case .category(let c): return c.rawValue
        }
    }
}
