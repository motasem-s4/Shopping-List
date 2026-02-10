//
//  Shopping_ListApp.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import SwiftUI
import SwiftData

@main
struct Shopping_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ShoppingListView()
                .preferredColorScheme(.light) 
        }
        .modelContainer(for: ShoppingItem.self)
    }
}
