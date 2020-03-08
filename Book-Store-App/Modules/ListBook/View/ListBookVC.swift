//
//  ListBookVC.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ListBookVC: UIViewController {
    
    var listBookView: ListBookView?
    var presenter: ListBookPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Books"
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        
        listBookView = ListBookView(frame: view.frame)
        listBookView?.viewController = self
        view = listBookView
    }
    
    func callNextPage(_ indexPath: [IndexPath]) {
        presenter?.callNextPage(indexPath)
    }
    
    func showDetail(_ indexPath: IndexPath) {
        presenter?.showDetail(indexPath)
    }
    
    func showOnlyFavorite(_ onlyFavorite: Bool) {
        presenter?.showOnlyFavorite(onlyFavorite)
    }
}

extension ListBookVC: ListBookVCProtocol {
    
    func getNextMaxPage() -> Int {
        return presenter?.getNextMaxPage() ?? 0
    }
    
    func getBookCount() -> Int {
        return presenter?.getBookCount() ?? 0
    }
    
    func getBookItem(_ indexPath: IndexPath) -> MyBook? {
        return presenter?.getBookItem(indexPath)
    }
    
    func showBookList() {
        listBookView?.showBookList()
    }
    
    func showLoading() {
        Loading.shared.showLoading(view)
    }
    
    func stopLoading() {
        Loading.shared.stopLoading()
    }
}
