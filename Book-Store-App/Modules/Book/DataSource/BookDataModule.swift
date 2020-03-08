//
//  BookDataSource.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

class BookDataModule: BookDataModuleInputProtocol {

    weak var presenter: BookDataModuleOutputProtocol?
    
    func favoriteBook(_ myBook: MyBook?) {
        LocalDataModule.share.createData(myBook) { (error) in
            if error == nil {
                presenter?.onSuccess()
            } else {
                presenter?.onError(error ?? "")
            }
        }
    }
    
    func removeFavoriteBook(_ id: String) {
        LocalDataModule.share.deleteData(id) { (error) in
            if error == nil {
                presenter?.onRemoveSuccess()
            } else {
                presenter?.onRemoveError(error ?? "")
            }
        }
    }
    
    func isFavorite(_ id: String) {
        LocalDataModule.share.fetchData(id) { (bookList) in
            if let bookList = bookList {
                presenter?.onFavoriteSuccess(bookList.count > 0)
            } else {
                presenter?.onFavoriteError("Error on get status if isFavorite")
            }
        }
    }
}
