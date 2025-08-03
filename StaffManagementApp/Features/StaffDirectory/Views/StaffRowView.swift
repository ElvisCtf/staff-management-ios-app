//
//  StaffRowView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

struct StaffRowView: View {
    var staff: User
    
    var body: some View {
        HStack() {
            ProfileImageView(url: URL(string: staff.avatar)!)
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(staff.firstName + " " + staff.lastName)
                    .font(.system(size: 17, weight: .semibold))
                Text(staff.email)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(.leading, 16)
            
            Spacer()
        }
        .padding(4)
    }
}

#Preview {
    let staff = User(
        id: 1,
        email: "abc@gmail.com",
        firstName: "Peter",
        lastName: "Chan",
        avatar: "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250"
    )
    StaffRowView(staff: staff)
}
