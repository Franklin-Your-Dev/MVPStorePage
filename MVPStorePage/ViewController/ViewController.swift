//
//  ViewController.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var content: [ExpandableContent] = ExpandableContent.generate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        configureTableView()
    }
}

class InnerTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: self.contentSize.width, height: self.contentSize.height)
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}
