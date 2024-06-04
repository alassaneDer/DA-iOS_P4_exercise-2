//
//  AsyncImageView.swift
//  UserList
//
//  Created by Alassane Der on 26/05/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let user: User
    var frameSize: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frameSize, height: frameSize)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .frame(width: frameSize, height: frameSize)
                .clipShape(Circle())
        }
    }
}
