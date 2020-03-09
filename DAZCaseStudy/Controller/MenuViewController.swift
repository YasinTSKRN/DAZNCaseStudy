//
//  MenuViewController.swift
//  DAZCaseStudy
//
//  Created by yasin on 7.03.2020.
//  Copyright © 2020 yt. All rights reserved.
//

import UIKit

enum PageState {
    case news
    case scores
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var listButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageSelectionView: UIView!
    
    private var state: PageState = PageState.news
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private lazy var newsViewController: NewsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "NewsViewController") as! NewsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var scoresViewController: ScoresViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "ScoresViewController") as! ScoresViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private func setupView() {
        self.setupPageView()
        self.setupSegmentedControl()
        self.updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "News", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Scores", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
        self.state = PageState.news
        
        segmentedControl.isHidden = true
    }
    
    private func setupPageView() {
        self.pageSelectionView.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        self.state = PageState.news
        if self.segmentedControl.selectedSegmentIndex == 1 {
            self.state = PageState.scores
        }
        updateView()
    }
    @IBAction func listButtonAction(_ sender: Any) {
        self.pageSelectionView.isHidden = !self.pageSelectionView.isHidden
        if !self.pageSelectionView.isHidden {
            self.view.bringSubviewToFront(self.pageSelectionView)
        }
    }
    
    private func updateView() {
        if self.state == PageState.news {
            self.remove(asChildViewController: self.scoresViewController)
            self.add(asChildViewController: self.newsViewController)
        } else {
            self.remove(asChildViewController: self.newsViewController)
            self.add(asChildViewController: self.scoresViewController)
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as? PageCell {
            let page = indexPath.row == 0 ? "News" : "Scores"
            cell.configureCell(page: page)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.state = PageState.news
        if indexPath.row == 1 {
            self.state = PageState.scores
        }
        self.pageSelectionView.isHidden = true
        self.updateView()
    }
    
}
