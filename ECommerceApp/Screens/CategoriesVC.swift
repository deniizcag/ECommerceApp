//
//  CategoriesVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 27.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    let categoryArray = ProductCategory.allCases
    let categoryListViewModel  = CategoryListViewModel()
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()

    }
    
    func configureViewController() {
        
        view.backgroundColor = .red
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
   
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(ProductCategoryCell.self, forCellReuseIdentifier: ProductCategoryCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension CategoriesVC: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListViewModel.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryCell.reuseID, for: indexPath) as! ProductCategoryCell
        cell.categoryLabel.text = categoryListViewModel.allCategories[indexPath.row].name.rawValue
        cell.categoryImage.image = UIImage(named: categoryListViewModel.allCategories[indexPath.row].image.rawValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCategory = categoryArray[indexPath.row]
        
        let destVC = ProductsVC(selectedCategory: selectedCategory)
        
              navigationController?.pushViewController(destVC, animated: true)
        
        
    }
    
    
    
}
