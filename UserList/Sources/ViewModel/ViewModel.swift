//
//  ViewModel.swift
//  UserList
//
//  Created by Alassane Der on 25/05/2024.
//

import Foundation

class UserListViewModel: ObservableObject {

    private let repository = UserListRepository()


    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var isGridView = false
    

    private func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }
    
    
    func fetchMoreUsers(user: User) {
        if shouldLoadMoreData(currentItem: user) {
            fetchUsers()
        }
    }
    
    func fetchUsers() {
        isLoading = true
        Task {
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                self.users.append(contentsOf: users)
                isLoading = false
            } catch {
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }
    
    func reloadUsers() {
        users.removeAll()
        fetchUsers()
    }
}
