//
//  PersonalProfileImageViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import Foundation
import SwiftUI

class PersonalProfileImageViewModel: ObservableObject {
    @State var profileImage: Image = Image("sample_profile")
    func updateProfileImage() {
        print("Start updating image to cloud server")
    }
    
}
