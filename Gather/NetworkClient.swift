//
//  NetworkClient.swift
//  mesh
//
//  Created by Yi Xu on 12/10/21.
//

import Foundation
import Alamofire

class NetworkClient {
    let remoteDomain = "https://gather.dashu.coffee/"
    
    public func buildURL(uri: String) -> String {
        return NetworkClient.shared.remoteDomain + uri;
    }

    let session: Session
    
    private init() {
        session = Session()
    }

    public static let shared = NetworkClient()
  
}
