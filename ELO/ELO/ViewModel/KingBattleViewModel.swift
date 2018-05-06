//
//  KingBattleViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingBattleViewModel: NSObject {
    // MARK: - Properties
    fileprivate (set) var kings: [King] = []
}

// MARK: - Networking function + related
extension KingBattleViewModel {
    func fetchBattleDetails() {
        guard let urlRequest = getUrlRequestForBattleDetails() else { return }
        let battleInfoService = BattleInfoService()
        battleInfoService.executeRequest(urlRequest) { (data, response, error) in
            if nil != error {
                debugPrint("Error fetching the battle info: \(String(describing: error?.localizedDescription)) -- @ \(#function, #line)")
            }
            guard let urlResponse = response,
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return }
            if nil != data && Constants.Network.Status.OK == statusCode {
                if let battles = BattleParser.getBattlesFromData(data!),
                    let kings = BattleKingMap.mapKingToBattles(battles) {
                    self.kings = kings // Append
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
