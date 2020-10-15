//
//  OrderDetailVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 12.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {

    var orderDateLabel = UILabel()
    var totalPriceLabel = EcomPriceLabel(alignment: .left, font: 20,weight: .medium)
    var productCountLabel = UILabel()
    var tableView       = UITableView()
    var order           : Order!
    var productListViewModel = ProductsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureOrderDateLabel()
        configureProductCountLabel()
        configurePriceLabel()
        configureTableView()
       
    }
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
       func configureViewController() {
        title = "Order Detail"
        view.backgroundColor = .systemGray5
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
           navigationItem.rightBarButtonItem = doneButton
       }
    
       @objc func dismissVC() {
           
           dismiss(animated: true)
       }
       
    func configureOrderDateLabel() {
        view.addSubview(orderDateLabel)
       orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let formatter = DateFormatter()
             formatter.dateFormat = "MM/d/yyyy HH:mm"
        let result = formatter.string(from: order.date)
    
       orderDateLabel.text = "Order Time: " + result
       orderDateLabel.textAlignment = .left
       orderDateLabel.textColor = .darkGray
       orderDateLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
   
        NSLayoutConstraint.activate([
            
            orderDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            orderDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            orderDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            orderDateLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])

    }
    func configurePriceLabel() {
        view.addSubview(totalPriceLabel)
        totalPriceLabel.text = "$ " + String(format: "%.2f", order.cost)

        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: productCountLabel.bottomAnchor, constant: 10),
            totalPriceLabel.leadingAnchor.constraint(equalTo: productCountLabel.leadingAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: productCountLabel.trailingAnchor),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
     
    }
    func configureProductCountLabel() {
        view.addSubview(productCountLabel)
        productCountLabel.translatesAutoresizingMaskIntoConstraints = false
        let totalCount = order.products.map({ Int($0.productCount)  }).reduce(0,+)
        productCountLabel.text = "Product Count: " + String(totalCount)
        totalPriceLabel.textAlignment = .left
        productCountLabel.textColor = .darkGray
        productCountLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
                productCountLabel.topAnchor.constraint(equalTo: orderDateLabel.bottomAnchor, constant: 10),
                productCountLabel.leadingAnchor.constraint(equalTo: orderDateLabel.leadingAnchor),
                productCountLabel.trailingAnchor.constraint(equalTo: orderDateLabel.trailingAnchor),
                productCountLabel.heightAnchor.constraint(equalToConstant: 30)
              ])
    
    }
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 160
         tableView.separatorStyle = .singleLine
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.layoutMargins = .zero
         tableView.separatorInset = .zero
        tableView.layer.cornerRadius = 15
         tableView.delegate = self
         tableView.dataSource = self
         
       
         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor,constant: 10),
             tableView.leadingAnchor.constraint(equalTo: orderDateLabel.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: orderDateLabel.trailingAnchor),
             
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
         ])
        tableView.register(OrderDetailCell.self, forCellReuseIdentifier: OrderDetailCell.reuseID)
    }

}
extension OrderDetailVC : UITableViewDelegate,UITableViewDataSource,ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product) {
                productListViewModel.removeFromCart(product: product)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let product = order.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.reuseID, for: indexPath) as! OrderDetailCell
        cell.set(product: product)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = order.products[indexPath.row]
            let destinationVC = ProductDetailVC(product: selectedProduct)
            destinationVC.delegate = self
            let navController = UINavigationController(rootViewController: destinationVC)
            present(navController, animated: true)
    }
    
    
}
