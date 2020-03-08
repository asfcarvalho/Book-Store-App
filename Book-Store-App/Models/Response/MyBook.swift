//
//  MyBook.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

struct MyBook {
    let id: String?
    let imageLink: String?
    let title: String?
    let authors: String?
    let description: String?
    let buyLink: String?
    
    static func getMyBookFavorite(_ myBookList: [MyFavoriteBook]) -> [MyBook] {
        return myBookList.map { (item: MyFavoriteBook) -> MyBook in
            return MyBook(id: item.id, imageLink: item.imageLink, title: item.title, authors: item.authors, description: item.descriptionBook, buyLink: item.buyLink)
        }
    }
}
