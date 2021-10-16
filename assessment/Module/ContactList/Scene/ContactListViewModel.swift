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
    private(set) var contactListData : [ContactList] = [] {
        didSet {
            self.bindContactListViewModelToController()
        }
    }
    
    var bindContactListViewModelToController : (() -> ()) = {}
    var apiError: String = "No data found"
    
    //MARK: - Initialisation
    override init() {
        super.init()
        self.dataService = DataService()
    }
    
    //MARK: - API functions
    func callFuncToGetData() {
        self.contactListData = self.dataService.getContactListData() ?? []
    }
    
//    func callFuncToSearchArticleData(searchText: String) {
//        var articles = [ArticleData]()
//
//        self.apiService.apiToSearchArticle(searchText: searchText) { (data, error) in
//            if let data = data {
//                for article in data.responseData.docs {
//                    let arData = ArticleData(title: article.headline.main, published_date: self.serverToLocal(date: article.published_date) )
//                    articles.append(arData)
//                }
//                self.articleData = articles
//            }
//            else {
//                self.articleData = []
//                self.apiError = error?.localizedDescription ?? "No data found"
//            }
//        }
//    }
    
    //MARK: - Helper
    func serverToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)!

        let dateString = DateFormatter.localizedString(
            from: localDate,
            dateStyle: .medium,
            timeStyle: .medium)
        
        return dateString
    }
}

