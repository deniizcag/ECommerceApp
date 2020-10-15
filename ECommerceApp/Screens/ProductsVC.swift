//
//  ProductListVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 29.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController {
    
    var selectedCategory: ProductCategory!
    var productsListViewModel = ProductsListViewModel()
    var collectionView: UICollectionView!
    
    init(selectedCategory: ProductCategory) {
        super.init(nibName: nil, bundle: nil)
        self.selectedCategory = selectedCategory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getProducts()
        
    }
    
    func configureViewController() {
        title = selectedCategory.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        
        let width                   = view.bounds.width
        var itemHeight:CGFloat      = 0
        let padding: CGFloat        = 6
        let minItemSpacing: CGFloat = 10
        let availableWidth          = width-(2*padding)-(2*minItemSpacing)
        let itemWidth               = availableWidth/3
        let flowLayout              = UICollectionViewFlowLayout()
        
        if width > 400 {
            itemHeight = itemWidth+120
        }
        else {
            itemHeight = itemWidth + 135
        }
        flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize         = CGSize(width: itemWidth, height: itemHeight)
        
        self.collectionView = UICollectionView(frame: .null, collectionViewLayout: flowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
    
    func getProducts() {
        
        
        productsListViewModel.getMockData()
        productsListViewModel.filterCategory(category: selectedCategory)
        
    }
    
    func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    
    
}

extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating,ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product) {
        productsListViewModel.removeFromFavorites(product: product)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsListViewModel.getActiveProducts()[indexPath.row]
        
        
        let destVC   = ProductDetailVC(product: product)
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productsListViewModel.getActiveProducts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
        
        let product = productsListViewModel.getActiveProducts()[indexPath.row]
        
        
        cell.set(product: product)
        
        
        return cell
        
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else  {
            productsListViewModel.filteredProducts.removeAll()
            self.collectionView.reloadData()
            productsListViewModel.isSearching = false
            return
        }
        productsListViewModel.isSearching = true
        
        productsListViewModel.filteredProducts = productsListViewModel.allProducts.filter{
            $0.name.lowercased().contains(filter.lowercased()) ||
                $0.brand.lowercased().contains(filter.lowercased())
        }
        self.collectionView.reloadData()
        
    }
}




