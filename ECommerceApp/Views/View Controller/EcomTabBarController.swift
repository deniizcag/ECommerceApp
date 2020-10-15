//
//  EcomTabBarController.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 25.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class EcomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createHomepageNC(),createCategoriesNC(),createMyCartNC(),createFavoritesNC(),createOrdersNC()]

    }
    
    func createHomepageNC() -> UINavigationController {

        
        let homeVC = HomepageVC()
        
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
        
        
    }
    func createCategoriesNC() -> UINavigationController {
        
        
        let categoriesVC = CategoriesVC()
                
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.dash"), tag: 1)
        
        return UINavigationController(rootViewController: categoriesVC)
        
        
    }
    
    func createMyCartNC() -> UINavigationController {
        
        let cartVC = CartVC()

        cartVC.tabBarItem = UITabBarItem(title: "My Cart", image: UIImage(systemName: "cart.fill"), tag: 2)
        
        return UINavigationController(rootViewController: cartVC)
    }
   
    func createFavoritesNC() -> UINavigationController {
           
           let favoritesVC = FavoriteProductsListVC()
           
           favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 3)

          
           return UINavigationController(rootViewController: favoritesVC)
       }
      
    func createOrdersNC() -> UINavigationController {
             
             let ordersVC = OrdersVC()
             
             ordersVC.tabBarItem = UITabBarItem(title: "My Orders", image: UIImage(systemName: "cube.box.fill"), tag: 4)

             return UINavigationController(rootViewController: ordersVC)
         }
    
    

}
