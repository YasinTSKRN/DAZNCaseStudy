//
//  Score.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import Foundation

struct Score {
    let inTeam: String
    let inScore: String
    let outTeam: String
    let outScore: String
    
    init(inTeam: String, inScore: String, outTeam: String, outScore: String) {
        self.inTeam = inTeam
        self.inScore = inScore
        self.outTeam = outTeam
        self.outScore = outScore
    }
}
