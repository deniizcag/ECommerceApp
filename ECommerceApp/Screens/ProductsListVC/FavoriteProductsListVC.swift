//
//  FavoriteProductsListVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 24.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class FavoriteProductsListVC: UIViewController {
    
    let tableView = UITableView()
    let productsListViewModel = ProductsListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureViewController()
        getProducts()
        configureTableView()
        getProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func configureViewController() {
        view.backgroundColor = .red
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.rowHeight = 180
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func getProducts() {
        productsListViewModel.getFavoriteProducts()
        print(productsListViewModel.favoritedProducts)
        tableView.reloadData()
    }
}
extension FavoriteProductsListVC:FavoriteCellDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product) {
        deleteProductFromFavorites(product: product)
    }
 
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else  {
            self.tableView.reloadData()
            getProducts()
            productsListViewModel.isSearching = false
            return
        }
        productsListViewModel.isSearching = true
        productsListViewModel.favoritedProducts = productsListViewModel.favoritedProducts.filter{
            $0.name.lowercased().contains(filter.lowercased()) ||
                $0.brand.lowercased().contains(filter.lowercased())
        }
        tableView.reloadData()
        
    }
    
    func deleteProductFromFavorites(product: Product) {
        productsListViewModel.removeFromFavorites(product: product)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        
        let product = productsListViewModel.favoritedProducts[indexPath.row]
        cell.set(product: product)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.productsListViewModel.favoritedProducts.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        productsListViewModel.removeFromFavorites(product: productsListViewModel.favoritedProducts[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .left)
        
        
    }
    func addToCartButtonPressed(product: Product) {
        if let error = productsListViewModel.addToCartProducts(product: product) {
            presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
        else {
             presentAlert(title: "Success !", message: "Product is added to cart", buttonTitle: "Ok")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productsListViewModel.favoritedProducts[indexPath.row]
        let destinationVC = ProductDetailVC(product: selectedProduct)
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
    
}

