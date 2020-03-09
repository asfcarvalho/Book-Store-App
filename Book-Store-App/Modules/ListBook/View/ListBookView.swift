//
//  ListBookView.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ListBookView: UIView {
    
    var viewController: ListBookVCProtocol?
    private let cellName = "cell"
    
    let lineView = UIView()
    let favoriteView = UIView()
    let favoriteSwitch = UISwitch()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.text = "ios"
        search.showsCancelButton = true
        search.enablesReturnKeyAutomatically = false
        return search
    }()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Show only favorite"
        return label
    }()
    
    let favoriteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        let size = self.frame.size
        layout.itemSize = CGSize(width: (size.width * 0.5) - 20, height: (size.width * 0.65))
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.bounces = false
        return collection
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        searchBar.delegate = self
        
        favoriteSwitch.addTarget(self, action: #selector(favoriteSwitchAction(_:)), for: UIControl.Event.touchUpInside)
        
        favoriteStackView.addArrangedSubview(favoriteLabel)
        favoriteStackView.addArrangedSubview(favoriteSwitch)
        
        favoriteView.addSubviews([favoriteStackView,
                                  lineView])
        
        collectionView.register(ListBookCell.self, forCellWithReuseIdentifier: cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        
        backgroundColor = .white
        favoriteView.backgroundColor = .white        
        collectionView.backgroundColor = .white
        lineView.backgroundColor = .lightGray
        
        addSubviews([searchBar,
                     favoriteView,
                     collectionView])
        
        setupAnchors()
    }
    
    private func setupAnchors() {
        
        searchBar
            .topToSuperview(margin: 0, toSafeView: true)
            .leadingToSuperview()
            .trailingToSuperview()
        
        favoriteView
            .topToBottom(of: searchBar)
            .leadingToSuperview()
            .trailingToSuperview()
        
        favoriteStackView
            .topToSuperview(margin: 8, toSafeView: false)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 8)
        
        favoriteLabel
            .centerY(of: favoriteSwitch)
        
        lineView
            .heigth(1)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
        
        collectionView
            .topToBottom(of: favoriteView)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
    }
    
    @objc func favoriteSwitchAction(_ sender: UISwitch) {
        hideKeyboard()
        let search = searchBar.text ?? ""
        viewController?.showOnlyFavorite(search, favoriteSwitch.isOn)
    }
    
    private func hideKeyboard() {
        endEditing(true)
    }
}

extension ListBookView: ListBookViewProtocol {
    
    func showBookList() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ListBookView: UICollectionViewDataSource, UICollectionViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController?.getBookCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? ListBookCell else {
            return UICollectionViewCell()
        }
        
        let bookItem = viewController?.getBookItem(indexPath)
        
        cell.awakeFromNib()
        
        cell.setupCell(bookItem?.imageLink)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        endEditing(true)
        viewController?.showDetail(indexPath)
    }
    
}

extension ListBookView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewController?.callNextPage(indexPaths)
    }
}

extension ListBookView: UISearchBarDelegate {
    
    private func searchAction(_ search: String) {
        hideKeyboard()
        viewController?.bookSearch(search)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let search = searchBar.text ?? ""
        searchAction(search)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchBar.text ?? ""
        if viewController?.showOnlyFavorite() == true && search.isEmpty {
            searchAction(search)
        }
    }
}
