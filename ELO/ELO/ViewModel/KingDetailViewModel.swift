//
//  KingDetailViewModel.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingDetailViewModel: NSObject {
    fileprivate (set) var attributes: [AnyHashable: Any] = [:]
    fileprivate (set) var king: King?
    
    func setAttributes(_ attributes: [AnyHashable: Any]) {
        self.attributes = attributes
    }
    
    func setKing(_ king: King) {
        self.king = king
    }
    
    func parseAttributes() {
        if let king = self.king {
            let attributes = KingDetailParser.getDetails(for: king)
            setAttributes(attributes)
        }
    }
}

// MARK:
extension KingDetailViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (attributes[Constants.KingDetail.battles] as? [String])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        let battleName = (attributes[Constants.KingDetail.battles] as! [String])[indexPath.row]
        cell.textLabel?.text = battleName
        return cell
    }
    
    
}
