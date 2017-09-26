//
//  ReadViewController.swift
//  TADIG-Book
//
//  Created by Jagni Dasa Horta Bezerra on 25/09/17.
//  Copyright © 2017 Jagni. All rights reserved.
//

import Foundation
import UIKit
import ZoomTransition

class ReadViewController : UIViewController, ZoomTransitionProtocol {
    var image : UIImage!
    @IBOutlet var pagesView : UIView!
    @IBOutlet var transitionView : UIImageView!
    
    override func viewDidLoad() {
        self.transitionView.image = image
    }
    
    @IBAction func didTapChapter(_ sender: UIBarButtonItem) {
        let customViewController = self.storyboard?.instantiateViewController(withIdentifier: "chapter") as! ChapterChooser
        customViewController.showPopover(barButtonItem: sender)
    }
    
    func viewForTransition() -> UIView {
        return transitionView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            self.transitionView.alpha = 1
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.125, options: [.curveEaseInOut], animations: {
            self.transitionView.alpha = 0
        }, completion: nil)
    }
}
