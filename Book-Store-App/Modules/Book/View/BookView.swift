//
//  BookView.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class BookView: UIView {

    var viewController: BookVCProtocol?
    
    let favoriteView = UIView()
    let lineView = UIView()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let favoriteButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "favorite"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "unfavorite"), for: UIControl.State.highlighted)
        button.isHighlighted = true
        return button
    }()
    
    let favoriteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let scrolView = UIScrollView()
        scrolView.bounces = false
        return scrolView
    }()
    
    let viewBody = UIView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let size = self.frame.size
        let imageFrame = CGRect(x: 0, y: 0, width: (size.width * 0.5) - 20, height: size.width * 0.65)
        let image = UIImageView(frame: imageFrame)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 0.1
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = 6
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let buyLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        viewBody.backgroundColor = .white
        scrollView.backgroundColor = .white
        favoriteView.backgroundColor = .white
                
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(buyLinkLabel)
        
        viewBody.addSubviews([imageView,
                              stackView])
        
        scrollView.addSubviews([viewBody])
        
        favoriteView.addSubviews([lineView])
        favoriteLabel.text = "Favorite"
        favoriteButton.addTarget(self, action: #selector(favoriteBookAction), for: UIControl.Event.touchUpInside)
        
        lineView.backgroundColor = .lightGray
        
        favoriteStackView.addArrangedSubview(favoriteLabel)
        favoriteStackView.addArrangedSubview(favoriteButton)
        
        favoriteView.addSubviews([favoriteStackView])
        
        addSubviews([favoriteView,
                     scrollView])
        
        setupAnchors()
    }
    
    private func setupAnchors() {
        
        favoriteView
            .topToSuperview(margin: 0, toSafeView: true)
            .leadingToSuperview()
            .trailingToSuperview()
        
        lineView
            .heigth(1)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
        
        favoriteStackView
            .topToSuperview(margin: 4, toSafeView: false)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 8)
            .heigth(30)
        
        favoriteButton
            .topToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
            .width(30)
        
        favoriteLabel
            .centerY(of: favoriteButton)
    
        scrollView
            .topToBottom(of: favoriteView)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 16)
        
        viewBody
            .widthEqual(of: scrollView)
            .topToSuperview()
            .centerX(of: self)
            .bottomToSuperview()
        
        imageView.topToSuperview(margin: 16).centerX(of: self).width((self.frame.size.width * 0.5) - 20).heigth(self.frame.size.width * 0.65)
        
        stackView.topToBottom(of: imageView, margin: 16)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 16)
    }
    
    @objc func buyClickAction() {
        viewController?.buyLinkClick()
    }
    
    @objc func favoriteBookAction() {
        viewController?.favoriteAction()
    }
}

extension BookView: BookViewProtocol {
    
    func showBookDetail(_ myBook: MyBook?) {
        
        imageView.loadImageWith(url: myBook?.imageLink, showPlaceholder: true)
        
        titleLabel.text = "Title\n"
        titleLabel.setupFont(myBook?.title ?? "")
        
        authorLabel.text = "Authors\n"
        authorLabel.setupFont(myBook?.authors ?? "")
        
        descriptionLabel.text = "Description\n"
        descriptionLabel.setupFont(myBook?.description ?? "")
        
        if myBook?.buyLink != nil {
            buyLinkLabel.text = "BuyLink\n"
            buyLinkLabel.setupLink("Buy here", "Buy here")
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(buyClickAction))
            buyLinkLabel.addGestureRecognizer(tap)
            buyLinkLabel.isUserInteractionEnabled = true
        }
        
        
    }
    
    func isFavorite(_ status: Bool) {
        DispatchQueue.main.async {
            self.favoriteButton.isHighlighted = !status
            self.favoriteLabel.text = status ? "Is Favorite" : "Favorite"
        }
    }
}
