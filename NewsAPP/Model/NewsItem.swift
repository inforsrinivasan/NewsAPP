//
//  NewsItem.swift
//  NewsAPP
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import Foundation

struct NewsItem:Decodable {
    var title:String
    var description:String?
}

struct NewsList:Decodable{
    var articles:[NewsItem]
}

extension NewsList{
    static var all:Resource<NewsList> = {
         let url = URL.init(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a9b0a70b40c7497fae2f6cff41567103")!
        return Resource(url: url)
    }()
}
