//
//  RSSReader.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation
import FeedKit

enum RSS{
    case success(Feed)
    case failure(Error)
}

class RSSReader {
    func readFeed(feedURL: String, completion: @escaping (RSS) -> Void) {
        let parser = FeedParser(URL: URL(string: feedURL)!)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                completion(.success(feed))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
