//
//  FavoriteCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 23.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit


protocol FavoriteCellDelegate {
    func deleteProductFromFavorites(product: Product)
    func addToCartButtonPressed(product: Product)
}

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "ProductCategoryCell"
    let brandLabel = EcomBrandLabel(fontSize: 20, weight: .regular)
    let productImage = UIImageView()
    let productNameLabel = EcomProductNameLabel(fontSize: 15, weight: .light)
    let priceLabel      = EcomPriceLabel(alignment: .left, font: 20, weight: .light)
   
    
    let addToCartButton = EcomButton(title: "Add to Cart",font: 12)
    let favoriteButton = EcomFavoriteButton()
    
    var selectedProduct : Product!
    var delegate: FavoriteCellDelegate!
    
    
    var count = 1.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configureBrandLabel()
        configureNameLabel()
        configurePriceLabel()
        configureButton()
        configureFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func configureImage() {
        accessoryType = .disclosureIndicator
        productImage.contentMode = .scaleAspectFill
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "sq.jpeg")
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImage.widthAnchor.constraint(equalToConstant: 80),
            productImage.heightAnchor.constraint(equalToConstant: 160),
            
        ])
    }
    
    func configureBrandLabel() {
        selectionStyle = .gray
        contentView.addSubview(brandLabel)
       
        NSLayoutConstraint.activate([
            brandLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor,constant: 20),
            brandLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            brandLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureNameLabel() {
 
        contentView.addSubview(productNameLabel)
    
        
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            productNameLabel.topAnchor.constraint(equalTo: brandLabel.topAnchor,constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            productNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configurePriceLabel() {
        
        selectionStyle = .gray
        contentView.addSubview(priceLabel)
      
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,constant: 60),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        
    }
    func configureButton() {
        
//        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
//        addToCartButton.backgroundColor = .darkGray
//        addToCartButton.setTitle("Add to Cart", for: .normal)
//        addToCartButton.layer.cornerRadius = 5
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        
        addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 100),
            addToCartButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        
        
    }
    @objc func addToCart() {
        print(selectedProduct!)
        print("button pressed")
        delegate.addToCartButtonPressed(product: selectedProduct!)
    }
    
    func configureFavoriteButton() {
        
        addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favButtonChanged), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: addToCartButton.topAnchor,constant: -5),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            
        ])
        
    }
    
    @objc func favButtonChanged() {
        delegate.deleteProductFromFavorites(product: selectedProduct!)
        
    }
    
    
    
    func set(product: Product){
        brandLabel.text = product.brand
        productNameLabel.text = product.name
        priceLabel.text = "$" + String(product.price * count) 
        productImage.image = UIImage(named: "image.png")
        self.selectedProduct = product
     
    }
    func configPrice(product: Product) {
        print("configgiaşfa")
        DispatchQueue.main.async {
            self.priceLabel.text =  "$" + String(Double(round(1000*product.price)/1000)
                * self.count)
            PersistenceManager.updateProductCount(product: product) { (result) in
                     print("asdsasdasfsa")
                     switch result {
                     case .success([]):
                         print("success")
                     case .failure(let error):
                         print(error.rawValue)
                     case .success(_):
                         print("ass")
                     }
                 }
        }
     
        
    }

}


