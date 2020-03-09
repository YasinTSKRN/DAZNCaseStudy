//
//  PageCell.swift
//  DAZCaseStudy
//
//  Created by yasin on 8.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit

class PageCell: UITableViewCell {

    @IBOutlet weak var pageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(page: String) {
        self.pageLabel.text = page
    }
}
