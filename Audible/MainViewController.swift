//
//  ViewController.swift
//  Audible
//
//  Created by Stef on 4/6/17.
//  Copyright © 2017 Stef. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Views variables
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //MARK: - maybe i can do with delegate method?????
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0)
        
        return pageControl
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0), for: .normal)
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0), for: .normal)
        
        return button
    }()
    
    //MARK: - there is always better place and name for this
    fileprivate let cellId = "CellId"
    fileprivate let pages: [Page] = {
        let firstPage = Page(imageName: "page1",
                             title: "Share a great listen",
                             text: "It's free to send your books to the people in your life. Every recipient's first book is on us.")
        let secondPage = Page(imageName: "page2",
                              title: "Send from your library",
                              text: "Tap the More menu next to any book. Choose \"Send this Book\"")
        let thirdPage = Page(imageName: "page3",
                             title: "Send from the player",
                             text: "Tap the More menu in the upper corner. Choose \"Send this Book\"")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    //MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    //MARK: - UI things
    private func configureCollectionView() {
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        //page control anchors
        NSLayoutConstraint.activate(
            [pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
             pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
             pageControl.heightAnchor.constraint(equalToConstant: 30.0)])
        //CV anchors
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: view.topAnchor), collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor), collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        //buttons anchors
        NSLayoutConstraint.activate(
            [skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
             skipButton.leftAnchor.constraint(equalTo: view.leftAnchor),
             skipButton.widthAnchor.constraint(equalToConstant: 60.0),
             skipButton.heightAnchor.constraint(equalToConstant: 50.0)])
        NSLayoutConstraint.activate(
            [nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
             nextButton.rightAnchor.constraint(equalTo: view.rightAnchor),
             nextButton.widthAnchor.constraint(equalToConstant: 60.0),
             nextButton.heightAnchor.constraint(equalToConstant: 50.0)])
    }
}

//MARK: - CollectionView stuff
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.page = pages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
