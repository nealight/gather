//
//  Location.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import Foundation
import CoreLocation
import UIKit
import SwiftUI

struct ActiveUser: Identifiable {
    var id: String = UUID().uuidString
    var coordinates: CLLocationCoordinate2D
    var image: ProfileSnapshotView?
}
