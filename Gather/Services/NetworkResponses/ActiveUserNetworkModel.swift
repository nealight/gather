//
//  ActiveUserNetworkModel.swift
//  Gather
//
//  Created by Yi Xu on 9/24/22.
//

import Foundation

struct ActiveUserNetworkModel: Codable {
    let user_name: String
    let profile_avatar: String?
    let description: String?
    let my_x_coordinate: Double
    let my_y_coordinate: Double
}
