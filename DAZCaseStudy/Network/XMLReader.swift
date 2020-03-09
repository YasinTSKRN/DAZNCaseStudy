//
//  XMLReader.swift
//  DAZCaseStudy
//
//  Created by yasin on 8.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

enum XMLFeed{
    case success(XMLIndexer)
    case failure(String)
}

class XMLReader {
    func readXML(feedURL: String, completion: @escaping (XMLFeed) -> Void) {
        let request = AF.request(feedURL)
        request.responseData { (result) in
            if let data = result.data {
                let xml = SWXMLHash.parse(data)
                completion(.success(xml))
            } else {
                completion(.failure("Failed to parse XML"))
            }
        }
    }
}
