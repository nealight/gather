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

struct ActiveUser: Identifiable, Equatable, Hashable {
    static func == (lhs: ActiveUser, rhs: ActiveUser) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
    }
    
    var id: String = "unamed user"
    var coordinates: CLLocationCoordinate2D
    var image: ProfileSnapshotView?
    var description: String?
}
