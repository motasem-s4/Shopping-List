//
//  ShoppingListView.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
    // MARK: - Attributes
    @Environment(\.modelContext) private var context
    @StateObject private var vm = ShoppingListViewModel()
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 12) {
                    Group {
                        header
                        
                        addSection
                    }
                    
                    if vm.filteredItems.isEmpty {
                        emptyState
                    } else {
                        listSection
                            .padding(.horizontal)
                    }
                }
                .sheet(item: $vm.editingItem) { item in
                    EditItemView(item: item)
                }
            }
            .overlay(alignment: .topTrailing) {
                filterView
            }
        }
        .onAppear {
            vm.setContext(context)
        }
    }
    
    // MARK: - Header
    private var header: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(.color1), Color(.color2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)
                
                Image(systemName: "cart.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            Text("Grocery List")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.black)
            
            Text("Add items to your shopping list")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
        }
        .padding(.top, 8)
    }
    
    // MARK: - Add Section
    private var addSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .leading) {
                LinearGradient(
                    colors: [Color(.color1), Color(.color2)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                
                Text("Add New Item")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
            }
            .frame(height: 52)
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Item Name")
                        .font(.system(size: 14, weight: .bold))
                    
                    TextField("Enter grocery item…", text: $vm.name)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading) {
                    Text("Category")
                        .font(.system(size: 14, weight: .bold))
                    
                    HStack(spacing: 10) {
                        ForEach(ItemCategory.allCases, id: \.self) { cat in
                            CategoryChip(
                                category: cat,
                                isSelected: cat == vm.selectedCategory
                            )
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    vm.selectedCategory = cat
                                }
                            }
                        }
                    }
                }
                
                Button {
                    vm.addItem()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isAddDisabled)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.10), radius: 18, x: 0, y: 10)
    }
    
    // MARK: - List Section
    private var listSection: some View {
        List {
            ForEach(vm.groupedKeys, id: \.self) { category in
                Section(category.rawValue) {
                    ForEach(vm.groupedItems[category] ?? []) { item in
                        ItemRow(item: item)
                            .contentShape(Rectangle())
                            .onTapGesture { vm.toggleCompleted(item) }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) { vm.delete(item) } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button { vm.editingItem = item } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
    
    // MARK: - Empty State
    private var emptyState: some View {
        ContentUnavailableView("Your grocery list is empty",
                               systemImage: "cart",
                               description: Text("Add items above to get started"))
    }
    
    // MARK: - Filter View
    private var filterView: some View {
        Menu {
            Picker("", selection: $vm.filter) {
                Text("All").tag(CategoryFilter.all)
                ForEach(ItemCategory.allCases) { category in
                    Text(category.id).tag(CategoryFilter.category(category))
                }
            }
        } label: {
            Label("Filter", systemImage: vm.filterIcon)
                .padding()
        }
    }
}

// MARK: - Previews
#Preview("ShoppingListView - With Data") {
    let container = PreviewStore.container()
    let context = container.mainContext
    PreviewStore.makeItems(in: context)
    
    return ShoppingListView()
        .modelContainer(container)
}

#Preview("ShoppingListView - Empty") {
    let container = PreviewStore.container()
    
    return ShoppingListView()
        .modelContainer(container)
}

