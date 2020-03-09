//
//  ScoresViewController.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: ScoresViewModalProtocol!
    @IBOutlet weak var tableView: UITableView!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ScoresViewModal()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateScores()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [unowned self] (timer) in
            self.updateScores()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func updateScores() {
        print("UPDATED")
        self.viewModel.fetchScores {
            self.tableView.reloadData()
        }
    }

}

extension ScoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfScores()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as? ScoreCell {
            let score = self.viewModel.scoreAtIndex(atIndex: indexPath.row)
            cell.configureCell(score: score)
            if indexPath.row % 2 == 1 {
                cell.setDarkerCell()
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.scoreDate()
    }
}
