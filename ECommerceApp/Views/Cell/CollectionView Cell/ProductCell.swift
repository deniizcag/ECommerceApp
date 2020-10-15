//
//  ProductCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 26.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    
    static let reuseID    = "ProductCell"
    let productImage      = UIImageView()
    let productBrandLabel = EcomBrandLabel(fontSize: 10, weight: .semibold)
    let productNameLabel  = UILabel()
    let productPriceLabel = EcomPriceLabel(alignment: .left, font: 14, weight: .medium)
    let cardView          = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCardView()
        configureImage()
        configureBrandLabel()
        configureProductName()
        configureProductPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCardView() {
        addSubview(cardView)
        
        cardView.layer.cornerRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.masksToBounds = false
        cardView.layer.borderWidth = 0.1
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),        
        ])
    }
    
    func configureImage() {
        
        cardView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "image.png")
        productImage.layer.masksToBounds = true
        
        productImage.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: cardView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 200)
        ])
     
    }
    
    func configureBrandLabel() {
        
        cardView.addSubview(productBrandLabel)
     
        NSLayoutConstraint.activate([
            productBrandLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor,constant: 5),
            productBrandLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 3),
            productBrandLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -10),
            productBrandLabel.heightAnchor.constraint(equalToConstant: 10)
            
        ])
        
    }
    
    func configureProductName() {
        cardView.addSubview(productNameLabel)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.text = "Man New Black Basic T-shirt"
        productNameLabel.textAlignment = .left
        productNameLabel.textColor = .gray
        productNameLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        productNameLabel.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            
            productNameLabel.topAnchor.constraint(equalTo: productBrandLabel.bottomAnchor,constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 3),
            productNameLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -10),
            productNameLabel.heightAnchor.constraint(equalToConstant: 10)
            
        ])
        
    }

    func configureProductPriceLabel() {
        cardView.addSubview(productPriceLabel)
        
        NSLayoutConstraint.activate([
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,constant: 5),
            productPriceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 3),
            productPriceLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -10),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 10)
            
        ])
        
        
    }
    func set(product: Product) {
        productNameLabel.text = product.name
        productPriceLabel.text = "$" + String(product.price)
        productBrandLabel.text = product.brand
        
    }
    
    
    
}
