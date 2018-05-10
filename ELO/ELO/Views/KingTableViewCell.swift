//
//  KingTableViewCell.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import UIKit

class KingTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var kingNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var attacksLabel: UILabel!
    @IBOutlet weak var defencesLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: KingListViewModel? {
        didSet {
            setAttributes()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - UI Update
extension KingTableViewCell {
    func setViewModel(_ viewModel: KingListViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate func setAttributes() {
        
        let attributes = viewModel?.attributes
        
        if let kingName = attributes?[Constants.Cell.Attributes.kingName] {
            sigilImageView.image = UIImage.init(named: (ImageMapper.imageDicationary[kingName])!)
            kingNameLabel.text = kingName
        }
        scoreLabel.text = attributes?[Constants.Cell.Attributes.eloScore]
        winsLabel.text = attributes?[Constants.Cell.Attributes.wins]
        attacksLabel.text = attributes?[Constants.Cell.Attributes.attacks]
        defencesLabel.text = attributes?[Constants.Cell.Attributes.defenses]
    }
}
