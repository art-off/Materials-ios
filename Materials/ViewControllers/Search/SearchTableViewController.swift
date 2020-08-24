//
//  SearchTableViewController.swift
//  Materials
//
//  Created by art-off on 24.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class SearchTableViewController: UITableViewController {
    
    // MARK: - Properties
    var materials: Results<Material>!
    private var filteredMaterials: Results<Material>!
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    
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
    
    // MARK: - Setup views
    // MARK: Setup search controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Название или раздел"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // чтобы не скрывался при скролинге
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}


// MARK: - Table view data source
extension SearchTableViewController {
    
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
    
}


// MARK: - Table view delegate
extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let material: Material
        if isFiltering {
            material = filteredMaterials[indexPath.row]
        } else {
            material = materials[indexPath.row]
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


// MARK: - UI search results updating
extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        let namePredicate = "name CONTAINS[c] '\(searchText)'"
        let sectionPredicate = "section CONTAINS[c] '\(searchText)'"
        let datePredicate = "date CONTAINS[c] '\(searchText)'"
        // сделать как-то поиск по ключевым словам
        //let keywordPredicate = "\(searchText) IN {'ss', 'ff'}"
        
        let generalPredicate = "\(namePredicate) OR \(sectionPredicate) OR \(datePredicate)"
        
        filteredMaterials = materials.filter(generalPredicate)
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


// MARK: - Animating Network View Controller
extension SearchTableViewController: AnimatingNetworkViewController {
    
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
