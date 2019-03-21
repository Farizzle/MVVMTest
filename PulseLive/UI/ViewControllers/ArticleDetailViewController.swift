//
//  ArticleDetailViewController.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSubTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleBody: UILabel!
    @IBOutlet weak var articleID: UILabel!
    
    var articleTitleString = String()
    var articleSubTitleString = String()
    var articleDateString = String()
    var articleBodyString = String()
    var articleIDNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(articleTitleString)"
        
        articleID.text = "\(articleIDNumber)"
        articleTitle.text = articleTitleString
        articleSubTitle.text = articleSubTitleString
        articleDate.text = articleDateString
        articleBody.text = articleBodyString
    }

}
