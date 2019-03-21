//
//  DataParser.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import Foundation

struct DataParser {
    public static func parseContentList(data: Data, completionHandler:@escaping(_ result:[Articles]) -> Void){
        print("Parsing content list raw data")
        var parsedArticlesList = [Articles]()
        let dataToString = String(data: data, encoding: .utf8)!
        var dictionary : [String : Any] = Tools.convertToDictionary(text: dataToString)!
        for values in dictionary.values {
            for article in (values as? [[String: Any]])!{
                parsedArticlesList.append(Articles.init(dictionary: article)!)
            }
        }
        completionHandler(parsedArticlesList)
    }
    
    public static func parseArticleBody(data: Data, completionHandler:@escaping(_ result:Articles) -> Void){
        print("Parsing body for article")
        let dataToString = String(data: data, encoding: .utf8)!
        var dictionary : [String : Any] = Tools.convertToDictionary(text: dataToString)!
        for values in dictionary.values {
            let bodyValues = values as! [String : Any]
            completionHandler((Articles.init(dictionary: bodyValues)!))
        }
    }
}
