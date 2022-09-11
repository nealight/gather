//
//  MeetupView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI


struct MeetupView: View {
    @State private var showProfile = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("John Appleseed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                ProfileImageView()
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .sheet(isPresented: $showProfile, content: {ProfileView()})
                    .onTapGesture {
                        showProfile = true
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
