//
//  ProductListViewModel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 29.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation


enum FetchProductCategory {
    case favoriteProducts,cartProducts,allProducts
}

class ProductsListViewModel {
    
    var allProducts = [Product]()
    var filteredProducts = [Product]()
    var isSearching = false
    var favoritedProducts = [Product]()
    var cartProducts    = [Product]()
    var orders           = [Order]()
    
     func addProduct(product: Product) {
        self.allProducts.append(product)
    }
    func addToCartProducts(product: Product) -> ProductError? {
        var errorRes : ProductError?
        
        PersistenceManager.updateProducts(key: .cartProducts, product: product, actionType: .add) { (error) in
                   if error != nil {
                    errorRes = error
                   }
                   else {
                    errorRes = nil
                       print(" added to cart")
                   }
               }
        return errorRes

    }
   
//    func getOrders() {
//        PersistenceManager.retrieveOrders { (result) in
//                switch result {
//                    case .success(let orders):
//
//                        self.order = orders
//                    case .failure(let error):
//                        print(error)
//                    }
//        }
//    }
//
    func createOrder(order: Order) -> Bool {
        PersistenceManager.retrieveOrders { (result) in
            switch result {
            case .success(let orders):
                self.orders = orders
                self.orders.append(order)
            case .failure(let error):
               print(error)
            }
        }

        if PersistenceManager.saveOrder(orders: orders) {
            return true
        }
        else {
            return false
        }
        
        
    }
    
    func cleanCart(order: Order) {
        if createOrder(order: order) {
            PersistenceManager.cleanCart { (error) in
                if error != nil {
                    print("can not be cleaned")
                }
                else {
                    print("cleaned successfully")
                    self.cartProducts.removeAll()
                    
                }
            }
        }
        else {
            
           
        }
    
            
        }
      

    
    
     func filterCategory(category: ProductCategory) {
        
        self.allProducts = self.allProducts.filter {
            $0.category == category
        }
        
    }
     func getActiveProducts() -> [Product] {
      
        return isSearching ? filteredProducts : allProducts
        
    }
    func removeFromFavorites(product: Product) {
        
        PersistenceManager.updateProducts(key: .favorites, product: product, actionType: .remove) { (error) in
            if (error != nil) {
                print("can not deleted")
            }
            else {
                print("deleted successfully")
            }
        }
        
        
        self.favoritedProducts.removeAll{
            $0.name == product.name
        }
    }
    func removeFromCart(product: Product) {
        PersistenceManager.updateProducts(key: .cartProducts, product: product, actionType: .remove) { (error) in
            if (error != nil) {
                print("can not deleted")
            }
            else {
                print("deleted successfully")
            }
        }
        
        
        self.cartProducts.removeAll{
            $0.name == product.name
        }
    }
    
    func totalPriceCount() -> Double {
        print(cartProducts.map{$0.productCount })
        let total = cartProducts.map({ $0.price * Double($0.productCount)  }).reduce(0,+)
        return  total
        
    }
    func getFavoriteProducts() {
        
        PersistenceManager.retrieveProducts(key: .favorites) { (result) in
            switch result {
            case .success(let favProducts):
                
                self.favoritedProducts = favProducts
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func getCartProducts() {
        PersistenceManager.retrieveProducts(key: .cartProducts) { (result) in
            switch result {
            case .success(let favProducts):
                self.cartProducts = favProducts
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMockData() {
        
        let product1 = Product(name: " Woman New Light Gray Sweatpants", brand:
            "Pangaia", price: 259.99, category: .woman, productCount: 1, sellingCat: .bestSellers)
        let product2 = Product(name: "Man Blue Slim Pants", brand: "Armani Jeans", price: 319.99, category: .man,productCount: 1, sellingCat: .mostViewed)
        let product3 = Product(name: "Smart Watch New Generation 5.0", brand: "Xiaomi", price: 259.99, category: .electronic,productCount: 1, sellingCat: .topRated)
        let product4 = Product(name: "Woman White Sneakers", brand: "Adidas", price: 639.99, category: .woman,productCount: 1,sellingCat: .bestPriceOffer)
        let product5 = Product(name: "Red Hoodie Man", brand: "GAP", price: 119.99, category: .man, productCount: 1, sellingCat: .bestSellers)
        
        let products = [product1
            ,product2,product3,product4,product5]
              
              for _ in 0..<3 {
                  
                  for product in products {
              
                      self.addProduct(product: product)
                  }
              }
        
    }
  
    
    
}
