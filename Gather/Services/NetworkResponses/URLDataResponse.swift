//
//  URLDataResponse.swift
//  Gather
//
//  Created by Yi Xu on 8/23/23.
//

import Foundation

struct URLDataResponse<DataModel> {
    var error: Error?
    var value: DataModel?
    
    func getDataModel() -> DataModel {
        return value!
    }
}
