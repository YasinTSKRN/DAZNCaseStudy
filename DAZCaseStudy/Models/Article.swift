//
//  Article.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation

struct Article {
    let title: String
    let text: String
    let date: Date
    let imageURL: String
    let link: String
    
    init(title: String, text: String, date: Date, imageURL: String, link: String) {
        self.title = title
        self.text = text
        self.date = date
        self.imageURL = imageURL
        self.link = link
    }
}
