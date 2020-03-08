//
//  UIView+anchors.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit

enum NSLayoutEnum {
    case top,
    bottom,
    leading,
    trailing
}

extension UIView {
    
    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        for view in views {
            view.autoResizingOff()
            self.addSubview(view)
        }
        return self
    }

    @discardableResult
    func autoResizingOff() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func edgeToSuoerView(_ edges: UIEdgeInsets = UIEdgeInsets.zero) -> Self {
        leadingToSuperview(margin: edges.left)
        topToSuperview(margin: edges.top)
        trailingToSuperview(margin: edges.right)
        bottomToSuperview(margin: edges.bottom)
        return self
    }
    
    @discardableResult
    func aspectRation(_ multiplier: CGFloat) -> Self {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: multiplier, constant: 0).isActive = true
        return self
    }
    
    @discardableResult
    func anchorSize(to view: UIView) -> Self {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return self
    }
    
    @discardableResult
    func leadingToSuperview(margin: CGFloat = 0.0) -> Self {
        guard let superView = superview else { return self}
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func topToSuperview(margin: CGFloat = 0.0, toSafeView: Bool = false) -> Self {
        guard let constraint = toSafeView ? superview?.safeAreaLayoutGuide.topAnchor : superview?.topAnchor else { return self }
        
        topAnchor.constraint(equalTo: constraint, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func trailingToSuperview(margin: CGFloat = 0.0) -> Self {
        guard let superView = superview else { return self }
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -margin).isActive = true
        return self
    }
    
    @discardableResult
    func bottomToSuperview(margin: CGFloat = 0.0) -> Self {
        guard let superView = superview else { return self }
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -margin).isActive = true
        return self
    }
    
    @discardableResult
    func leadingToLeading(of element: UIView, margin: CGFloat = 0.0) -> Self {
        leadingAnchor.constraint(equalTo: element.leadingAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func topToTop(of element: UIView, margin: CGFloat = 0.0) -> Self {
        topTo(nsLayout: .top, of: element, margin: margin)
        return self
    }
    
    @discardableResult
    func topToBottom(of element: UIView, margin: CGFloat = 0.0) -> Self {
        topTo(nsLayout: .bottom, of: element, margin: margin)
        return self
    }
    
    @discardableResult
    private func topTo(nsLayout: NSLayoutEnum, of element: UIView, margin: CGFloat = 0.0) -> Self {
        if nsLayout == .top {
            topAnchor.constraint(equalTo: element.topAnchor, constant: margin).isActive = true
        } else {
            topAnchor.constraint(equalTo: element.bottomAnchor, constant: margin).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func trailingToTrailing(of element: UIView, margin: CGFloat = 0.0) -> Self {
        trailingAnchor.constraint(equalTo: element.trailingAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func bottomToBotton(of element: UIView, margin: CGFloat = 0.0) -> Self {
        bottomAnchor.constraint(equalTo: element.safeAreaLayoutGuide.bottomAnchor, constant: -margin).isActive = true
        return self
    }
    
    @discardableResult
    func heigth(_ height: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        if height != 0 {
            if relation == .equal {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            } else if relation == .greaterThanOrEqual {
                heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
            } else {
                heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        if width != 0 {
            if relation == .equal {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            } else if relation == .greaterThanOrEqual {
                widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
            } else {
                widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
            }
            
        }
        return self
    }
    
    @discardableResult
    func widthEqual(of element: UIView) -> Self {
        widthAnchor.constraint(equalTo: element.widthAnchor, multiplier: 1.0).isActive = true
        return self
    }
    
    @discardableResult
    func centerY(of element: UIView) -> Self {
        centerYAnchor.constraint(equalTo: element.centerYAnchor, constant: 0.0).isActive = true
        return self
    }
    
    @discardableResult
    func centerX(of element: UIView) -> Self {
        centerXAnchor.constraint(equalTo: element.centerXAnchor, constant: 0.0).isActive = true
        return self
    }
}
