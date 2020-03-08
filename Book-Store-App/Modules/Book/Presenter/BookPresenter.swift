//
//  BookPresenter.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class BookPresenter: BookPresenterProtocol {
    
    var myBook: MyBook?
    var viewController: BookVCProtocol?
    var whireFrame: BookWireFrameProtocol?
    var dataModule: BookDataModuleInputProtocol?
    var isFavorite: Bool = false
    
    func viewDidLoad() {
        viewController?.showBookDetail(myBook)
        
        dataModule?.isFavorite(myBook?.id ?? "")
    }
    
    func buyLinkClick() {
        whireFrame?.showBuyLink(from: viewController, myBook?.buyLink)
    }
    
    func favoriteAction() {
        if isFavorite {
            dataModule?.removeFavoriteBook(myBook?.id ?? "")
        } else {
            dataModule?.favoriteBook(myBook)
        }
    }
}

extension BookPresenter: BookDataModuleOutputProtocol {
    func onFavoriteSuccess(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        viewController?.isFavorite(isFavorite)
    }
    
    func onFavoriteError(_ error: String) {
        whireFrame?.showAlert(from: viewController, message: error)
    }
    

    func onRemoveSuccess() {
        isFavorite = false
        viewController?.isFavorite(isFavorite)
    }
    
    func onRemoveError(_ error: String) {
        isFavorite = true
        viewController?.isFavorite(true)
        whireFrame?.showAlert(from: viewController, message: error)
    }
    
    func onSuccess() {
        isFavorite.toggle()
        viewController?.isFavorite(isFavorite)
    }
    
    func onError(_ error: String) {
        isFavorite = false
        viewController?.isFavorite(false)
        whireFrame?.showAlert(from: viewController, message: error)
    }
}
