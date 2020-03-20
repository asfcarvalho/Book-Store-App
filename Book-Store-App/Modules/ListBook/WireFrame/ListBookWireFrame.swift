//
//  ListBookWireFrame.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ListBookWireFrame: ListBookWireFrameProtocol {
    class func createViewController() -> UIViewController {
        
        var presenter: ListBookPresenterProtocol & ListBookInteractorOutputProtocol = ListBookPresenter()
        var dataModule: ListBookDataModuleInputProtocol = ListBookDataModule()
        let wireFrame: ListBookWireFrameProtocol = ListBookWireFrame()
        var interactor: ListBookInteractorInputProtocol & ListBookDataModuleOutputProtocol = ListBookInteractor()
        
        let viewController = ListBookVC()
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.dataModule = dataModule
        dataModule.interactor = interactor
        
        
        return viewController
    }
    
    func showAlert(from viewController: ListBookVCProtocol?, message: String) {
        if let viewController = viewController as? UIViewController {
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func showDetail(from viewController: ListBookVCProtocol?, item: MyBook?) {
        
        if let viewController = viewController as? UIViewController {
            let bookVC = BookWireFrame.createViewController(item)
            DispatchQueue.main.async {
                viewController.navigationController?.pushViewController(bookVC, animated: true)
            }            
        }
    }
}
