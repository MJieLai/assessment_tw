//
//  ContactListData.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import Foundation

struct ContactList: Decodable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    
    init(id: String, firstName: String, lastName: String, email: String, phone: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
}

//struct ResponseData: Decodable {
//    var contactList: [ContactList]
//}
