//
//  CustomHeader.swift
//  Materials
//
//  Created by art-off on 01.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    
    // MARK: Reuse ID
    static let reuseIdentifier = "SectionHeader"
    
    // MARK: - Properties
    var title: String! {
        didSet { titleLabel.text = title }
    }
    
    // MARK: - Privates
    private let titleLabel = UILabel()
    
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureContents()
        contentView.backgroundColor = Colors.backgroupd
        backgroundColor = Colors.backgroupd
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
