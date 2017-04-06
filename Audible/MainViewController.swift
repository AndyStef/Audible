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
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = self.pages.count + 1
        pageControl.currentPageIndicatorTintColor = UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0)
        
        return pageControl
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(skipAllPages), for: .touchUpInside)
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.setTitleColor(UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1.0), for: .normal)
        
        return button
    }()
    
    //MARK: - Constraints 
    fileprivate var pageControlBottomAnchor: NSLayoutConstraint?
    fileprivate var skipButtonTopAnchor: NSLayoutConstraint?
    fileprivate var nextButtonTopAnchor: NSLayoutConstraint?
    
    //MARK: - there is always better place and name for this
    fileprivate let cellId = "CellId"
    fileprivate let loginCellId = "LoginCellId"
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
        
        registerCells()
        configureCollectionView()
        observeKeyboardNotification()
    }
    
    private func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow() {
        UIView.animate(withDuration: 0.5) { 
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    //MARK: - UI things
    private func configureCollectionView() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        //page control anchors
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate(
            [pageControlBottomAnchor!,
             pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
             pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
             pageControl.heightAnchor.constraint(equalToConstant: 30.0)])
        //CV anchors
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: view.topAnchor), collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor), collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        //buttons anchors
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0)
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0)
        
        //FIXME: - remove force unwraps
        NSLayoutConstraint.activate(
            [skipButtonTopAnchor!,
             skipButton.leftAnchor.constraint(equalTo: view.leftAnchor),
             skipButton.widthAnchor.constraint(equalToConstant: 60.0),
             skipButton.heightAnchor.constraint(equalToConstant: 50.0)])
        NSLayoutConstraint.activate(
            [nextButtonTopAnchor!,
             nextButton.rightAnchor.constraint(equalTo: view.rightAnchor),
             nextButton.widthAnchor.constraint(equalToConstant: 60.0),
             nextButton.heightAnchor.constraint(equalToConstant: 50.0)])
    }
    
    fileprivate func registerCells() {
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }
}

//MARK: - Actions
extension MainViewController {
    func hideControlsWithAnimations() {
        pageControl.currentPage = pages.count
        pageControlBottomAnchor?.constant = 40.0
        skipButtonTopAnchor?.constant = -32.0
        nextButtonTopAnchor?.constant = -32.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func skipAllPages() {
        let indexPath = IndexPath(item: pages.count, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        hideControlsWithAnimations()
    }
    
    func nextPage() {
        if pageControl.currentPage == pages.count {
            return
        }
        
        if pageControl.currentPage == pages.count - 1 {
            hideControlsWithAnimations()
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
}

//MARK: - CollectionView stuff
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            
            return loginCell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.page = pages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        //animating things out
        if pageNumber == pages.count {
            pageControlBottomAnchor?.constant = 40.0
            skipButtonTopAnchor?.constant = -32.0
            nextButtonTopAnchor?.constant = -32.0
        } else {
            pageControlBottomAnchor?.constant = 0.0
            skipButtonTopAnchor?.constant = 16.0
            nextButtonTopAnchor?.constant = 16.0
        }
    
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
