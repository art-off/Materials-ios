//
//  LabelViewCell.swift
//  Materials
//
//  Created by art-off on 24.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class LabelViewCell: UITableViewCell {
    
    // MARK: Reuse ID
    static let reuseIdentifier = "LabelCell"
    
    // MARK: - Properties
    var textInConteiner: String! {
        didSet { textInConteinerLabel.text = textInConteiner }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var textInConteinerLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conteinerView.backgroundColor = .white
        conteinerView.layer.cornerRadius = 15
        
        selectionStyle = .none
    }
    
}
