//
//  Articles.swift
//  PulseLive
//
//  Created by Metricell Developer on 27/02/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import Foundation

struct Articles {
    var id : Int
    var title : String
    var subTitle : String
    var date : String
    var body: String? = ""
    
    init(id: Int, title: String, subTitle: String, date: String, body: String?){
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.date = date
        self.body = body
    }
    
    init?(dictionary: [String: Any]?){
        guard let dictionary = dictionary,
            let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String,
            let subTitle = dictionary["subtitle"] as? String,
            let date = dictionary["date"] as? String,
            let body = dictionary["body"] as? String?
        else {
                return nil
        }
        
        self.init(id: id, title: title, subTitle: subTitle, date: date, body: body)
    }
    
    init?(){
        return nil
    }
}
