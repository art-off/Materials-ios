//
//  MaterialView.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

//import UIKit
//
//class MaterialView: UIView {
//    
//    // MARK: - Properties
//    private var materialId: Int?
//    
//    
//    // MARK: - Views
//    @IBOutlet var wrapperView: UIView!
//    @IBOutlet weak var contentView: UIView!
//    
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var section: UILabel!
//    @IBOutlet weak var date: UILabel!
//    
//    
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//    
//    convenience init(material: Material) {
//        self.init()
//        
//        materialId = material.id
//        name.text = material.name
//        section.text = material.section
//        date.text = material.date
//    }
//    
//    private func commonInit() {
//        loadXib()
//        setupViews()
//        addRecognizers()
//    }
//    
//    // MARK: - Setup Views
//    private func loadXib() {
//        Bundle.main.loadNibNamed("MaterialView", owner: self, options: nil)
//        addSubview(wrapperView)
//        wrapperView.frame = self.bounds
//        wrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
//    
//    private func setupViews() {
//        wrapperView.backgroundColor = .white
//        wrapperView.layer.cornerRadius = 15
//        setupLabels()
//    }
//    
//    private func setupLabels() {
//        date.textColor = .gray
//    }
//    
//    
//    // MARK: - Recognizers
//    func addRecognizers() {
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pringNum))
//        self.addGestureRecognizer(tapRecognizer)
//    }
//    
//    @objc func pringNum() {
//        print("sdfsdfsdfsf11111")
//    }
//
//}
