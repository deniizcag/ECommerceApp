//
//  ProductDetailVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 30.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

protocol ProductDetailViewDelegate {
    func deleteFromFavorites(product: Product)
}

class ProductDetailVC: UIViewController {
    
    let productImage      = UIImageView()
    let productBrandLabel = EcomBrandLabel(fontSize: 25, weight: .semibold)
    let productNameLabel  = EcomProductNameLabel(fontSize: 20, weight: .light)
    let productPriceLabel = EcomPriceLabel()
    let cardView          = UIView()
    var product           : Product?
    var scrollView        : UIScrollView!
    let stackView         = UIStackView()
    let addToCartButton   = EcomButton(title: "Add to Cart")
    let stackViewCard     = UIView()
    let favoriteButton    = EcomFavoriteButton()
    var isFavorite        = false
    var delegate: ProductDetailViewDelegate!
    
    
    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureViewController()
        configureCardView()
        configureImage()
        configureBrandLabel()
        configureFavoriteButton()
        configureNameLabel()
        configureStackViewCard()
        configureProductPriceLabel()
        configureButton()
        getFavorites(category: .favoriteProducts)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? FavoriteProductsListVC {
                   DispatchQueue.main.async {
                    print("dssfds")
                       firstVC.tableView.reloadData()
                   }
               }
    }
    func getFavorites(category : FetchProductCategory) {

        PersistenceManager.retrieveProducts(key: .favorites) { (result) in
            switch result {
            case .success(let models):
                if models.contains(self.product!) {
                    self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                }
                else {
                    self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func configureScrollView() {
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        
        
        print(product!)
        dismiss(animated: true)
    }
    
    func configureCardView() {
        
        scrollView.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.masksToBounds = false
        cardView.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: view.frame.height),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            cardView.widthAnchor.constraint(equalToConstant: scrollView.frame.width)
        ])
    }
    
    func configureImage() {
        
        let width = view.frame.width
        var imageHeight : CGFloat = 0
        if width > 400
        {
            imageHeight = view.frame.height * 0.7
        }
        else {
            imageHeight = view.frame.height * 0.6

        }
        
        cardView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "image.png")
        productImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: cardView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: imageHeight)
            
        ])
        
    }
    
    func configureBrandLabel() {
        
        cardView.addSubview(productBrandLabel)
      
        productBrandLabel.text = product!.brand
        
        NSLayoutConstraint.activate([
            
            productBrandLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor,constant: 10),
            productBrandLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            //productBrandLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -10),
            productBrandLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    func configureFavoriteButton() {
        
        cardView.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            
            favoriteButton.topAnchor.constraint(equalTo: productBrandLabel.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        
    }
    
    @objc func favoriteButtonPressed() {
        
        if !self.isFavorite {
            self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.isFavorite = true
            
            PersistenceManager.updateProducts(key: .favorites,product: self.product!, actionType: .add) { (error) in
                if (error != nil) {
                    PersistenceManager.updateProducts(key: .favorites, product: self.product!, actionType: .remove) { (error) in
                        if (error != nil) {
                            print("can not deleted")
                        }
                        else {
                            print("deleted successfully")
                        }
                    }
                    
                    
                    self.favoriteButton.setBackgroundImage(UIImage(systemName:
                        "heart"), for: .normal)
                    self.isFavorite = false
                    print(self.product!)
                    self.delegate.deleteFromFavorites(product: self.product!)
                    
                }
                else {
                    print("saved successfully")
                }
            }
            
        }
        else {
            
            PersistenceManager.updateProducts(key: .favorites, product: self.product!, actionType: .remove) { (error) in
                if (error != nil) {
                    print("can not deleted")
                }
                else {
                    print("deleted successfully")
                }
            }
            delegate.deleteFromFavorites(product: product!)

            self.favoriteButton.setBackgroundImage(UIImage(systemName:
                "heart"), for: .normal)
            self.isFavorite = false
        }

    }
    
    
    func configureNameLabel() {
        
        cardView.addSubview(productNameLabel)
        productNameLabel.text = product!.name

        
        NSLayoutConstraint.activate([
            
            productNameLabel.topAnchor.constraint(equalTo: productBrandLabel.bottomAnchor,constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -10),
            productNameLabel.heightAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
    func configureStackViewCard() {
        
        view.addSubview(stackViewCard)
        stackViewCard.addSubview(productPriceLabel)
        stackViewCard.addSubview(addToCartButton)
        stackViewCard.layer.borderWidth = 0.3
        stackViewCard.layer.borderColor = UIColor.lightGray.cgColor
        
        stackViewCard.translatesAutoresizingMaskIntoConstraints = false
        stackViewCard.backgroundColor = .secondarySystemBackground
        stackViewCard.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            
            stackViewCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackViewCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackViewCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackViewCard.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        
    }
    
    func configureButton() {
        
//        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
//        addToCartButton.backgroundColor = .darkGray
//        addToCartButton.setTitle("Add to Cart", for: .normal)
//        addToCartButton.layer.cornerRadius = 5
        
        favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            addToCartButton.topAnchor.constraint(equalTo: stackViewCard.topAnchor, constant: 10),
            addToCartButton.leadingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor, constant: 10),
            addToCartButton.bottomAnchor.constraint(equalTo: stackViewCard.bottomAnchor, constant: -10),
            addToCartButton.widthAnchor.constraint(equalToConstant: 200),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
            addToCartButton.trailingAnchor.constraint(equalTo: stackViewCard.trailingAnchor, constant: -20)
        ])

    }
    
    @objc func addToCart() {
       
        PersistenceManager.updateProducts(key: .cartProducts, product: product!, actionType: .add) { (error) in
            if error != nil {
                self.presentAlert(title: "Something went wrong", message: error!.rawValue, buttonTitle: "Ok")
            }
            else {
                self.presentAlert(title: "Success !", message: "Product is added to cart", buttonTitle: "Ok")
            }
        }
    }
    
    func configureProductPriceLabel() {
        productPriceLabel.text = "$" + String(product!.price)
       
        
        NSLayoutConstraint.activate([
            
            productPriceLabel.topAnchor.constraint(equalTo: stackViewCard.topAnchor, constant: 10),
            productPriceLabel.leadingAnchor.constraint(equalTo: stackViewCard.leadingAnchor, constant: 10),
            productPriceLabel.bottomAnchor.constraint(equalTo: stackViewCard.bottomAnchor, constant: -10),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
        
        
    }
    
    
}

