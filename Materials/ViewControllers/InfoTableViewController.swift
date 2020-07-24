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
            UINib(nibName: "SectionViewCell", bundle: nil),
            forCellReuseIdentifier: SectionViewCell.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionsAndMaterials = MaterialHelper.getMaterialsBySections()
        sections = []
        for sectionAndMaterial in sectionsAndMaterials {
            sections.append(sectionAndMaterial.key)
        }
        sections.sort()
    }

}

// MARK: - Table view data source
extension InfoTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionViewCell.reuseIdentifier, for: indexPath) as! SectionViewCell
        
        let section = sections[indexPath.row]
        cell.section = section
        
        // отключаем выделение
        cell.selectionStyle = .none
        
        return cell
    }
    
}

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
