//
//  MeetupView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI


struct MeetupView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("John Appleseed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                ProfileView()
            }.padding()
            
            GatherMapView()
            
            Spacer()
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Image("sample_profile")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

struct MeetupView_Previews: PreviewProvider {
    static var previews: some View {
        MeetupView()
    }
}
