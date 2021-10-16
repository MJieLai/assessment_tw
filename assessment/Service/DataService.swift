//
//  APIService.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import Foundation
import UIKit

class DataService :  NSObject {
        
    //Mark: - Get data from json file
    func getContactListData() -> [Contact]? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Contact].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
