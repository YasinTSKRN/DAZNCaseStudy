//
//  NewsViewModal.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation

private let rssURL = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/latestnews.xml"

protocol NewsViewModalProtocol {
    func fetchNews(completion:(()->())?)
    func numberOfArticles() -> Int
    func articleAtIndex(atIndex: Int) -> Article
}

class NewsViewModal: NSObject, NewsViewModalProtocol {
    
    private lazy var rssReader = RSSReader.init()
    private var articles: [Article] = []
    
    func fetchNews(completion: (() -> ())?) {
        self.articles.removeAll()
        self.rssReader.readFeed(feedURL: rssURL) { [unowned self] (feed) in
            switch feed {
            case .success(let rssFeed):
                if let items = rssFeed.rssFeed?.items {
                    for item in items {
                        var title = ""
                        var text = ""
                        var link = ""
                        var date = Date()
                        var imageURL = ""
                        
                        if let rssTitle = item.title {
                            title = rssTitle
                        }
                        if let rssText = item.description {
                            text = rssText
                        }
                        if let rssLink = item.link {
                            link = rssLink
                        }
                        if let rssDate = item.pubDate {
                            date = rssDate
                        }
                        if let rssImageURL = item.enclosure?.attributes?.url {
                            imageURL = rssImageURL
                        }
                        let article = Article(title: title, text: text, date: date, imageURL: imageURL, link: link)
                        self.articles.append(article)
                    }
                }
            case .failure(let error):
                print(error)
            }
            completion?()
        }
    }
    
    func numberOfArticles() -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(atIndex: Int) -> Article {
        return self.articles[atIndex]
    }
}
