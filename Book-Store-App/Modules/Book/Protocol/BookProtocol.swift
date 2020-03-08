//
//  BookProtocol.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

protocol BookViewProtocol {
    var viewController: BookVCProtocol? { get set }
    
    func showBookDetail(_ myBook: MyBook?)
    func isFavorite(_ status: Bool)
}

protocol BookVCProtocol {
    var bookView: BookView? { get set }
    var presenter: BookPresenterProtocol? { get set }
    
    func showBookDetail(_ myBook: MyBook?)
    func buyLinkClick()
    func isFavorite(_ status: Bool)
    func favoriteAction()
}

protocol BookPresenterProtocol {    
    var viewController: BookVCProtocol? { get set }
    var whireFrame: BookWireFrameProtocol? { get set }
    var dataModule: BookDataModuleInputProtocol? { get set }
    var myBook: MyBook? { get set }
    
    func viewDidLoad()
    func buyLinkClick()
    func favoriteAction()
}

protocol BookWireFrameProtocol {
    static func createViewController(_ myBook: MyBook?) -> UIViewController
    
    func showBuyLink(from viewController: BookVCProtocol?, _ link: String?)
    func showAlert(from viewController: BookVCProtocol?, message: String)
}

protocol BookDataModuleInputProtocol {
    var presenter: BookDataModuleOutputProtocol? { get set }
    
    func favoriteBook(_ myBook: MyBook?)
    func removeFavoriteBook(_ id: String)
    func isFavorite(_ id: String)
}

protocol BookDataModuleOutputProtocol: class {
    
    func onSuccess()
    func onError(_ error: String)
    
    func onRemoveSuccess()
    func onRemoveError(_ error: String)
    
    func onFavoriteSuccess(_ isFavorite: Bool)
    func onFavoriteError(_ error: String)
}
