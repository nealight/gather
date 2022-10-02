//
//  MeetupView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI


struct MeetupView: View {
    @State private var showPersonalProfile = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(UserService.shared.getUsername())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                ProfileSnapshotView(name: "John Appleseed", image: Image("sample_profile"), profileDetailShowable: false)
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .sheet(isPresented: $showPersonalProfile, content: {
                        PersonalProfileView()
                    })
                    .onTapGesture {
                        print("tapped on own personal profile")
                        showPersonalProfile = true
                    }

            }.padding()
            CentralMapView()
            Spacer()
        }
    }
}

struct MeetupView_Previews: PreviewProvider {
    static var previews: some View {
        MeetupView()
    }
}
