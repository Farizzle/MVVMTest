//
//  ArticlesViewModel.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import Foundation

struct ArticlesViewModel{
    
    public static func ascendingArticles(articles: [Articles]) -> [Articles]{
        return articles.sorted { $0.id < $1.id }
    }
}
