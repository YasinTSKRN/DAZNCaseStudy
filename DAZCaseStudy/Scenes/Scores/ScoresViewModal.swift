//
//  ScoresViewModal.swift
//  DAZCaseStudy
//
//  Created by yasin on 8.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

private let rssURL = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/scores.xml"

protocol ScoresViewModalProtocol {
    func fetchScores(completion:(()->())?)
    func numberOfScores() -> Int
    func scoreAtIndex(atIndex: Int) -> Score
    func scoreDate() -> String
}

enum Keys: String {
    case gsmrs
    case method
    case parameter
    case name
    case value
    case competition
    case season
    case round
    case group
    case match
}

class ScoresViewModal: NSObject, ScoresViewModalProtocol {
    
    private lazy var xmlReader = XMLReader.init()
    private var scores: [Score] = []
    private var date: String = ""
    
    func fetchScores(completion: (() -> ())?) {
        self.date = ""
        self.scores.removeAll()
        self.xmlReader.readXML(feedURL: rssURL) { [unowned self] (result) in
            switch (result) {
            case .success(let xml):
                let root = xml[Keys.gsmrs]
                let parameters = root[Keys.method].children
                for parameter in parameters {
                    if parameter.element?.attribute(by: Keys.name)?.text == "date" {
                        self.date = parameter.element?.attribute(by: Keys.value)?.text ?? ""
                    }
                }
                let groups = root[Keys.competition][Keys.season][Keys.round][Keys.group].children
                for match in groups {
                    let inTeam = match.element?.attribute(by: "team_A_name")?.text ?? ""
                    let outTeam = match.element?.attribute(by: "team_B_name")?.text ?? ""
                    let inScore = match.element?.attribute(by: "fs_A")?.text ?? ""
                    let outScore = match.element?.attribute(by: "fs_B")?.text ?? ""
                    let score = Score(inTeam: inTeam, inScore: inScore, outTeam: outTeam, outScore: outScore)
                    self.scores.append(score)
                }
                completion?()
            case .failure(let error):
                print(error)
                completion?()
            }
        }
    }
    
    func numberOfScores() -> Int {
        return self.scores.count
    }
    
    func scoreAtIndex(atIndex: Int) -> Score {
        return self.scores[atIndex]
    }
    
    func scoreDate() -> String {
        return self.date
    }
}
