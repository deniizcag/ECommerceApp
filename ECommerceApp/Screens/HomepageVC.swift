//
//  HomepageVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 25.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class HomepageVC: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
       configureViewController()
        configureTableView()
    
    }
    func configureViewController(){

        view.backgroundColor = .red
        title = "Homepage"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
      func configureTableView() {
        
        view.addSubview(tableView)
        
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(SellingCategoryCell.self, forCellReuseIdentifier: SellingCategoryCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }

}
extension HomepageVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let array :[SellingCategory] = [.bestSellers,.mostViewed,.topRated,.bestPriceOffer]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SellingCategoryCell.reuseID, for: indexPath) as! SellingCategoryCell
        cell.label.text = array[indexPath.row].rawValue
        cell.selectedSellingCategory = array[indexPath.row]
        cell.delegate = self

        return cell
    }
    
 
}
extension HomepageVC: categorySellProduct,ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product) {
        
    }
    
    func productSelected(product: Product) {
        let destinationVC = ProductDetailVC(product: product)
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
    
    
}
