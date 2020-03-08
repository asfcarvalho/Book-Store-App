//
//  VolumeInfo.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title, subtitle: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}
