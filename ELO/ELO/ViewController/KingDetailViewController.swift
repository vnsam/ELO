//
//  KingDetailViewController.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import UIKit

class KingDetailViewController: UIViewController {

    
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate(set) var viewModel: KingDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setSigilImage()
        setupTableView()
    }
}

// MARK: - New Instance
extension KingDetailViewController {
    class func newInstance() -> KingDetailViewController {
        return Storyboard
            .main
            .instantiateViewController(withIdentifier: String
                .init(describing: KingDetailViewController.self)) as! KingDetailViewController
    }
}

// MARK: - UI Update
extension KingDetailViewController {
    fileprivate func setupUI() {
        self.title = NSLocalizedString("Battles Fought", comment: "Battles Fought")
    }
}

// MARK: - Setter
extension KingDetailViewController {
    func setViewModel(_ viewModel: KingDetailViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Connections Setup
extension KingDetailViewController {
    func setupTableView() {
        tableView.dataSource = viewModel
    }
    
    func setSigilImage() {
        if let mappedImageName = viewModel?.attributes[Constants.KingDetail.name] as? String,
            let imageName = ImageMapper.imageDicationary[mappedImageName] {
            sigilImageView.image = UIImage.init(named: imageName)
        }
    }
}
