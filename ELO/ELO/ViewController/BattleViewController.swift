//
//  ViewController.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/5/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 200.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    // MARK: - Properties
    fileprivate(set) var viewModel: KingBattleViewModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiaLizeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initiateFetchBattleDetails()
    }
    
    // MARK: - Custom Objects Intialization
    private func initiaLizeViewModel() {
        if nil == viewModel {
            viewModel = KingBattleViewModel()
            tableView.delegate  = viewModel
            tableView.dataSource = viewModel
            viewModel?.completion = {
                self.reloadTable()
            }
        }
    }
}

// MARK: - UI refresh
extension BattleViewController {
    fileprivate func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - DataSource
extension BattleViewController {
    func initiateFetchBattleDetails() {
        viewModel?.fetchBattleDetails()
    }
}
