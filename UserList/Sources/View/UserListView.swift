import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel = UserListViewModel()
    @State private var isLoading = false
    @State private var isGridView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !isGridView {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            HStack {
                                AsyncImageView(user: user, frameSize: 50)
                                
                                VStack(alignment: .leading) {
                                    Text("\(user.name.first) \(user.name.last)")
                                        .font(.headline)
                                    Text("\(user.dob.date)")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchMoreUsers(user: user)
                        }
                    }
                }else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(viewModel.users) { user in
                                NavigationLink(destination: UserDetailView(user: user)) {
                                    VStack {
                                        AsyncImageView(user: user, frameSize: 150)
                                        
                                        Text("\(user.name.first) \(user.name.last)")
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .onAppear {
                                    viewModel.fetchMoreUsers(user: user)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchUsers()
            }
            .navigationTitle("Users")
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    PickerView(viewModel: viewModel, isGridView: $isGridView)
                }
            })
        }
    }
}


struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
