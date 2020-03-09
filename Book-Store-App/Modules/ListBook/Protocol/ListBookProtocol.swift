//
//  ListBookProtocol.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

protocol ListBookViewProtocol {
    var viewController: ListBookVCProtocol? { get set }
    
    func showBookList()
}

protocol ListBookVCProtocol {
    var listBookView: ListBookView? { get set }
    var presenter: ListBookPresenterProtocol? { get set }
    
    func bookSearch(_ search: String)
    func showOnlyFavorite(_ search: String, _ onlyFavorite: Bool)
    func showDetail(_ indexPath: IndexPath)
    func callNextPage(_ indexPath: [IndexPath])
    func getBookCount() -> Int
    func getBookItem(_ indexPath: IndexPath) -> MyBook?
    func showOnlyFavorite() -> Bool
    func showBookList()
    func showLoading()
    func stopLoading()
}

protocol ListBookPresenterProtocol {
    
    var viewController: ListBookVCProtocol? { get set }
    var wireFrame: ListBookWireFrameProtocol? { get set }
    var interactor: ListBookInteractorInputProtocol? { get set }
    
    func bookSearch(_ search: String)
    
    func showOnlyFavorite(_ search: String, _ onlyFavorite: Bool)
    func showDetail(_ indexPath: IndexPath)
    func getNextMaxPage() -> Int
    func callNextPage(_ indexPath: [IndexPath])
    func getBookCount() -> Int
    func getBookItem(_ indexPath: IndexPath) -> MyBook?
    func showOnlyFavorite() -> Bool
}

protocol ListBookInteractorInputProtocol {
    var dataModule: ListBookDataModuleInputProtocol? { get set }
    var presenter: ListBookInteractorOutputProtocol? { get set }
    
    func bookFetch(_ search: String, _ onlyFavorite: Bool, _ page: Int)
}

protocol ListBookInteractorOutputProtocol {
    func onSuccess(_ myBookList: [MyBook]?, _ pageCount: Int?)
    func onError(_ error: String)
}

protocol ListBookWireFrameProtocol {
    static func createViewController() -> UIViewController
    
    func showAlert(from viewController: ListBookVCProtocol?, message: String)
    func showDetail(from viewController: ListBookVCProtocol?, item: MyBook?)
}

protocol ListBookDataModuleInputProtocol {
    var interactor: ListBookDataModuleOutputProtocol? { get set }
    func bookFetch(_ search: String, _ page: Int)
}

protocol ListBookDataModuleOutputProtocol: class {
    func onSuccess(_ book: Book?)
    func onError(_ error: String)
}
