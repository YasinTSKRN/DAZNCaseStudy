//
//  ScoreCell.swift
//  DAZCaseStudy
//
//  Created by yasin on 8.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var inTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var outTeamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(score: Score) {
        self.inTeamLabel.text = score.inTeam
        self.outTeamLabel.text = score.outTeam
        self.scoreLabel.text = score.inScore + "-" + score.outScore
    }
    
    func setDarkerCell() {
        self.inTeamLabel.backgroundColor = UIColor.lightGray
        self.outTeamLabel.backgroundColor = UIColor.lightGray
    }

}
