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
//    //MARK: - Popular Article API
//    func apiToGetPopularArticle(type: String, completion : @escaping (Articles?, Error?) -> Void) {
//        let sourcesURL = URL(string: "\(commonUrlHeader)mostpopular/v2/\(type)/7.json?api-key=\(apiKey)")!
//            
//        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
//            if let data = data {
//                do {
//                    let jsonDecoder = JSONDecoder()
//                    let empData =  try jsonDecoder.decode(Articles.self, from: data)
//                    completion(empData, nil)
//                } catch {
//                    // Catch the error and handle it.
//                    completion(nil, error)
//                }
//            }
//        }.resume()
//    }

    
    

    func getContactListData() -> [ContactList]? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ContactList].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
