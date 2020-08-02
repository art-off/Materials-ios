//
//  AboutMeTableViewController.swift
//  Materials
//
//  Created by art-off on 26.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class AboutMeTableViewController: LogoTableViewController {
    
    // MARK: - Properties
    var sections: [String]!
    var user: User!
    var materials: [Material]!
    
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        
        tableView.register(
            UINib(nibName: "UserViewCell", bundle: nil),
            forCellReuseIdentifier: UserViewCell.reuseIdentifier)
        tableView.register(
            UINib(nibName: "MaterialViewCell", bundle: nil),
            forCellReuseIdentifier: MaterialViewCell.reuseIdentifier)
        tableView.register(
            CustomHeader.self,
            forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            "Информация",
            "Пройденные материалы"
        ]
        
        user = UserHelpers.getCurrUser()
        materials = []
        if let user = user {
            materials = MaterialHelper.getMaterialsWithDoneDate(doneMaterials: Array(user.materials))
        }
    }

}


// MARK: - Table view data source
extension AboutMeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if user == nil { return 0 }
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user == nil { return 0 }
        if section == 0 { return 1 }
        else { return materials.count }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifier) as! CustomHeader
        
        view.title = sections[section]
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserViewCell.reuseIdentifier, for: indexPath) as! UserViewCell
            
            cell.surname = user.surname
            cell.nameAndPatronymicLabel.text = "\(user.name) \(user.patronymic)"
            cell.email = user.email
            cell.organization = user.organization
            cell.position = user.position
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaterialViewCell.reuseIdentifier, for: indexPath) as! MaterialViewCell
            
            let material = materials[indexPath.row]
            cell.name = material.name
            cell.section = material.section
            cell.date = material.date
            
            return cell
        }
        
        return UITableViewCell()
    }
}
