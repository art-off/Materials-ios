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
        startActivityIndicator()
        MaterialHelper.loadAllMaterialsFromApiAndWriteInBD { isDone in
            DispatchQueue.main.async {
                if isDone {
                    self.updateTableData()
                } else {
                    self.showAlert(withText: "Проблемы с загрузкой")
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
        
        let vc = DetailMaterialViewController(material: material)
        
        
        
        // тут запускать анимацию и ждать пока скачается док
        //vc.contentMaterialLabel.text =
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Animating
extension NewTableViewController {
    
    // MARK: Activity Indicator
    func startActivityIndicator() {
        if !view.subviews.contains(activityIndicatorView) {
            view.addSubview(activityIndicatorView)
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        }
        activityIndicatorView.startAnimating()
        tableView.isScrollEnabled = false
    }
    
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
        tableView.isScrollEnabled = true
    }
    
    // MARK: Alert View
    func showAlert(withText alertText: String) {
        if !view.subviews.contains(alertView) {
            view.addSubview(alertView)
            
            alertView.translatesAutoresizingMaskIntoConstraints = false
            alertView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            alertView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        alertView.alertLabel.text = alertText
        alertView.hideWithAnimation()
    }
    
}
