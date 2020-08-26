//
//  DetailMaterialViewController.swift
//  Materials
//
//  Created by art-off on 07.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import QuickLook

class DetailMaterialViewController: UIViewController {
    
    // MARK: - Views
    // MARK: Scroll View
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: Sub Views
    let nameMaterialLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let sectionMaterialLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .left
        label.font = UIFont.boldSystemFont(ofSize: 21)
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
        stackView.spacing = 8
        return stackView
    }()
    
    let testButton = CustomButton()
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    // MARK: - Properties
    private var material: Material!
    private var materialText: String!
    
    // MARK: Show Files
    private var filePreviewController: QLPreviewController!
    private var previewItem: URL!
    
    // MARK: - Initialization
    convenience init(material: Material, materialText: String) {
        self.init()
        set(material: material, materialText: materialText)
    }
    
    func set(material: Material, materialText: String) {
        self.material = material
        self.materialText = materialText
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
        
        configurateLabels(
            withNameText: material.name,
            sectionText: material.section,
            dateText: material.date,
            contentText: materialText)
        
        if let files = material.files {
            configurateFilesStack(
                withDocName: files.doc,
                addFileNames: Array(files.add))
        }
        
        configurateButton()
    }
    
    
    // MARK: - Setup Views
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
    }
    
    private func setupViews() {
        let leadingConstant: CGFloat = 12
        let trailingConstant: CGFloat = 12
        
        // Name Material Label
        scrollView.addSubview(nameMaterialLabel)
        nameMaterialLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMaterialLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12).isActive = true
        nameMaterialLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        nameMaterialLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        nameMaterialLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        // Section Material Label
        scrollView.addSubview(sectionMaterialLabel)
        sectionMaterialLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionMaterialLabel.topAnchor.constraint(equalTo: nameMaterialLabel.bottomAnchor, constant: 4).isActive = true
        sectionMaterialLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        sectionMaterialLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        sectionMaterialLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        // Date Material Label
        scrollView.addSubview(dateMateriallabel)
        dateMateriallabel.translatesAutoresizingMaskIntoConstraints = false
        dateMateriallabel.topAnchor.constraint(equalTo: sectionMaterialLabel.bottomAnchor, constant: 4).isActive = true
        dateMateriallabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        dateMateriallabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        dateMateriallabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        // Content Material Label
        scrollView.addSubview(contentMaterialLabel)
        contentMaterialLabel.translatesAutoresizingMaskIntoConstraints = false
        contentMaterialLabel.topAnchor.constraint(equalTo: dateMateriallabel.bottomAnchor, constant: 20).isActive = true
        contentMaterialLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        contentMaterialLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        contentMaterialLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        // Files Stack View
        scrollView.addSubview(filesStackView)
        filesStackView.translatesAutoresizingMaskIntoConstraints = false
        filesStackView.topAnchor.constraint(equalTo: contentMaterialLabel.bottomAnchor, constant: 20).isActive = true
        filesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leadingConstant).isActive = true
        filesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: trailingConstant).isActive = true
        //filesStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        filesStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
        
        // Test Button
        scrollView.addSubview(testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        testButton.topAnchor.constraint(equalTo: filesStackView.bottomAnchor, constant: 30).isActive = true
        testButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        testButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        testButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(leadingConstant + trailingConstant)).isActive = true
    }
    
    // MARK: - Configuration
    private func configurateLabels(withNameText nameText: String, sectionText: String, dateText: String, contentText: String) {
        nameMaterialLabel.text = nameText
        sectionMaterialLabel.text = sectionText
        dateMateriallabel.text = dateText
        contentMaterialLabel.text = contentText
    }
    
    private func configurateFilesStack(withDocName docName: String, addFileNames addNames: [String]) {
        let docFileView = FileView(fileName: docName, isDocFile: true, delegate: self)
        filesStackView.addArrangedSubview(docFileView)
        docFileView.widthAnchor.constraint(equalTo: filesStackView.widthAnchor).isActive = true
        
        for addName in addNames {
            let addFileView = FileView(fileName: addName, isDocFile: false, delegate: self)
            filesStackView.addArrangedSubview(addFileView)
            addFileView.widthAnchor.constraint(equalTo: filesStackView.widthAnchor).isActive = true
        }
    }
    
    private func configurateButton() {
        testButton.setTitle("Пройти тест", for: .normal)
        testButton.addTarget(self, action: #selector(onTestButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func onTestButtonTapped() {
        let testVC = TestViewController(tests: Array(material.tests), materialId: material.id)
        navigationController?.pushViewController(testVC, animated: true)
    }

}


// MARK: - Showing files
extension DetailMaterialViewController: ShowingFiles {
    
    private func showAnyFile(withName fileName: String) {
        startActivityIndicator()
        
        filePreviewController = QLPreviewController()
        filePreviewController.dataSource = self
        previewItem = FileHelper.getUrl(forFileName: fileName)
        
        if !FileManager.default.fileExists(atPath: previewItem.path) {
            ApiManager.downloadFile(withFileName: fileName) { isDone in
                DispatchQueue.main.async {
                    if isDone {
                        self.filePreviewController.reloadData()
                        self.present(self.filePreviewController, animated: true, completion: nil)
                    } else {
                        self.showNetworkAlert()
                    }
                    self.stopActivityIndicator()
                }
            }
        } else {
            filePreviewController.reloadData()
            present(self.filePreviewController, animated: true, completion: nil)
            stopActivityIndicator()
        }
    }
    
    func showDoc(withName fileName: String) {
        showAnyFile(withName: fileName)
    }
    
    func showImage(withName fileName: String) {
        showAnyFile(withName: fileName)
    }
    
    func showVideo(withName fileName: String) {
        showAnyFile(withName: fileName)
    }
    
    func showAudio(withName fileName: String) {
        showAnyFile(withName: fileName)
    }
    
}


// MARK: - Animating Network View Controller
extension DetailMaterialViewController: AnimatingNetworkViewController {
    
    func animatingSuperViewForDisplay() -> UIView {
        return view
    }
    
    func animatingViewForDisableUserInteraction() -> UIView {
        if let tabBarController = tabBarController {
            return tabBarController.view
        } else if let navController = navigationController {
            return navController.view
        } else {
            return view
        }
    }
    
    func animatingActivityIndicatorView() -> ActivityIndicatorView {
        return activityIndicatorView
    }
    
    func animatingAlertView() -> AlertView {
        return alertView
    }
    
}


// MARK: - QL Preview Controller Data Source
extension DetailMaterialViewController: QLPreviewControllerDataSource {

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }

}
