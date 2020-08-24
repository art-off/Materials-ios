//
//  NewTableViewController.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class NewTableViewController: UITableViewController {
    
    // MARK: - Properties
    var lastMonthMaterials: Results<Material>!
    var notLastMonthMaterials: Results<Material>!
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.register(
            UINib(nibName: "LabelViewCell", bundle: nil),
            forCellReuseIdentifier: LabelViewCell.reuseIdentifier)
        tableView.register(
            UINib(nibName: "MaterialViewCell", bundle: nil),
            forCellReuseIdentifier: MaterialViewCell.reuseIdentifier)
        tableView.register(
            CustomHeader.self,
            forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotificationCenter()
        
        updateTableData()
        _downloadMaterials()
    }
    
    // MARK: - Privates methods
    private func updateTableData() {
        lastMonthMaterials = MaterialHelper.getLastMonthMaterials()
        notLastMonthMaterials = MaterialHelper.getNotLastMonthMaterials()
        tableView.reloadData()
    }
    
    private func _downloadMaterials() {
        // ДА, ФУНКЦИЯ НЕ ВЫЗЫВАЕТСЯ ИЗ БЭК, НО ЕСЛИ НЕ ЗАСУНУТЬ СЮДА БУДУТ ОШИБКА ПО КОНСТРЕЙНТАМ Я ХЗ ПОЧЕМУ
        DispatchQueue.main.async {
            self.startActivityIndicator()
        }
        MaterialHelper.loadAllMaterialsFromApiAndWriteInBD { isDone in
            DispatchQueue.main.async {
                if isDone {
                    // отправляем обновление куда только нужно
                    NotificationCenter.default.post(name: .didUpdateMaterials, object: nil)
                } else {
                    self.showNetworkAlert()
                }
                self.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func downloadMaterials(_ sender: UIBarButtonItem) {
        _downloadMaterials()
    }
    
}


// MARK: - Notification Center
extension NewTableViewController {
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(onDidUpdateMaterials), name: .didUpdateMaterials, object: nil)
    }
    
    @objc private func onDidUpdateMaterials() {
        updateTableData()
    }
    
}


// MARK: - Table view data source
extension NewTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifier) as! CustomHeader
        
        if section == 0 {
            view.title = "За текущий месяц"
        } else {
            view.title = "Остальные"
        }
        view.backgroundView?.backgroundColor = Colors.backgroupd
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if lastMonthMaterials.isEmpty { return 1 }
            return lastMonthMaterials.count
        }
        else {
            if notLastMonthMaterials.isEmpty { return 1 }
            return notLastMonthMaterials.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialViewCell.reuseIdentifier, for: indexPath) as! MaterialViewCell
        
        let material: Material
        if indexPath.section == 0 {
            if lastMonthMaterials.isEmpty {
                let labelCell = tableView.dequeueReusableCell(withIdentifier: LabelViewCell.reuseIdentifier, for: indexPath) as! LabelViewCell
                labelCell.textInConteiner = "В текущем месяце не было материалов"
                labelCell.textInConteinerLabel.textColor = .gray
                labelCell.isUserInteractionEnabled = false
                return labelCell
            }
            
            material = lastMonthMaterials[indexPath.row]
        } else {
            if notLastMonthMaterials.isEmpty {
                let labelCell = tableView.dequeueReusableCell(withIdentifier: LabelViewCell.reuseIdentifier, for: indexPath) as! LabelViewCell
                labelCell.textInConteiner = "В предыдущие месяцы материалов не было"
                labelCell.textInConteinerLabel.textColor = .gray
                labelCell.isUserInteractionEnabled = false
                return labelCell
            }
            
            material = notLastMonthMaterials[indexPath.row]
        }
        cell.name = material.name
        cell.section = material.section
        cell.date = material.date
        
        return cell
    }
    
}

// MARK: - Table view delegate
extension NewTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let material: Material
        if indexPath.section == 0 {
            material = lastMonthMaterials[indexPath.row]
        } else {
            material = notLastMonthMaterials[indexPath.row]
        }
        
        guard let files = material.files else { return }
        
        guard let txtFileName = FileHelper.getFilaNameWithTxtFromDoc(fileName: files.doc) else { return }
        
        startActivityIndicator()
        FileHelper.getTxtFileTextFromApiOrLocal(withName: txtFileName) { text in
            DispatchQueue.main.async {
                guard let text = text else {
                    self.showNetworkAlert()
                    return
                }
                
                let vc = DetailMaterialViewController(material: material, materialText: text)
                
                self.stopActivityIndicator()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}


// MARK: - Animating Network View Controller
extension NewTableViewController: AnimatingNetworkViewController {
    
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
