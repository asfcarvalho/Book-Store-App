//
//  ListBookDataModule.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ListBookDataModule: ListBookDataModuleInputProtocol {
    weak var interactor: ListBookDataModuleOutputProtocol?
    
    let pageSize = 20
    
    func bookFetch(_ search: String, _ page: Int) {
        let apiRequest = APIRequest()
        let searchString = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let stringURL = String(format: "\(URLDdefault)volumes?q=%@&maxResults=%i&startIndex=%i", searchString, pageSize, page)
        apiRequest.baseURL = URL(string: stringURL)
        
        APICalling<Book>().fetch(apiRequest: apiRequest) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.interactor?.onError(error.localizedDescription)
                break
            case .success(let book):
                self?.interactor?.onSuccess(book)
                break
            }
        }
    }
}
