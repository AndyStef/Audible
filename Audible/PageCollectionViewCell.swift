//
//  PageCollectionViewCell.swift
//  Audible
//
//  Created by Stef on 4/6/17.
//  Copyright © 2017 Stef. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        imageView.image = #imageLiteral(resourceName: "page1")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: topAnchor),
             imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
             imageView.leftAnchor.constraint(equalTo: leftAnchor),
             imageView.rightAnchor.constraint(equalTo: rightAnchor),])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
