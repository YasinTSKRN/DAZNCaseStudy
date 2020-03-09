//
//  ArticleCell.swift
//  DAZCaseStudy
//
//  Created by yasin on 8.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {

    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var teaserLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(article: Article) {
        if let url = URL(string: article.imageURL) {
            self.articleImage.kf.setImage(with: url)
        }
        self.headerLabel.text = article.title
        self.teaserLabel.text = article.text
        self.publishDateLabel.text = article.date.description
    }
}
