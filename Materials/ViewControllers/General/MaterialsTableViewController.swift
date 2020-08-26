//
//  MaterialsTableViewController.swift
//  Materials
//
//  Created by art-off on 24.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class MaterialsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var section: String!
    var materials: Results<Material>!
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.register(
            UINib(nibName: "MaterialViewCell", bundle: nil),
            forCellReuseIdentifier: MaterialViewCell.reuseIdentifier)
        
        tableView.separatorStyle = .none
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = section
    }
    
}

// MARK: - Table view data source
extension MaterialsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materials.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialViewCell.reuseIdentifier, for: indexPath) as! MaterialViewCell
        
        let material = materials[indexPath.row]
        cell.name = material.name
        cell.section = material.section
        cell.date = material.date
        
        // отключаем выделение
        cell.selectionStyle = .none
        
        return cell
    }
    
}


// MARK: - Table view delegate
extension MaterialsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let material = materials[indexPath.row]

        guard let files = material.files else { return }
        
        guard let txtFileName = FileHelper.getFilaNameWithTxtFromDoc(fileName: files.doc) else { return }
        
        startActivityIndicator()
        FileHelper.getTxtFileTextFromApiOrLocal(withName: txtFileName) { text in
            DispatchQueue.main.async {
                guard let text = text else {
                    self.showNetworkAlert()
                    self.stopActivityIndicator()
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
extension MaterialsTableViewController: AnimatingNetworkViewController {
    
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
