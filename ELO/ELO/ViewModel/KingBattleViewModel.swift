//
//  KingBattleViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingBattleViewModel {
    // MARK: - Properties
    
    fileprivate var kings: [King] = []
    fileprivate var cellViewModels: [KingListViewModel] = []

    var networkRequestCompletion: (() -> ()) = {}
}

// MARK: - Networking function + related
extension KingBattleViewModel {
    func fetchBattleDetails() {
        guard let urlRequest = getUrlRequestForBattleDetails() else { return }
        
        let battleInfoService = BattleInfoService()
        
        battleInfoService.executeRequest(urlRequest) {[weak self] (data, response, error) in
            
            if nil != error {
                debugPrint("Error fetching the battle info: \(String(describing: error?.localizedDescription)) -- @ \(#function, #line)")
            }
            guard let urlResponse = response,
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return }
            if nil != data && Constants.Network.Status.OK == statusCode {
                if let battles = BattleParser.getBattlesFromData(data!),
                    let kings = BattleKingMap.mapKingToBattles(battles) {
                    self?.kings = kings // Append
                    
                    self?.buildAndSetCellViewModels()
                    
                    self?.sendCompletion()
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

// MARK: - TableView datasource helper functions

extension KingBattleViewModel {
    func numberOfKingListViewModels() -> Int {
        return cellViewModels.count
    }
    
    func kingListViewModel(at index: Int) -> KingListViewModel {
        return cellViewModels[index]
    }
    
    func kingViewModel(at index: Int) -> King {
        return kings[index]
    }
}

// MARK: - Cell View Model

extension KingBattleViewModel {
    fileprivate func buildAndSetCellViewModels() {
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
    }
}

// MARK:- UI Refresh

extension KingBattleViewModel {
    fileprivate func sendCompletion() {
        networkRequestCompletion()
    }
}
