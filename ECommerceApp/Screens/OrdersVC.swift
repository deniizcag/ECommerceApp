//
//  OrdersVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 25.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController {
    
    let tableView = UITableView()
    let productsListViewModel = ProductsListViewModel()
    let orderListViewModel   = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getProducts()
        configureTableView()
        getProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
    }

    func configureViewController() {
        view.backgroundColor = .red
        title = "My Orders"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.rowHeight = 60
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.reuseID)
    }
  
    
    func getProducts() {
        print(orderListViewModel.getOrders())
        //print(productsListViewModel.getOrders())
        //print(productsListViewModel.order.count)
        print(orderListViewModel.orders.count)
        tableView.reloadData()
    }
}

extension OrdersVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(orderListViewModel.orders.count)
        return orderListViewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.reuseID, for: indexPath) as! OrderCell
//
//        let date = Date()
     
        let order = orderListViewModel.orders[indexPath.row]
          let formatter = DateFormatter()
             formatter.dateFormat = "MM/d/yyyy HH:mm"
        let result = formatter.string(from: order.date)
        cell.orderLabel.text =  result
        cell.priceLabel.text = "Total Cost: $ " + String(format: "%.2f", order.cost)
       // _ = productsListViewModel.order[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orderListViewModel.orders[indexPath.row]
        let destinationVC = OrderDetailVC(order: order)
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
    
    
}


