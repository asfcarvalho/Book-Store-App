//
//  BookWireFrame.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class BookWireFrame: BookWireFrameProtocol {
    
    class func createViewController(_ myBook: MyBook?) -> UIViewController {
        
        var presenter: BookPresenterProtocol & BookDataModuleOutputProtocol = BookPresenter()
        presenter.myBook = myBook
        let whireFrame: BookWireFrameProtocol = BookWireFrame()
        var dataModule: BookDataModuleInputProtocol = BookDataModule()
        
        let viewController = BookVC()
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.whireFrame = whireFrame
        presenter.dataModule = dataModule
        dataModule.presenter = presenter
        
        return viewController
    }
    
    func showBuyLink(from viewController: BookVCProtocol?, _ link: String?) {
        
        guard let link = link,
            let url = URL(string: link),
            UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showAlert(from viewController: BookVCProtocol?, message: String) {
        if let viewController = viewController as? UIViewController {
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
