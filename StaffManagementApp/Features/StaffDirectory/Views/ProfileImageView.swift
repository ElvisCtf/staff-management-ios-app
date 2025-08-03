//
//  ProfileImageView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

struct ProfileImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.blue)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
            @unknown default:
                EmptyView()
            }
        }
    }
}

