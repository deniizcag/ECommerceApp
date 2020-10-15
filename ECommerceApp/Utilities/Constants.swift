//
//  Constants.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 26.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

enum SellingCategory:String,Decodable,Encodable {
    
    case bestSellers    = "Best Sellers"
    case mostViewed     = "Most Viewed"
    case topRated       =  "Top Rated"
    case bestPriceOffer = "Best Prices, Best Offers"
    case normal         = "Normal"
}

enum ProductCategory: String, CaseIterable,Decodable,Encodable{
    case man            = "Man"
    case woman          = "Woman"
    case homeLifeStyle  = "Home & Lifestyle"
    case electronic     = "Electronic"
    case sportsOutdoor  = "Sports & Outdoor"
    case furniture      = "Furnitures"
    case shoesAndBags   = "Shoes & Bag"
    case watchAccesory  = "Watch & Accesory"
}
enum CategoryImage: String,CaseIterable,Decodable,Encodable {
    case man            = "man_cat.jpg"
    case woman          = "woman_cat.jpg"
    case homeLifeStyle  = "home_cat.jpg"
    case cosmeticCare   = "cosmetic_cat.jpg"
    case electronic     = "electronic_cat.jpg"
    case momAndKid      = "mom_cat.jpg"
    case watchAccesory  = "watch_cat.jpg"
    case shoesAndBags   = "shoes_cat.jpg"
    case sportsOutdoor  = "sport_cat.jpg"
    case furniture      = "furnitures_cat.jpg"
}
