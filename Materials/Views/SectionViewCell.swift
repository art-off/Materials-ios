//
//  SectionViewCell.swift
//  Materials
//
//  Created by art-off on 24.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class SectionViewCell: UITableViewCell {
    
    // MARK: Reuse ID
    static let reuseIdentifier = "SectionCell"
    
    // MARK: - Properties
    var section: String! {
        didSet { sectionLabel.text = section }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conteinerView.backgroundColor = .white
        conteinerView.layer.cornerRadius = 15
    }
    
}
