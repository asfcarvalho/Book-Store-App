//
//  BookListTests.swift
//  Book-Store-AppTests
//
//  Created by Anderson F Carvalho on 08/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import XCTest
@testable import Book_Store_App

class BookListTests: XCTestCase {
    
    var presenter: ListBookPresenter?
    var bookPresenter: BookPresenter?
    
    var interactor: ListBookInteractor?
    var mockInteractorOutput: MockInteractorOutput?
    var bookDataModule: BookDataModule?
    var dataModule: MockDataModuleInput?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        bookPresenter = BookPresenter()
        bookDataModule = BookDataModule()
        bookPresenter?.dataModule = bookDataModule
        
        presenter = ListBookPresenter()
        interactor = ListBookInteractor()
        dataModule = MockDataModuleInput()
        mockInteractorOutput = MockInteractorOutput()
        presenter?.interactor = interactor
        interactor?.dataModule = dataModule
        dataModule?.interactor = interactor
        interactor?.presenter = mockInteractorOutput
        
        let listMyBook = [MyBook(id: "123", imageLink: nil, title: nil, authors: "Author 1;Author 2", description: nil, buyLink: nil)]
        
        presenter?.bookList = listMyBook
        bookPresenter?.myBook = listMyBook.first
    }
    
    class MockInteractorOutput: ListBookInteractorOutputProtocol {
        
        var myBook: [MyBook]?
        var author: String?
        
        func onSuccess(_ myBookList: [MyBook]?, _ pageCount: Int?) {
            myBook = myBookList
            author = myBookList?.first?.authors
        }
        
        func onError(_ error: String) {
            
        }
    }
    
    class MockDataModuleInput: ListBookDataModuleInputProtocol {
        var interactor: ListBookDataModuleOutputProtocol?
        
        let bookMock = Book(kind: nil, totalItems: nil, items: [Item(id: "123", etag: nil, selfLink: nil, volumeInfo: VolumeInfo(title: nil, subtitle: nil, authors: ["Author 1", "Author 2"], description: nil, imageLinks: nil), saleInfo: nil)])
        
        func bookFetch(_ page: Int) {
            interactor?.onSuccess(bookMock)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOnlyFavorite() {
        bookPresenter?.favoriteAction()
        
        presenter?.showOnlyFavorite(true)
        
        XCTAssertTrue(mockInteractorOutput?.myBook?.count ?? 0 > 0)
        removeAllData()
    }

    func testAuthorIsCorrect() {
        presenter?.viewDidLoad()
        
        let modelAuthor = "Author 1;\nAuthor 2"
        
        XCTAssertEqual(modelAuthor, mockInteractorOutput?.author)
    }
    
    func testShowList() {
        presenter?.viewDidLoad()
        
        XCTAssertTrue(mockInteractorOutput?.myBook?.count ?? 0 > 0)
    }
    
    func testCallNextPage() {
        presenter?.viewDidLoad()
        presenter?.callNextPage([IndexPath(item: 19, section: 0)])
        
        XCTAssertTrue(mockInteractorOutput?.myBook?.count ?? 0 > 1)
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
