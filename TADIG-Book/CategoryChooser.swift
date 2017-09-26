//
//  CategoryChooser.swift
//  TADIG-Book
//
//  Created by Jagni Dasa Horta Bezerra on 25/09/17.
//  Copyright © 2017 Jagni. All rights reserved.
//

import Foundation
import UIKit
import KUIPopOver

class CategoryChooser : UITableViewController, KUIPopOverUsable {
    
    @IBOutlet weak var currentCategory: UILabel!
    var library : LibraryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCategory.text = selectedCategory
    }
    
    var contentSize: CGSize {
        // PopOver preferredContentSize
        return CGSize(width: 300, height: 400)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        library.reShuffle()
        self.dismissPopover(animated: true)
    }
    
}

class ChapterChooser : UITableViewController, KUIPopOverUsable {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var contentSize: CGSize {
        // PopOver preferredContentSize
        return CGSize(width: 300, height: 175)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        self.dismissPopover(animated: true)
    }
    
}
