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
    // MARK: Scroll View
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
    
    // MARK: ActivityIndicatorView
    let activityIndicatorView = ActivityIndicatorView()
    // MARK: Alert View
    let alertViewForNetwork = AlertView(alertText: "Проблемы с интернетом")
    
    // MARK: - Properties
    private var material: Material!
    
    private var docOpener: UIDocumentInteractionController!
    
    // MARK: - Initialization
    convenience init(material: Material) {
        self.init()
        set(material: material)
    }
    
    func set(material: Material) {
//        nameMaterialLabel.text = material.name
//        dateMateriallabel.text = "Дата: \(material.date)"
//
//        if let files = material.files {
//            // Тут прочитать файл и вставить текст
//            contentMaterialLabel.text = files.doc
//            configurateFilesStack(withFileNames: Array(files.add))
//        }
        self.material = material
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
        contentMaterialLabel.text = "А тут рили прям большой очень очень материал я даже \n хз что с ним делатsdfjllaskdj fal;skdjf l;aksdjf laks;djf als;kdfj \n\n\n\nn\n\n\n\n\n\n\n\n\n\\n\n\n\n\n\n\n\n\n\n\nlkjdflskdjflksdjlf kjdsfdsjfls'kdj f\n\n\n\n\nь"
        
        if let files = material.files {
//            configurateLabels(
//                withNameText: material.name,
//                dateText: material.date,
//                contentText: <#T##String#>)
            configurateFilesStack(withFileNames: Array(files.add))
        }
        
//        let url = DataManager.shared.getFilesDirectoryUrl().appendingPathComponent("6(0).docx")
//        print("Хелло1")
//        let text = SNDocx.shared.getText(fileUrl: url)
//        print("Хелло2")
//        print(text)
//        contentMaterialLabel.text = text
        
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
        
        // Date Material Label
        scrollView.addSubview(dateMateriallabel)
        dateMateriallabel.translatesAutoresizingMaskIntoConstraints = false
        dateMateriallabel.topAnchor.constraint(equalTo: nameMaterialLabel.bottomAnchor, constant: 4).isActive = true
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
    private func configurateLabels(withNameText nameText: String, dateText: String, contentText: String) {
        nameMaterialLabel.text = nameText
        dateMateriallabel.text = dateText
        contentMaterialLabel.text = contentText
    }
    
    private func configurateFilesStack(withFileNames names: [String]) {
        for fileName in names {
            let fileView = FileView(fileName: fileName)
            filesStackView.addArrangedSubview(fileView)
            fileView.widthAnchor.constraint(equalTo: filesStackView.widthAnchor).isActive = true
        }
    }
    
    private func configurateButton() {
        testButton.setTitle("Пройти тест", for: .normal)
        testButton.addTarget(self, action: #selector(onTestButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func onTestButtonTapped() {
        showAlertForNetwork()
        //showDoc(withName: "2(0).docx")
    }

}


// MARK: - All For Preview DOCX
extension DetailMaterialViewController: UIDocumentInteractionControllerDelegate {
    
    private func _showDoc(withName fileName: String) {
        let fileURL = DataManager.shared.getFilesDirectoryUrl()
            .appendingPathComponent(fileName)
        
        docOpener = UIDocumentInteractionController.init(url: fileURL)
        docOpener.delegate = self
        docOpener.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }

    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }

    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
    
}


// MARK: - Showing files
extension DetailMaterialViewController: ShowingFiles {
    
    func showDoc(withName fileName: String) {
        _showDoc(withName: fileName)
    }
    
    func showImage(withName: String) {
        
    }
    
    func showVideo(withName: String) {
        
    }
    
    func showAudio(withName: String) {
        
    }
    
}


// MARK: - Network
extension DetailMaterialViewController {
    
    // MARK: Activity Indicator
    func startActivityIndicator() {
        if !view.subviews.contains(activityIndicatorView) {
            view.addSubview(activityIndicatorView)
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        }
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: Arert View
    func showAlertForNetwork() {
        if !view.subviews.contains(alertViewForNetwork) {
            view.addSubview(alertViewForNetwork)
            
            alertViewForNetwork.translatesAutoresizingMaskIntoConstraints = false
            alertViewForNetwork.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            alertViewForNetwork.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        alertViewForNetwork.hideWithAnimation()
    }
    
}
