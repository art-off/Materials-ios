//
//  NewViewController.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

//import UIKit
//
//class NewViewController: UIViewController {
//
//    // MARK: - Properties
//    // тут будет массив с материалами
//    var materials: [Material]!
//
//    // MARK: - Views
//    private let scrollView = UIScrollView()
//    private let stackView = UIStackView()
//
//
//    // MARK: - Ovverides
//    override func loadView() {
//        super.loadView()
//
//        setupScrollView()
//        setupStackView()
//
//        //navigationController?.navigationBar.prefersLargeTitles = true
//        //navigationItem.title = "Новое"
//        view.backgroundColor = Colors.backgroupd
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        materials = Common.getMaterials()
//
//        for material in materials {
//            add(material: material)
//        }
//    }
//
//
//    // MARK: - Setup Any View
//    private func setupScrollView() {
//        view.addSubview(scrollView)
//
//        // убираем полосы прокрутки
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//
//        // раставляем констрейнты с отступом в 0 от view
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        //scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
//        scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstantForTop: 0, leadint: 8, trailing: -8, bottom: 0)
//    }
//
//    private func setupStackView() {
//        // выставляем свойства Stack View
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 8
//
//        scrollView.addSubview(stackView)
//        // раставляем констрейнты на полное прилигание с scrollView
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addConstraintsOnAllSides(to: scrollView, withConstantForTop: 0, leadint: 0, trailing: 0, bottom: -8)
//        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//    }
//
//}
//
//// MARK: - For Materials
//extension NewViewController {
//
//    func add(material: Material) {
//        let materialView = MaterialView()
//
//        stackView.addArrangedSubview(materialView)
//        materialView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//
//        materialView.name.text = material.name
//        materialView.section.text = material.section
//        materialView.date.text = material.date
//    }
//
//}
