//
//  KingDetailViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingDetailViewModel {
    
    // MARK: - Properties
    
    fileprivate (set) var attributes: [AnyHashable: Any] = [:]
    fileprivate (set) var king: King?
    
    // MARK: - Intializer and
    
    init(king: King) {
        self.king = king
        
        updateAttributes()
    }
    
    func updateAttributes() {
        if let king = self.king {
            
            let attributes = KingDetailParser.parse(for: king)
            
            setAttributes(attributes)
        }
    }
    
    func setAttributes(_ attributes: [AnyHashable: Any]) {
        self.attributes = attributes
    }
}
