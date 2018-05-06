//
//  KingBattleViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation
import UIKit

class KingBattleViewModel: NSObject {
    // MARK: - Properties
    fileprivate (set) var kings: [King] = []
    fileprivate (set)  var cellViewModels: [KingListViewModel] = []
    
    var completion: (() -> ()) = {}
}

// MARK: - Networking function + related
extension KingBattleViewModel {
    func fetchBattleDetails() {
        guard let urlRequest = getUrlRequestForBattleDetails() else { return }
        let battleInfoService = BattleInfoService()
        
        SVProgressHUD.show()
        
        battleInfoService.executeRequest(urlRequest) { (data, response, error) in
            SVProgressHUD.dismiss()
            
            weak var weakSelf = self
            
            if nil != error {
                debugPrint("Error fetching the battle info: \(String(describing: error?.localizedDescription)) -- @ \(#function, #line)")
            }
            guard let urlResponse = response,
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return }
            if nil != data && Constants.Network.Status.OK == statusCode {
                if let battles = BattleParser.getBattlesFromData(data!),
                    let kings = BattleKingMap.mapKingToBattles(battles) {
                    weakSelf?.kings = kings // Append
                    
                    weakSelf?.setCellViewModels()
                    
                    weakSelf?.sendCompletion()
                }
            }
        }
    }
    
    private func getUrlRequestForBattleDetails() -> URLRequest? {
        if let url = URL.init(string: Constants.Network.baseURL + Constants.Network.Endpoint.battleInfo) {
            var urlRequest = URLRequest.init(url: url)
            urlRequest.httpMethod = Constants.Network.HttpMethod.get
            return urlRequest
        }
        return nil
    }
}

// MARK: - Cell View Model
extension KingBattleViewModel {
    fileprivate func setCellViewModels() {
        for king in kings {
            let viewModel = KingListViewModel()
            var attributes: [String: String] = [:]
            attributes[Constants.Cell.Attributes.kingName] = king.name
            attributes[Constants.Cell.Attributes.eloScore] = String(format: "%.2f", king.eloScore)
            attributes[Constants.Cell.Attributes.wins] = "\(king.battlesWon)"
            attributes[Constants.Cell.Attributes.losses] = "\(king.battlesLost)"
            attributes[Constants.Cell.Attributes.attacks] = "\(king.attacks)"
            attributes[Constants.Cell.Attributes.defenses] = "\(king.defenses)"

            viewModel.setAttributes(attributes)
            
            cellViewModels.append(viewModel)
        }
        debugPrint("")
    }
}

// MARK: - UITableViewDataSource
extension KingBattleViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: KingTableViewCell.self)) as! KingTableViewCell
        cell.setViewModel(cellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension KingBattleViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(#function)
    }
}

// MARK:- UI Refresh
extension KingBattleViewModel {
    fileprivate func sendCompletion() {
        completion()
    }
}
