//
//  UserViewCell.swift
//  Materials
//
//  Created by art-off on 01.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    // MARK: Reuse ID
    static let reuseIdentifier = "UserCell"
    
    // MARK: - Properties
    var surname: String! {
        didSet { surnameLabel.text = surname }
    }
    var nameAndPatronymic: String! {
        didSet { nameAndPatronymicLabel.text = nameAndPatronymic}
    }
    var email: String! {
        didSet { emailLabel.text = "Почта: \(email!)" }
    }
    var position: String! {
        didSet { positionLabel.text = "Должность: \(position!)" }
    }
    var organization: String! {
        didSet { organizationLabel.text = "Организация: \(organization!)" }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameAndPatronymicLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        
        selectionStyle = .none
    }
    
}
