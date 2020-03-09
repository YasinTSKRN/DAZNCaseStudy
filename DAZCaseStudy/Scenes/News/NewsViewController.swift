//
//  ViewController.swift
//  DAZCaseStudy
//
//  Created by yasin on 4.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit
import Alamofire
import FeedKit
import SafariServices

class NewsViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: NewsViewModalProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = NewsViewModal()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.fetchNews(completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
            let article = self.viewModel.articleAtIndex(atIndex: indexPath.row)
            cell.configureCell(article: article)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.viewModel.articleAtIndex(atIndex: indexPath.row).link
        self.openUrlWithSafariVC(url)
    }
    
}

extension NewsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    fileprivate func openUrlWithSafariVC(_ urlstring:String) {
        if let url = URL(string: urlstring) {
            let sfvc = SFSafariViewController(url: url)
            sfvc.delegate = self
            self.present(sfvc, animated: true, completion: nil)
        }
    }
}
