//
//  InfoTableViewController.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class InfoTableViewController: UITableViewController {
    
    // MARK: - Properties
    var sectionsAndMaterials: [String: Results<Material>]!
    var sections: [String]!
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.register(
            UINib(nibName: "LabelViewCell", bundle: nil),
            forCellReuseIdentifier: LabelViewCell.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenter()
        
        updateTableData()
    }
    
    // MARK: - Private Methods
    private func updateTableData() {
        sectionsAndMaterials = MaterialHelper.getMaterialsBySections()
        sections = []
        for sectionAndMaterial in sectionsAndMaterials {
            sections.append(sectionAndMaterial.key)
        }
        sections.sort()
        tableView.reloadData()
    }

}


// MARK: - Table view data source
extension InfoTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelViewCell.reuseIdentifier, for: indexPath) as! LabelViewCell
        
        let section = sections[indexPath.row]
        cell.textInConteiner = section
        
        // отключаем выделение
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - Table view delegate
extension InfoTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        
        guard let materials = sectionsAndMaterials[section] else { return }
        
        let vc = MaterialsTableViewController()
        vc.materials = materials
        vc.section = section
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Notification Center
extension InfoTableViewController {
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(onDidUpdateMaterials), name: .didUpdateMaterials, object: nil)
    }
    
    @objc private func onDidUpdateMaterials() {
        updateTableData()
    }
    
}
