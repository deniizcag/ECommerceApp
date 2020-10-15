//
//  ProductViewModel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 29.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

extension  Product {
    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(brand)
        hasher.combine(productCount)
        hasher.combine(brand)
        hasher.combine(category)
        hasher.combine(sellingCat)
    }
}


class Product :Codable,Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name       : String
    var brand      : String
    var price      : Double
    var category   : ProductCategory
    var productCount  : Int
    var sellingCat : SellingCategory
    
    
    
    init(name: String,brand:String,price:Double,category:ProductCategory,productCount:Int,sellingCat:SellingCategory) {
        self.name  = name
        self.brand = brand
        self.price = price
        self.category = category
        self.productCount = productCount
        self.sellingCat = sellingCat
    }
    
}
