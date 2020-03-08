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
    
    func bookFetch(_ page: Int) {
        let apiRequest = APIRequest()
        let stringURL = String(format: "\(URLDdefault)volumes?q=ios&maxResults=%i&startIndex=%i", pageSize, page)
        apiRequest.baseURL = URL(string: stringURL)
        
        APICalling().fetch(apiRequest: apiRequest) { [weak self] (result: Book?, error) in
            if let result = result, error == nil {
                self?.interactor?.onSuccess(result)
            }else {
                self?.interactor?.onError(error ?? "Error")
            }
        }
    }
}
