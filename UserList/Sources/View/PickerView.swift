//
//  ToolbarView.swift
//  UserList
//
//  Created by Alassane Der on 26/05/2024.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var viewModel: UserListViewModel = UserListViewModel()
    @Binding var isGridView: Bool

    var body: some View {
        HStack { 
            // le picker
            Picker(selection: $isGridView, label: Text("Display")) {
                Image(systemName: "rectangle.grid.1x2.fill")
                    .tag(true)
                    .accessibilityLabel(Text("Grid view"))
                Image(systemName: "list.bullet")
                    .tag(false)
                    .accessibilityLabel(Text("List view"))
            }
            .pickerStyle(SegmentedPickerStyle())

            // reloader
            Button(action: {
                self.viewModel.reloadUsers()
            }) {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    PickerView(isGridView: .constant(false))
}
