//
//  CategoryListViewModel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 27.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

class CategoryListViewModel {
    var allCategories = [Category]()
    
    init() {
        let manCat = Category(name: .man, image: .man)
        let womanCat = Category(name: .woman, image: .woman)
        let homeCat = Category(name: .homeLifeStyle, image: .homeLifeStyle)
        let electronicCat = Category(name: .electronic, image: .electronic)
        let sportsCat = Category(name: .sportsOutdoor, image: .sportsOutdoor)
        let furnituresCat = Category(name: .furniture, image: .furniture)
        let shoesCat = Category(name: .shoesAndBags, image: .shoesAndBags)
        let watchCat = Category(name: .watchAccesory, image: .watchAccesory)
        
     allCategories.append(manCat)
     allCategories.append(womanCat)
     allCategories.append(homeCat)
     allCategories.append(electronicCat)
     allCategories.append(sportsCat)
     allCategories.append(furnituresCat)
     allCategories.append(shoesCat)
     allCategories.append(watchCat)
        
    }
    
//     func getAllCategories() -> [CategoryViewModel] {
//
//        let manCat = CategoryViewModel(name: .man, image: .man)
//        let womanCat = CategoryViewModel(name: .woman, image: .woman)
//        let homeCat = CategoryViewModel(name: .homeLifeStyle, image: .homeLifeStyle)
//        let electronicCat = CategoryViewModel(name: .electronic, image: .electronic)
//        let sportsCat = CategoryViewModel(name: .sportsOutdoor, image: .sportsOutdoor)
//        let furnituresCat = CategoryViewModel(name: .furniture, image: .furniture)
//        let foodsCat = CategoryViewModel(name: .foodsAndDrinks, image: .foodsAndDrinks)
//        let shoesCat = CategoryViewModel(name: .shoesAndBags, image: .shoesAndBags)
//        let watchCat = CategoryViewModel(name: .watchAccesory, image: .watchAccesory)
//
//        categoryList.append(manCat)
//        categoryList.append(womanCat)
//        categoryList.append(homeCat)
//        categoryList.append(electronicCat)
//        categoryList.append(sportsCat)
//        categoryList.append(furnituresCat)
//        categoryList.append(foodsCat)
//        categoryList.append(shoesCat)
//        categoryList.append(watchCat)
//
//        return categoryList
//    }
//
}
