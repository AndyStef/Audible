//
//  PageCollectionViewCell.swift
//  Audible
//
//  Created by Stef on 4/6/17.
//  Copyright © 2017 Stef. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    //MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        return textView
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        return view
    }()
    
    //MARK: - model
    var page: Page? {
        didSet {
            guard let page = page else { return }
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1.0)
            // base attributed string - needs to be mutable
            let attributedText = NSMutableAttributedString(string: page.title, attributes:
                [NSFontAttributeName: UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightMedium),
                 NSForegroundColorAttributeName: color])
            //adding second part of attributed string
            attributedText.append(NSAttributedString(string: "\n\n\(page.text)",
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                             NSForegroundColorAttributeName: color]))
            
            //adding paragraph style to add center alignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let lenght = attributedText.string.characters.count
            attributedText.addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: NSRange(location: 0, length: lenght))
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(separatorLine)
        
        //image anchors
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: topAnchor),
             imageView.bottomAnchor.constraint(equalTo: textView.topAnchor),
             imageView.leftAnchor.constraint(equalTo: leftAnchor),
             imageView.rightAnchor.constraint(equalTo: rightAnchor),])
        //text anchors
        NSLayoutConstraint.activate(
            [textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
             textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
             textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        //separator anchors
        NSLayoutConstraint.activate(
            [separatorLine.heightAnchor.constraint(equalToConstant: 1.0),
             separatorLine.leftAnchor.constraint(equalTo: leftAnchor),
             separatorLine.rightAnchor.constraint(equalTo: rightAnchor),
             separatorLine.bottomAnchor.constraint(equalTo: textView.topAnchor),
             ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
