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
    var delegate: ShowingFiles?
    
    private var fileName: String!
    private var isDocFile: Bool!
    private var fileExtension: String?
    
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
    
    convenience init(fileName: String, isDocFile: Bool, delegate: ShowingFiles) {
        self.init()
        self.fileName = fileName
        self.isDocFile = isDocFile
        self.delegate = delegate
        
        self.fileExtension = FileHelper.getFileExtension(fileName: fileName)
        
        if isDocFile {
            setTextForDocFile(withFileName: fileName)
        } else {
            setTextForAddFile(withFileName: fileName)
        }
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
    private func setTextForAddFile(withFileName name: String) {
        let number = FileHelper.getFileNumber(fileName: name)
        
        let stringNumber = number != nil ? String(number!) : "[Неопределенный номер]"
        let stringExtension = fileExtension != nil ? fileExtension! : "[Неопределенное зарширение]"
        
        titleLabel.text = "\(stringNumber) файл (.\(stringExtension))"
    }
    
    private func setTextForDocFile(withFileName name: String) {
        titleLabel.text = "Оригинал текста"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDocFile {
            delegate?.showDoc(withName: fileName)
        } else {
            let ext = FileHelper.getFileExtension(fileName: fileName)
            
            if ext == "jpg" || ext == "jpeg" || ext == "png" {
                delegate?.showImage(withName: fileName)
            } else if ext == "gif" {
                delegate?.showImage(withName: fileName)
            } else if ext == "mp4" {
                delegate?.showVideo(withName: fileName)
            } else if ext == "mp3" {
                delegate?.showAudio(withName: fileName)
            }
        }
    }
    
    // Только png, jpg, jpeg, mp3, gif, mp4
    
    // docx

}
