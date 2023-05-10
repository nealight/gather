//
//  NetworkClient.swift
//  mesh
//
//  Created by Yi Xu on 12/10/21.
//

import Foundation
import Alamofire

class NetworkClient {
    let remoteDomain = "https://be823c7f-d539-431d-b953-9bd95d5b2851.mock.pstmn.io/"
//    let remoteDomain = "https://gather-axhwdjeqh0ewbjep.z01.azurefd.net/"
    
    public func buildURL(uri: String) -> String {
        return NetworkClient.shared.remoteDomain + uri;
    }
    
    public static let shared = NetworkClient()
  
}
