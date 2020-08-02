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
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.register(
            UINib(nibName: "MaterialViewCell", bundle: nil),
            forCellReuseIdentifier: MaterialViewCell.reuseIdentifier)
        tableView.register(
            CustomHeader.self,
            forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastMonthMaterials = MaterialHelper.getLastMonthMaterials()
        notLastMonthMaterials = MaterialHelper.getNotLastMonthMaterials()
    }

}


// MARK: - Table view data source
extension NewTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return lastMonthMaterials.count }
        else { return notLastMonthMaterials.count }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifier) as! CustomHeader
        
        if section == 0 {
            view.title = "За текущий месяц"
        } else {
            view.title = "Остальные"
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialViewCell.reuseIdentifier, for: indexPath) as! MaterialViewCell
        
        let material: Material
        if indexPath.section == 0 {
            material = lastMonthMaterials[indexPath.row]
        } else {
            material = notLastMonthMaterials[indexPath.row]
        }
        cell.name = material.name
        cell.section = material.section
        cell.date = material.date
        
        return cell
    }
    
}
