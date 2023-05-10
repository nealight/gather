//
//  DependencyResolver.swift
//  Gather
//
//  Created by Yi Xu on 5/9/23.
//

import Foundation

class DependencyResolver {
    static let shared = DependencyResolver()
    
    private init() {
        self.register(type: UserService.self, service: UserService())
    }
    
    var services: Dictionary<String, Any> = [:]
    
    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"] as? Service
    }
}
