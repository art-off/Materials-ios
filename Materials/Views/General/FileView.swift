//
//  FileView.swift
//  Materials
//
//  Created by art-off on 13.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class FileView: UIView {
    
    // MARK: - Properties
    var fileName: String!
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init(fileName: String) {
        self.init()
        self.fileName = fileName
        setText(withFileName: self.fileName)
    }
    
    private func commonInit() {
        loadXib()
        setupViews()
    }
    
    // MARK: Setup Views
    private func loadXib() {
        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
        Bundle.main.loadNibNamed("FileView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
    }
    
    // MARK: - Privates Methods
    private func setText(withFileName name: String) {
        let number = FileHelper.getFileNumber(fileName: name)
        let ext = FileHelper.getFileExtension(fileName: name)
        
        let stringNumber = number != nil ? String(number!) : "[Неопределенный номер]"
        let stringExt = ext != nil ? ext! : "[Неопределенное зарширение]"
        
        titleLabel.text = "\(stringNumber) файл (.\(stringExt))"
    }

}
