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
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    fileprivate(set) var viewModel: KingBattleViewModel? {
        didSet{
            // Reload Tableview
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom Objects Intialization
    private func initiaLizeViewModel() {
        if nil == viewModel {
            viewModel = KingBattleViewModel()
        }
    }
}
