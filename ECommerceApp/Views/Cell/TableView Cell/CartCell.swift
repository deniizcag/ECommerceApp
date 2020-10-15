//
//  FavoriteCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 23.09.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

//
//protocol deleteFromFavorites {
//    func deleteProduct(product: ProductViewModel)
//}
protocol CartCellDelegate {
    func productCountChanged()
}
class CartCell: UITableViewCell {
    
    static let reuseID = "ProductCategoryCell"
    let brandLabel = EcomBrandLabel(fontSize: 20, weight: .regular)
    let productImage = UIImageView()
    let productNameLabel = EcomProductNameLabel(fontSize: 15, weight: .light)
    let priceLabel      = EcomPriceLabel(alignment: .center, font: 20, weight: .light)
  
    
    let countLabel     = UILabel()
    var delegate : CartCellDelegate!
    var selectedProduct : Product!
    
    let buttonStackView = UIStackView()
    let button = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    
    var count = 1.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configureBrandLabel() 
        configureNameLabel()
        configureStackView()
        configurePriceLabel()
        
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func decreaseCounter() {
        if count <= 1 {
            countLabel.text = String(Int(1))
            button2.setTitle(String(Int(1)), for: .normal)
        } else {
            count -= 1
            countLabel.text = String(Int(count))
            button2.setTitle(String(Int(count)), for: .normal)
            configPrice(product: selectedProduct)
        }
    }
    @objc func increaseCounter() {
        count += 1
        countLabel.text = String(Int(count))
        button2.setTitle(String(Int(count)), for: .normal)
        configPrice(product: selectedProduct)
    }
    
    func configureStackView() {
        
        button.setTitle("-", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 27)
        //button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decreaseCounter), for: .touchUpInside)
        
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = "1"
        countLabel.font = UIFont.systemFont(ofSize: 13)
        
        countLabel.backgroundColor = .darkGray
        countLabel.layer.cornerRadius = 13
        countLabel.layer.masksToBounds = true
        countLabel.textAlignment = .center
        
        countLabel.textColor = .systemGray6
        
        button2.setTitle("1", for: .normal)
        button2.backgroundColor = UIColor.darkGray
        button2.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        button2.layer.cornerRadius = 15
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button3.setTitle("+", for: .normal)
        button3.setTitleColor(.lightGray, for: .normal)
        button3.titleLabel!.font = UIFont.systemFont(ofSize: 27)
        
        //button3.backgroundColor = UIColor.gray
        button3.layer.cornerRadius = 15
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.addTarget(self, action: #selector(increaseCounter), for: .touchUpInside)
        
        
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 2.0
        
        buttonStackView.addArrangedSubview(button)
        buttonStackView.addArrangedSubview(countLabel)
        buttonStackView.addArrangedSubview(button3)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: productNameLabel.topAnchor,constant: 110),
            //buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant: 25),
            buttonStackView.widthAnchor.constraint(equalToConstant:  75)
        ])
        
    }
    
    func configureImage() {
        accessoryType = .disclosureIndicator
        productImage.contentMode = .scaleAspectFill
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "sq.jpeg")
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImage.widthAnchor.constraint(equalToConstant: 80),
            productImage.heightAnchor.constraint(equalToConstant: 160),
            
        ])
    }
    
    func configureBrandLabel() {
        selectionStyle = .gray
        contentView.addSubview(brandLabel)
        
        NSLayoutConstraint.activate([
            brandLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor,constant: 20),
            brandLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            brandLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureNameLabel() {

        contentView.addSubview(productNameLabel)
       
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            productNameLabel.topAnchor.constraint(equalTo: brandLabel.topAnchor,constant: 30),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            productNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configurePriceLabel() {
        selectionStyle = .gray
        contentView.addSubview(priceLabel)
       
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: buttonStackView.trailingAnchor,constant: 80),
            priceLabel.topAnchor.constraint(equalTo: buttonStackView.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        
    }
    @objc func removeAll() {
        print("asda")
    }
    
    
    func set(product: Product){
        brandLabel.text = product.brand
        productNameLabel.text = product.name
        priceLabel.text = String(format: "$%.2f", product.price * Double(product.productCount)) // String(product.price * Double(product.productId)) + " TL"
        productImage.image = UIImage(named: "image.png")
        self.selectedProduct = product
        print("product count is \(product.productCount)")
        self.count = Double(Int(product.productCount))
        DispatchQueue.main.async {
            self.countLabel.text = String(Int(self.count))
            self.selectedProduct.productCount = Int(self.count)
            print("count is \(self.selectedProduct.productCount)")
            
        }
    }
    func configPrice(product: Product) {
        DispatchQueue.main.async {
            self.priceLabel.text = "$" + String(Double(round(1000*product.price)/1000)
                * self.count)
            self.selectedProduct.productCount = Int(self.count)
            
            DispatchQueue.main.async {
                self.priceLabel.text = "$" + String(Double(round(1000*product.price)/1000)
                    * self.count) 
                PersistenceManager.updateProductCount(product: product) { (result) in
                    switch result {
                    case .success([]):
                        print("success")
                        self.set(product: product)
                        print("count")
                    case .failure(let error):
                        print(error.rawValue)
                    case .success(_):
                        print("ass")
                    }
                }
            }
            
            self.delegate.productCountChanged()
            
        }
    }
}

extension CartCell:UIPickerViewDataSource,UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.count = Double(row+1)
        
        return String(Int(count))
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    
}
