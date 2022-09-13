//
//  PersonalProfileViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import Foundation
import PhotosUI
import SwiftUI

class PersonalProfileViewModel: ObservableObject {
    @State public var selectedItem: PhotosPickerItem? = nil
    @State public var selectedImageData: Data? = nil
    
}
