//
//  ContactListViewModel.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import Foundation
import UIKit

class ContactListViewModel : NSObject {
    
    private var dataService : DataService!
    
    var contactListData : [Contact] = []
    
    //MARK: - Initialisation
    override init() {
        super.init()
        self.dataService = DataService()
    }
    
    //MARK: - API functions
    func getContactListData() {
        self.contactListData = self.dataService.getContactListData() ?? []
    }
}

