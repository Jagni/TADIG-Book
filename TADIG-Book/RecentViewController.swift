//
//  RecentViewController.swift
//  TADIG-Book
//
//  Created by Jagni Dasa Horta Bezerra on 25/09/17.
//  Copyright © 2017 Jagni. All rights reserved.
//

import Foundation
import UIKit
import ZoomTransition

class RecentViewController : UICollectionViewController, ZoomTransitionProtocol {
    var selectedBookImage : UIImageView!
    var animationController : ZoomTransition!
    
    func viewForTransition() -> UIView {
        return selectedBookImage
    }
    
    var books = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        for _ in 0...5{
            books.append("\(Int(arc4random_uniform(5) + 1))")
        }
        
        self.collectionView?.alpha = 0
        self.updateCollectionViewLayout()
        self.collectionView?.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.collectionView?.alpha = 1
        }
        
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "book", for: indexPath) as! BookCell
        cell.cover.image = UIImage(named: books[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BookCell
        self.selectedBookImage = cell.cover
        
        if let navigationController = self.navigationController {
            self.animationController = ZoomTransition(navigationController: navigationController)
        }
        self.navigationController?.delegate = animationController
        
        // present view controller
        let readController = self.storyboard!.instantiateViewController(withIdentifier: "read") as! ReadViewController
        readController.image = selectedBookImage.image
        self.navigationController?.pushViewController(readController, animated: true)
    }
    
    func updateCollectionViewLayout() {
        let width = collectionView!.bounds.width
        
        var hcount = 3
        var itemSpacing = CGFloat(-24)
        
        let gapcount = CGFloat(hcount) + 1
        let kwidth = width - itemSpacing*gapcount
        let keywidth = kwidth/CGFloat(hcount) - itemSpacing
        let height = keywidth*1.6
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width:self.collectionView!.frame.width-32, height:self.collectionView!.frame.height)
            layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
            layout.minimumInteritemSpacing = itemSpacing
            layout.minimumLineSpacing = itemSpacing
            layout.sectionHeadersPinToVisibleBounds = true
            layout.invalidateLayout()
        }
    }
    
}
