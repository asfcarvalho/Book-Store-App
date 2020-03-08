//
//  BookDetailTests.swift
//  Book-Store-AppTests
//
//  Created by Anderson F Carvalho on 08/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import XCTest
@testable import Book_Store_App

class BookDetailTests: XCTestCase {
    
    var presenter: BookPresenter?
    var dataModule: BookDataModule?
    var mockDataModuleOutput: MockDataModuleOutput?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        presenter = BookPresenter()
        dataModule = BookDataModule()
        mockDataModuleOutput = MockDataModuleOutput()
        
        presenter?.dataModule = dataModule
        dataModule?.presenter = mockDataModuleOutput
        
        presenter?.myBook = MyBook(id: "123", imageLink: nil, title: nil, authors: "Author 1;Author 2", description: nil, buyLink: nil)
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MockDataModuleOutput: BookDataModuleOutputProtocol {
        
        var isFavorite: Bool?
        
        func onSuccess() {
            isFavorite = true
        }
        
        func onError(_ error: String) {
            
        }
        
        func onRemoveSuccess() {
            isFavorite = false
        }
        
        func onRemoveError(_ error: String) {
            
        }
        
        func onFavoriteSuccess(_ isFavorite: Bool) {
            self.isFavorite = isFavorite
        }
        
        func onFavoriteError(_ error: String) {
            
        }
        
        
    }

    func testIsFavoriteOnLoad() {
        presenter?.favoriteAction()
        presenter?.viewDidLoad()
        
        XCTAssertTrue(mockDataModuleOutput?.isFavorite == true)
        removeAllData()
    }
    
    func testSetFavorite() {
        
        presenter?.favoriteAction()
        
        XCTAssertTrue(mockDataModuleOutput?.isFavorite == true, "The bookmark function is not valid")
        removeAllData()
    }
    
    func testRemoveFavorite() {
        
        presenter?.favoriteAction()
        presenter?.isFavorite = true
        presenter?.favoriteAction()
        
        XCTAssertTrue(mockDataModuleOutput?.isFavorite == false, "The bookmark remove function is not valid")
        removeAllData()
    }
    
    //Just for Unit test
    private func removeAllData() {
        LocalDataModule.share.deleteData("123", callBack: { (error) in
            if let error = error {
                print(error)
            }
        })
    }
}
