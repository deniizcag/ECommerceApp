//
//  Order.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 9.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

class Order:Codable {
    var products: [Product]!
    var date:    Date
    var cost: Double
    
    init(products: [Product],date: Date,cost:Double) {
        self.products = products
        self.date     = date
        self.cost     = cost
        
    }
}
