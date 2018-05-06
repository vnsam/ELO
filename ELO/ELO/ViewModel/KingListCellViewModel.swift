//
//  KingListCellViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingListViewModel {
    fileprivate(set) var attributes: [String: String] = [:]
    
    func setAttributes(_ attributes: [String: String]) {
        self.attributes = attributes
    }
}
