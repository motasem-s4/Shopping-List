//
//  ItemCategory.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import Foundation
import SwiftUI

enum ItemCategory: String, CaseIterable, Identifiable, Codable {
    case milk = "Milk"
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case breads = "Breads"
    case meats = "Meats"

    var id: String { rawValue }
    
    var systemImage: String {
        switch self {
        case .milk: return "cup.and.saucer.fill"
        case .vegetables: return "leaf.fill"
        case .fruits: return "apple.logo"
        case .breads: return "bag.fill"
        case .meats: return "fork.knife"
        }
    }
    
    var color: Color {
         switch self {
         case .milk: return Color(.milk)
         case .vegetables: return Color(.vegetables)
         case .fruits: return Color(.fruits)
         case .breads: return Color(.breads)
         case .meats: return Color(.meats)
         }
     }

     var softBackground: Color {
         color.opacity(0.12)
     }
}
