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
