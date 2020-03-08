//
//  Book.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let kind: String?
    let totalItems: Int?
    let items: [Item]?
    
    static func getMyBookList(_ listBook: [Item]?) -> [MyBook]? {
        return listBook?.map({ (item) -> MyBook in
            let authors = item.volumeInfo?.authors?.joined(separator: ";\n")
            
            return MyBook(id: item.id, imageLink: item.volumeInfo?.imageLinks?.thumbnail, title: item.volumeInfo?.title, authors: authors, description: item.volumeInfo?.description, buyLink: item.saleInfo?.buyLink)
        })
    }
}


