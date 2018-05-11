//
//  KingDetailViewController.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import UIKit

class KingDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    fileprivate(set) var viewModel: KingDetailViewModel?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        
        setSigilImage()
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
    func setSigilImage() {
        if let mappedImageName = viewModel?.attributes[Constants.KingDetail.name] as? String,
            let imageName = ImageMapper.imageDicationary[mappedImageName] {
            sigilImageView.image = UIImage.init(named: imageName)
        }
    }
}

// MARK: - UITableViewDataSource

extension KingDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.attributes[Constants.KingDetail.battles] as? [String])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        /*
         viewModel! - viewModel is force unwrapped here, unless the viewModel is not nill,
            we won't get to cell for row at index path
        */
        let battleName = (viewModel!.attributes[Constants.KingDetail.battles] as! [String])[indexPath.row]
        cell.textLabel?.text = battleName
        return cell
    }
}
