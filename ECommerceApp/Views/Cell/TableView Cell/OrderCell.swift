//
//  OrderCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 7.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

  static let reuseID = "OrderCell"
        let orderLabel = UILabel()
    let priceLabel = EcomPriceLabel(alignment: .left, font: 15, weight: .light)
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureLabel()
            configureTotalPriceLabel()
        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        //selectionStyle = .gray
            //orderLabel.text = result
        accessoryType = .disclosureIndicator
            contentView.addSubview(orderLabel)
            orderLabel.translatesAutoresizingMaskIntoConstraints = false
            orderLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            NSLayoutConstraint.activate([
              //  orderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
              //  orderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                orderLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            orderLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
                orderLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -50),
                orderLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
            
        }
    func configureTotalPriceLabel() {
        contentView.addSubview(priceLabel)
//
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
//        priceLabel.textColor = .darkGray
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: orderLabel.bottomAnchor,constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: orderLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: orderLabel.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 15),
        
        
        ])
        
    }
    }
    

