//
//  ErrorMessage.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 18.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

enum ProductError : String,Error {
    case invalidUsername  = "This username created invalid request"
    case unableToComplete = "Unable to connect request. Please check your internet connection"
    case invalidResponse  = "Invalid response from server. Please try again."
    case invalidData      = "Invalid Data. Please try again"
    case unableToFavorite = "Unable to add favorite. Please try again"
    case alreadyInFavorites = "Unable to add favorite. It already exists"
    case alreadyInCart      = "Unable to adding cart. It already exists"
}
