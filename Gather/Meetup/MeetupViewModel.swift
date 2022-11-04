//
//  MeetupViewModel.swift
//  Gather
//
//  Created by Yi Xu on 11/2/22.
//

import Foundation
class MeetupViewModel: ObservableObject {
    public var personalProfileViewModel = PersonalProfileImageViewModel()
    
    func reloadView() {
        objectWillChange.send()
    }
}
