//
//  CategoryChip.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import SwiftUI

struct CategoryChip: View {
    // MARK: - Attributes
    let category: ItemCategory
    let isSelected: Bool

    // MARK: - UI
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: category.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(isSelected ? .white : category.color)

            Text(category.id)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(isSelected ? .white : category.color)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(width: 58, height: 58)
        .background(isSelected ? .blue : category.softBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Previews
#Preview("Not Selected") {
    CategoryChip(category: .meats, isSelected: false)
}

#Preview("Selected") {
    CategoryChip(category: .meats, isSelected: true)
}
