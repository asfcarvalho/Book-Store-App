//
//  ListBookInteractor.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 08/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ListBookInteractor: ListBookInteractorInputProtocol {
    
    var dataModule: ListBookDataModuleInputProtocol?
    var presenter: ListBookInteractorOutputProtocol?
    
    private var bookList: [MyBook]?
    private var favoriteBookList: [MyBook]?
    private var lastSearch = ""
    
    func bookFetch(_ search: String, _ onlyFavorite: Bool, _ page: Int) {
        if onlyFavorite {
            LocalDataModule.share.fetchDataBy(search, callBack: { (bookList) in
                if let bookList = bookList {
                    favoriteBookList = MyBook.getMyBookFavorite(bookList)
                    presenter?.onSuccess(favoriteBookList ?? [], nil)
                } else {
                    presenter?.onError("Erron on list book")
                }
            })
        } else {
            if lastSearch != search {
                lastSearch = search
                bookList = nil
            }
            dataModule?.bookFetch(search, page)
        }
    }
}

extension ListBookInteractor: ListBookDataModuleOutputProtocol {
    func onSuccess(_ book: Book?) {
        let totalPageCount = book?.totalItems ?? 0
        
        let bookTemp = Book.getMyBookList(book?.items)
        
        if bookList == nil {
            bookList = bookTemp
        } else {
            bookList?.append(contentsOf: bookTemp ?? [])
        }
        
        presenter?.onSuccess(bookList, totalPageCount)
    }
    
    func onError(_ error: String) {
        presenter?.onError(error)
    }
}
