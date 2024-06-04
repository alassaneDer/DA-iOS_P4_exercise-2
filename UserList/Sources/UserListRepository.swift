import Foundation

struct UserListRepository {

    private let executeDataRequest: (URLRequest) async throws -> (Data, URLResponse)

    init(
        executeDataRequest: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    ) {
        self.executeDataRequest = executeDataRequest
    }

    func fetchUsers(quantity: Int) async throws -> [User] {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .GET,
            parameters: [
                "results": quantity
            ]
        )

        let (data, _) = try await executeDataRequest(request)

        let response = try JSONDecoder().decode(UserListResponse.self, from: data)
        
        return response.results.map(User.init)
    }
    
}

//    // rajoutons ici les autres func pour voir
//    var users: [User] = []
//    var isLoading = false
//    var isGridView = false
//    var quantit: Int = 2
//
//
//    func shouldLoadMoreData(currentItem item: User) -> Bool {
//        guard let lastItem = users.last else { return false }
//        return !isLoading && item.id == lastItem.id
//    }
//
//    func fetchMoreUsers(user: User) async throws {
//        if shouldLoadMoreData(currentItem: user) {
//            try await fetchUsers(quantity: quantit)
//        }
//    }
//    mutating func reloadUsers() async throws {
//        users.removeAll()
//        try await fetchUsers(quantity: quantit)
//    }
//
