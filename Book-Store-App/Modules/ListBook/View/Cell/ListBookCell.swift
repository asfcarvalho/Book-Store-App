//
//  ListBookCell.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ListBookCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 0.3
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = 6
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(_ url: String?) {
        backgroundColor = .white
                
        imageView.loadImageWith(url: url, showPlaceholder: true)
        
        addSubviews([imageView])
        
        imageView.edgeToSuoerView()
    }
}
