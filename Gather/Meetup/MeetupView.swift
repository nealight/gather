//
//  MeetupView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI
import MapKit

struct MeetupView: View {
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 42.4534,
                        longitude: -76.4735),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("John Appleseed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                ProfileView()
            }.padding()
            
            Map(coordinateRegion: $region)
            
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
