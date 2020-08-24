//
//  SearchTableViewController.swift
//  Materials
//
//  Created by art-off on 24.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: - Properties
    var materials: Results<Material>!
    private var filteredMaterials: Results<Material>!
    
    
    // MARK: - For SearchController
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.register(
            UINib(nibName: "MaterialViewCell", bundle: nil),
            forCellReuseIdentifier: MaterialViewCell.reuseIdentifier)
        
        tableView.separatorStyle = .none
        
        setupSearchController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenter()
        
        updateTableData()
    }
    
    // MARK: - Private Methods
    private func updateTableData() {
        materials = MaterialHelper.getAllMaterials()
        tableView.reloadData()
    }
    
    // MARK: - Setup search controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Название или раздел"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // чтобы не скрывался при скролинге
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filteredMaterials.count }
        return materials.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialViewCell.reuseIdentifier, for: indexPath) as! MaterialViewCell
        
        let material: Material
        if isFiltering {
            material = filteredMaterials[indexPath.row]
        } else {
            material = materials[indexPath.row]
        }
        cell.name = material.name
        cell.section = material.section
        cell.date = material.date
        
        return cell
    }
    
    // MARK: - UI search results updating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredMaterials = materials.filter("name CONTAINS[c] '\(searchText)' OR section CONTAINS[c] '\(searchText)' OR date CONTAINS[c] '\(searchText)'")
        tableView.reloadData()
    }

}


// MARK: - Notification Center
extension SearchTableViewController {
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(onDidUpdateMaterials), name: .didUpdateMaterials, object: nil)
    }
    
    @objc private func onDidUpdateMaterials() {
        updateTableData()
    }
    
}
