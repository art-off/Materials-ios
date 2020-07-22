//
//  MaterialViewCell.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class MaterialViewCell: UITableViewCell {
    
    // MARK: Reuse ID
    static let reuseIdentifier = "MaterialCell"
    
    // MARK: - Properties
    var name: String! {
        didSet { nameLabel.text = name }
    }
    var section: String! {
        didSet { sectionLabel.text = section }
    }
    var date: String! {
        didSet { dateLabel.text = date }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
    }
    
}
