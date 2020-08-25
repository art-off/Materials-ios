//
//  CustomButton.swift
//  Materials
//
//  Created by art-off on 14.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Setup View
    private func setupButton() {
        //setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor = Colors.transneftBlue
        titleLabel?.font = UIFont(name: "System", size: 18)
        layer.cornerRadius = 25
    }
    
}
