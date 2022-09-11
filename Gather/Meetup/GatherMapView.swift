//
//  GatherMapView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI
import MapKit

struct GatherMapView: View {
    @StateObject private var viewModel = GatherMapViewModel()
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 42.4534,
                        longitude: -76.4735),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .cornerRadius(15.0)
            .padding()
            .onAppear(perform: viewModel.checkLocationAuthorization)
    }
}

struct GatherMapView_Previews: PreviewProvider {
    static var previews: some View {
        GatherMapView()
    }
}
