//
//  SellingCategoryCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 26.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit
protocol categorySellProduct {
    
    func productSelected(product: Product)
     
}

class SellingCategoryCell: UITableViewCell {
    
    static let reuseID = "SellingCategoryCell"
    let label = UILabel()
    let productsListViewModel = ProductsListViewModel()
    var delegate: categorySellProduct!
    var selectedSellingCategory: SellingCategory!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLabel()
        configureCollectionView()
        getProducts()
    }
    func getProducts() {
        productsListViewModel.getMockData()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
    }
    func configureCollectionView() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        layout.itemSize = CGSize(width: 125, height: 250)
        layout.scrollDirection = .horizontal

        let collectionView: UICollectionView = UICollectionView(frame: .null, collectionViewLayout:layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
}
extension SellingCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let checkArr = productsListViewModel.allProducts.filter { (product) -> Bool in
            product.sellingCat == selectedSellingCategory
        }

        return checkArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let array = productsListViewModel.allProducts.filter { (product) -> Bool in
            product.sellingCat == selectedSellingCategory
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
        
        cell.set(product: array[indexPath.row])
        
        return cell
        
        
    }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let array = productsListViewModel.allProducts.filter { (product) -> Bool in
        product.sellingCat == selectedSellingCategory
    }
    delegate.productSelected(product: array[indexPath.row])
           
    
       }
    
    
    
    
    
}
