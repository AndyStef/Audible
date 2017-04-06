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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    //MARK: - there is always better place and name for this
    fileprivate let cellId = "CellId"
    
    //MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    //MARK: - UI things
    private func configureCollectionView() {
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: view.topAnchor), collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor), collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}

//MARK: - CollectionView stuff
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
