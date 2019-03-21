//
//  ViewController.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var dataDownloader = DataDownloader()
    var articles = [Articles]()
    @IBOutlet weak var contentListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Content List"
        obtainArticles()
    }
    
    func obtainArticles() {
        DataDownloader.getContentList(articlesList: articles, getBody: false) { result in
            self.articles = result
            DataDownloader.getContentList(articlesList: self.articles, getBody: true) { result in
                self.articles = result
                self.articles = ArticlesViewModel.ascendingArticles(articles: self.articles)
                DispatchQueue.main.async {
                    self.contentListCollectionView.reloadData()
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! ContentListCollectionViewCell
        cell.contentID.text = "\(articles[indexPath.row].id)"
        cell.contentTitle.text = articles[indexPath.row].title
        cell.contentSubTitle.text = articles[indexPath.row].subTitle
        cell.contentDate.text = articles[indexPath.row].date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        articleDetailsVC.articleIDNumber = articles[indexPath.row].id
        articleDetailsVC.articleTitleString = articles[indexPath.row].title
        articleDetailsVC.articleSubTitleString = articles[indexPath.row].subTitle
        articleDetailsVC.articleDateString = articles[indexPath.row].date
        articleDetailsVC.articleBodyString = articles[indexPath.row].body!
        self.navigationController?.pushViewController(articleDetailsVC, animated: true)
    }
}

