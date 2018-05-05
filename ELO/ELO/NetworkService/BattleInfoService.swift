//
//  BattleInfoService.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class BattleInfoService {
    typealias CompletionBlock = (_ result: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    func executeRequest(_ urlRequest: URLRequest, completion: @escaping CompletionBlock) {
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            debugPrint("""
                Data: \(String(describing: data)) \n
                Reponse: \(String(describing: response))
                Error: \(String(describing: error))
                """)
            completion(data, response, error)
        }
        
        dataTask.resume()
    }
}
