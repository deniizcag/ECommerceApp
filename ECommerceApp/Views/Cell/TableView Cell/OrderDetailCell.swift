//
//  OrderDetailCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 12.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    static let reuseID = "OrderDetailCell"
    var productImage = UIImageView()
    var brandLabel   = EcomBrandLabel(fontSize: 20, weight: .semibold)
    var productLabel = EcomProductNameLabel(fontSize: 20, weight: .light)
    var priceLabel   = EcomPriceLabel(alignment: .left, font: 20, weight: .light)
    var countLabel    = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureProductImage()
        configureBrandLabel()
        configureProductNameLabel()
        configureCountLabel()
        configurePriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureProductImage() {
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "image.png")
        productImage.layer.masksToBounds = true
        
        productImage.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //productImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            productImage.widthAnchor.constraint(equalToConstant: 60),
            productImage.heightAnchor.constraint(equalToConstant: 120),
        ])
        
    }
    func set(product: Product) {
        brandLabel.text = product.brand
        productLabel.text = product.name
        countLabel.text = "Count: " + String(product.productCount)
        priceLabel.text = String(format: "$ %.2f", product.price)
    }
    func configureBrandLabel() {
        contentView.addSubview(brandLabel)
     
        NSLayoutConstraint.activate([
            brandLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            brandLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            brandLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    func configureProductNameLabel() {
        
        contentView.addSubview(productLabel)
       
        NSLayoutConstraint.activate([
            productLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            productLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor,constant: 10),
            productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
        
    }
    func configureCountLabel() {
        contentView.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.textAlignment = .left
        countLabel.textColor = .gray
        countLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        //countLabel.backgroundColor = .red
        NSLayoutConstraint.activate([
           countLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
           countLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor,constant: 10),
           countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -200),
           countLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    func configurePriceLabel() {
        contentView.addSubview(priceLabel)
  
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            priceLabel.centerXAnchor.constraint(equalTo: countLabel.centerXAnchor,constant: 200),
          //  priceLabel.leadingAnchor.constraint(equalTo: brandLabel.trailingAnchor,constant: 30),
            //priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
          //  priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
    }
    
    
}
