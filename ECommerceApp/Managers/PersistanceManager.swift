//
//  PersistanceManager.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 18.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation


enum PersistenceActionType {
    case add,remove,removeAll
}
enum getCat {
      case favorites,cartProducts
   }

enum getOrder {
    case order
}

struct PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
        static let cartProducts = "cart"
        static let order = "order"
    }

       static func updateOrders(order: Order,completed: @escaping ((Bool)?) -> Void) {
        
           retrieveOrders { (result) in
               switch result {
               case .success(let favorites):
                   var retrievedFavorites = favorites
                 
                   retrievedFavorites.append(order)
                       
                
                   
                   completed(saveOrder(orders: retrievedFavorites))
                   return
               case .failure(let error):
                print(error)
                   completed(false)
                   return
               }
           }
    
       }
    
    
    
    
    static func updateProducts(key: getCat,product: Product, actionType: PersistenceActionType, completed: @escaping ((ProductError)?) -> Void) {
  
        retrieveProducts(key: key) { (result) in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(product) else {
                        switch key {
                        case .cartProducts:
                            completed(.alreadyInCart)
                            
                        default:
                            completed(.alreadyInFavorites)
                            
                        }
                  
                        return
                    }
                    retrievedFavorites.append(product)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.name == product.name  }
                case .removeAll:
                    retrievedFavorites.removeAll()
                }
                
                completed(save(key: key,favorites: retrievedFavorites))
                return
            case .failure(let error):
                completed(error)
                return
            }
        }
 
    }
    static func cleanCart(completed: @escaping ((ProductError)?)-> Void) {
        retrieveProducts(key: .cartProducts) { (result) in
            switch result {
            case .success(let products):
                 var retrievedProducts = products
                 retrievedProducts.removeAll()
                 completed(save(key: .cartProducts, favorites: retrievedProducts))
            case .failure(let error):
                completed(error)
            }
        }
    }
   
    static func retrieveProducts(key: getCat,completed: @escaping (Result<[Product],ProductError>) -> Void ) {
        switch key {
        case .favorites:
            guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
                print("coming..")
                completed(.success([]))
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Product].self, from: favoritesData)
                completed(.success(followers))
            } catch {
                print("adasd")
                completed(.failure(.invalidData))
            }
        case .cartProducts:
            guard let cartData = defaults.object(forKey: Keys.cartProducts) as? Data else {
                completed(.success([]))
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Product].self, from: cartData)
                completed(.success(followers))
            } catch {
                print("asd")
                completed(.failure(.invalidData))
            }
            
        }
   
           
        }
    static func retrieveOrders(completed: @escaping (Result<[Order],ProductError>) -> Void ) {
         
          
           guard let orderData = defaults.object(forKey: Keys.order) as? Data else {
                    print("coming..")
                    completed(.success([]))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let followers = try decoder.decode([Order].self, from: orderData)
                    completed(.success(followers))
                } catch {
                    print("adasd")
                    completed(.failure(.invalidData))
                }
            
                }
    

    static func saveOrder(orders: [Order]) -> Bool {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(orders)
            defaults.set(encodedFavorites, forKey: Keys.order)
            print("order saved succesfully")
            return true
        } catch {
            print("order error for saving")
            return false
        }
        
        
        
    }
  
    
   
    
    static func save(key: getCat,favorites: [Product]) ->ProductError? {
        switch key {
        case .favorites:
            do {
                let encoder = JSONEncoder()
                let encodedFavorites = try encoder.encode(favorites)
                defaults.set(encodedFavorites, forKey: Keys.favorites)
                return nil
            } catch {
                return .unableToFavorite
            }
            
        case .cartProducts:
            do {
                let encoder = JSONEncoder()
                let encodedFavorites = try encoder.encode(favorites)
                defaults.set(encodedFavorites, forKey: Keys.cartProducts)
                return nil
            } catch {
                return .unableToFavorite
            }
        
        }
        

    }
    static func updateProductCount(product: Product,completed: @escaping (Result<[Product],ProductError>) -> Void) {
        
        guard let cartData = defaults.object(forKey: Keys.cartProducts) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Product].self, from: cartData)
            if let indexOfA = followers.firstIndex(of: product) {
                followers[indexOfA].productCount = product.productCount
                print("changing in db")
            }
            
            do {
                let encoder = JSONEncoder()
                let encodedFavorites = try encoder.encode(followers)
                defaults.set(encodedFavorites, forKey: Keys.cartProducts)
                completed(.success([]))
            } catch {
                completed(.failure(.invalidData))
                
            }
            
            

        } catch {
            completed(.failure(.invalidData))
        }

    }
    
    
}
