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
                
                ProfileSnapshotView(name: "John Appleseed", image: Image("sample_profile"))
                    .frame(width: 50, height: 50, alignment: .trailing)
                

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
