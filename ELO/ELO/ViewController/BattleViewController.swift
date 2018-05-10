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
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    fileprivate(set) var viewModel: KingBattleViewModel?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiaLizeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initiateFetchBattleDetails()
    }
    
    // MARK: - Custom Objects Intialization
    
    private func initiaLizeViewModel() {
        if nil == viewModel {
            viewModel = KingBattleViewModel()
            
            viewModel?.networkRequestCompletion = {
                SVProgressHUD.dismiss()
                self.reloadTable()
            }
        }
    }
    
    // MARK: - UI Action
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        refreshViewModel()
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

// MARK: - UITableViewDataSource

extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfKingListViewModels() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: KingTableViewCell.self)) as! KingTableViewCell
        
        let kingListViewModel = viewModel!.kingListViewModel(at: indexPath.row)
        
        cell.setViewModel(kingListViewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BattleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let king = viewModel!.kingViewModel(at: indexPath.row)
        navigateToKingDetails(king)
    }
}



// MARK: - DataSource
extension BattleViewController {
    func initiateFetchBattleDetails() {
        SVProgressHUD.show()
        viewModel?.fetchBattleDetails()
    }
    
    func refreshViewModel() {
        viewModel = nil
        
        initiaLizeViewModel()
        initiateFetchBattleDetails()
    }
}

// MARK: - Navigation
extension BattleViewController {
    func navigateToKingDetails(_ king: King) {
        let kingDetailViewModel = KingDetailViewModel(king: king)
        
        let kingDetailViewController = KingDetailViewController.newInstance()
        kingDetailViewController.setViewModel(kingDetailViewModel)
        
        self.navigationController?.pushViewController(kingDetailViewController, animated: true)
    }
}
