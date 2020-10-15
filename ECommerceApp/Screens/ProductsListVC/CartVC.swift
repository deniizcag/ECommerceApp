//
//  CartVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 25.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//


import UIKit

class CartVC: UIViewController {
    
    
    let tableView = UITableView()
    let productsListViewModel = ProductsListViewModel()
    
    let addToCartButton   = EcomButton(title: "Complete Order")
    let orderViewCard     = UIView()
    let productPriceLabel = EcomPriceLabel()
    let orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getProducts()
    
    }

    func configureViewController() {
        view.backgroundColor = .systemGray5
        title = "My Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
        updateTotalCount()
    }
    func updateTotalCount() {
        DispatchQueue.main.async {
            print(self.productsListViewModel.totalPriceCount())
            self.productPriceLabel.text = String(format: "$%.2f", self.productsListViewModel.totalPriceCount())
        }
    }
    
    func configureStackViewCard() {
        //view.backgroundColor = .red
        //stackViewCard.backgroundColor = .systemBlue
        view.addSubview(orderViewCard)
        orderViewCard.addSubview(productPriceLabel)
        orderViewCard.addSubview(addToCartButton)
        //stackViewCard.layer.borderWidth = 0.3
        //stackViewCard.layer.borderColor = UIColor.lightGray.cgColor
        
        orderViewCard.translatesAutoresizingMaskIntoConstraints = false
        orderViewCard.backgroundColor = .systemGray5
        orderViewCard.layer.masksToBounds = true
       
        NSLayoutConstraint.activate([
            orderViewCard.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            orderViewCard.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            orderViewCard.topAnchor.constraint(equalTo: tableView.bottomAnchor,constant: -7),
            orderViewCard.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        configureProductPriceLabel()
        configureButton()
        //tableView.backgroundColor = .red
    }
    
    func configureButton() {
        
        addToCartButton.addTarget(self, action: #selector(completeOrder), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            addToCartButton.topAnchor.constraint(equalTo: productPriceLabel.topAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //addToCartButton.bottomAnchor.constraint(equalTo: stackViewCard.bottomAnchor, constant: -10),
            addToCartButton.widthAnchor.constraint(equalToConstant: 180),
            //addToCartButton.heightAnchor.constraint(equalToConstant: 40),
            //addToCartButton.trailingAnchor.constraint(equalTo: stackViewCard.trailingAnchor, constant: -20)
        ])
        
    }
    
    @objc func completeOrder() {

        productsListViewModel.cleanCart(order: Order(products: productsListViewModel.cartProducts, date: Date(),cost: productsListViewModel.totalPriceCount()))
        updateTotalCount()
//        let domain = Bundle.main.bundleIdentifier!
//               UserDefaults.standard.removePersistentDomain(forName: domain)
//               UserDefaults.standard.synchronize()
//               print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        tableView.reloadData()
    }
    
    func configureProductPriceLabel() {
        
//        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
//        updateTotalCount()
//        productPriceLabel.textAlignment = .center
//        productPriceLabel.textColor = .darkGray
//        productPriceLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
//
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: orderViewCard.topAnchor, constant: 20),
            productPriceLabel.leadingAnchor.constraint(equalTo: orderViewCard.leadingAnchor, constant: 40),
            productPriceLabel.bottomAnchor.constraint(equalTo: orderViewCard.bottomAnchor, constant: -10),
            //productPriceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }
    
    func configureTableView() {
        tableView.rowHeight = 180
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        
        tableView.delegate = self
        tableView.dataSource = self
        let width = view.frame.width
        var bottomConstraint : CGFloat = 0
        
        if width > 400 {
            bottomConstraint = -150
        }
        else {
            bottomConstraint = -100
        }
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: bottomConstraint)
        ])
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        //tableView.layer.borderWidth = 0.3
        //tableView.layer.borderColor = UIColor.lightGray.cgColor
        configureStackViewCard()
    }
    func getProducts() {
        productsListViewModel.getCartProducts()
        tableView.reloadData()
    }
    
}
extension CartVC: CartCellDelegate,UITableViewDelegate,UITableViewDataSource,ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product) {
        productsListViewModel.removeFromCart(product: product)
    }
    
    func productCountChanged() {
        self.updateTotalCount()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProduct = productsListViewModel.cartProducts[indexPath.row]
        let destinationVC = ProductDetailVC(product: selectedProduct)
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID, for: indexPath) as! CartCell
        let product = productsListViewModel.cartProducts[indexPath.row]
        cell.set(product: product)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsListViewModel.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        productsListViewModel.removeFromCart(product: productsListViewModel.cartProducts[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .left)
        updateTotalCount()
    }
}
