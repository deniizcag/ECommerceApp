//
//  CategoryViewModel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 27.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

class Category {
    var name: ProductCategory
    var image: CategoryImage
    
    init(name: ProductCategory,image: CategoryImage) {
        self.name  = name
        self.image = image
    }
    
}
