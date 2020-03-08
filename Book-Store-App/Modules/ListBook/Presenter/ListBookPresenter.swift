//
//  ListBookPresenter.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ListBookPresenter: ListBookPresenterProtocol {

    var viewController: ListBookVCProtocol?
    var wireFrame: ListBookWireFrameProtocol?
    var interactor: ListBookInteractorInputProtocol?

    var bookList: [MyBook]?
    private var page = 0
    private var totalPageCount = 0
    private var nextMaxPage = 20
    private let maxPage = 20
    private var onlyFavorite = false
    
    func viewDidLoad() {
        viewController?.showLoading()
        fetchData()
    }
    
    private func fetchData() {
        interactor?.bookFetch(onlyFavorite, page)
    }
    
    func callNextPage(_ indexPath: [IndexPath]) {
        if indexPath.last?.row == nextMaxPage - 1 && page <= totalPageCount && !onlyFavorite {
            page += maxPage
            nextMaxPage += maxPage
            fetchData()
        }
    }
    
    func getBookCount() -> Int {
        return bookList?.count ?? 0
    }
    
    func getBookItem(_ indexPath: IndexPath) -> MyBook? {
        return bookList?[indexPath.row]
    }
    
    func getNextMaxPage() -> Int {
        return nextMaxPage
    }
    
    func showDetail(_ indexPath: IndexPath) {
        let myBook = bookList?[indexPath.row]
        
        wireFrame?.showDetail(from: viewController, item: myBook)
    }
    
    func showOnlyFavorite(_ onlyFavorite: Bool) {
        
        viewController?.showLoading()
        
        self.onlyFavorite = onlyFavorite
        
        interactor?.bookFetch(onlyFavorite, page)
    }
    
    func showOnlyFavorite() -> Bool {
        return onlyFavorite
    }
}

extension ListBookPresenter: ListBookInteractorOutputProtocol {
    func onSuccess(_ myBookList: [MyBook]?, _ pageCount: Int?) {
        
        if let pageCount = pageCount {
            totalPageCount = pageCount
        }
        
        bookList = myBookList
        
        viewController?.showBookList()
        viewController?.stopLoading()
    }
    
    func onError(_ error: String) {
        viewController?.stopLoading()
        wireFrame?.showAlert(from: viewController, message: error)
    }
}
