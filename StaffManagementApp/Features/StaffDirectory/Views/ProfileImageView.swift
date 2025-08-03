//
//  ProfileImageView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

struct ProfileImageView: View {
    let url: URL?
    let size: CGFloat

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.blue)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(size / 2)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: size, height: size)
            @unknown default:
                EmptyView()
            }
        }
    }
}

