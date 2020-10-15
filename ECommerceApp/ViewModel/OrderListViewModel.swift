//
//  OrderListViewModel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 9.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import Foundation

class OrderListViewModel {
    
    var orders = [Order]()
    var order  = [[Product]]()
    
    func getOrders() {
        print("fommfmfm")
          PersistenceManager.retrieveOrders { (result) in
                  switch result {
                      case .success(let orders):
                        self.orders = orders
                      case .failure(let error):
                          print(error)
                      }
          }
      }
 
    
    

    
}
