//
//  BookVC.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class BookVC: UIViewController {
    
    var presenter: BookPresenterProtocol?
    var bookView: BookView?

    override func viewDidLoad() {
        super.viewDidLoad()

        bookView = BookView(frame: view.frame)
        bookView?.viewController = self
        
        view = bookView
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Book Detail"
    }
    
    func favoriteAction() {
        presenter?.favoriteAction()
    }
}
    
extension BookVC: BookVCProtocol {
    func isFavorite(_ status: Bool) {
        bookView?.isFavorite(status)
    }
    
    func buyLinkClick() {
        presenter?.buyLinkClick()
    }    
    
    func showBookDetail(_ myBook: MyBook?) {
        bookView?.showBookDetail(myBook)
    }
}
