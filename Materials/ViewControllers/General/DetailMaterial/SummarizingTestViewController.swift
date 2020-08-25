//
//  SummarizingTestViewController.swift
//  Materials
//
//  Created by art-off on 25.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class SummarizingTestViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Properties
    var isWin: Bool!
    
    // MARK: - Initialization
    convenience init(isWin: Bool) {
        self.init()
        
        self.isWin = isWin
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backgroupd
        
        if isWin {
            textLabel.text = "Тест пройден"
        } else {
            textLabel.text = "Тест не пройден\nПопробуйте снова"
        }
    }
    
    // MARK: - Actions
    @IBAction func onButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
