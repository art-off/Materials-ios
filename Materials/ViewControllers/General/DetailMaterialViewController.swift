//
//  DetailMaterialViewController.swift
//  Materials
//
//  Created by art-off on 07.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class DetailMaterialViewController: UIViewController {
    
    // MARK: - Views
    let scrollView = UIScrollView()
    
    let nameMaterialLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    let dateMateriallabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .left
        label.textColor = .gray
        return label
    }()
    let contentMaterialLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .left
        return label
    }()
    let filesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Initialization
    convenience init(material: Material) {
        self.init()
        set(material: material)
    }
    
    func set(material: Material) {
        nameMaterialLabel.text = material.name
        dateMateriallabel.text = "Дата: \(material.date)"
        // Тут прочитать файл и вставить текст
        contentMaterialLabel.text = material.files?.doc
    }
    
    // MARK: - Ovirredes
    override func loadView() {
        super.loadView()
        
        setupScrollView()
        setupViews()
        
        view.backgroundColor = Colors.backgroupd
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Материал"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nameMaterialLabel.text = "Название материала честно"
        //dateMateriallabel.text = "Дата: 2000-20-20"
        //contentMaterialLabel.text = "А тут рили прям большой очень очень материал я даже \n хз что с ним делать"
        
        let v1 = UIView()
        filesStackView.addArrangedSubview(v1)
        v1.backgroundColor = .blue
        v1.widthAnchor.constraint(equalTo: filesStackView.widthAnchor).isActive = true
        v1.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        let v2 = UIView()
        filesStackView.addArrangedSubview(v2)
        v2.backgroundColor = .black
        v2.widthAnchor.constraint(equalTo: filesStackView.widthAnchor).isActive = true
        v2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    // MARK: - Setup Views
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        // Убираем полосы прокрутки
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // Расставляем констрейнты
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
    }
    
    private func setupViews() {
        let leadingConstant: CGFloat = 12
        let trailingConstant: CGFloat = 12
        
        scrollView.addSubview(nameMaterialLabel)
        nameMaterialLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMaterialLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12).isActive = true
        nameMaterialLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        nameMaterialLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        nameMaterialLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        scrollView.addSubview(dateMateriallabel)
        dateMateriallabel.translatesAutoresizingMaskIntoConstraints = false
        dateMateriallabel.topAnchor.constraint(equalTo: nameMaterialLabel.bottomAnchor, constant: 4).isActive = true
        dateMateriallabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        dateMateriallabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        dateMateriallabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        scrollView.addSubview(contentMaterialLabel)
        contentMaterialLabel.translatesAutoresizingMaskIntoConstraints = false
        contentMaterialLabel.topAnchor.constraint(equalTo: dateMateriallabel.bottomAnchor, constant: 20).isActive = true
        contentMaterialLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        contentMaterialLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        contentMaterialLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        
        scrollView.addSubview(filesStackView)
        filesStackView.translatesAutoresizingMaskIntoConstraints = false
        filesStackView.topAnchor.constraint(equalTo: contentMaterialLabel.bottomAnchor, constant: 20).isActive = true
        filesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        filesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        filesStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        filesStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
    }

}
