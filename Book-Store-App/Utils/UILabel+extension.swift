//
//  UILabel+extension.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setupFont(_ text: String) {
        guard let value = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: value)
        attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
        
        attributedText = attributedString
    }
    
    func setupLink(_ text: String, _ link: String) {
        guard let value = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: value)
        
        attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.link : link, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.blue]))
        
        attributedText = attributedString
    }
}
