//
//  DataDownloader.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import Foundation

struct DataDownloader {
    
    init?(){
        return nil
    }
    
    public static func getContentList(articlesList: [Articles], getBody: Bool, completionHandler:@escaping(_ result:[Articles]) -> Void) {
        if (!getBody){
            let task = URLSession.shared.dataTask(with: Constants.contentListUrl) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                print("SUCCESS - GET request data obtained")
                DataParser.parseContentList(data: data){ result in
                    if (result.isEmpty){
                        print("FAIL - Problem occured parsing data")
                    } else {
                        print("SUCCESS - Parsed content list")
                        completionHandler(result)
                    }
                }
            }
            task.resume()
            print("GET Request to obtain initial content list - \(Constants.contentListUrl)")
        } else {
            var bodyObtainedList = [Articles]()
            for article in articlesList {
                guard let url = URL(string: String(format: Constants.contentListBodyURL, article.id)) else { return }
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let data = data else { return }
                    print("SUCCESS - GET request data obtained")
                    DataParser.parseArticleBody(data: data){ result in
                        if (result.body == nil){
                            print("FAIL - Problem occured parsing body for article \(article.id)")
                        } else {
                            print("SUCCESS - Parsed body for article \(article.id)")
                            bodyObtainedList.append(result)
                            if (bodyObtainedList.count == articlesList.count){
                                completionHandler(bodyObtainedList)
                            }
                        }
                    }
                }
                task.resume()
                print("GET Request to obtain body for article \(article.id) - \(Constants.contentListUrl)")
            }
        }
    }
    
    
}
