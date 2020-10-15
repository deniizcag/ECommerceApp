//
//  ProductCategoryCell.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 27.08.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class ProductCategoryCell: UITableViewCell {
    static let reuseID = "ProductCategoryCell"
    let categoryLabel = UILabel()
    var categoryImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage() {
        accessoryType = .disclosureIndicator
        categoryImage.contentMode = .scaleAspectFill
        contentView.addSubview(categoryImage)
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        //categoryImage.image = UIImage(named: "sq.jpeg")
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryImage.widthAnchor.constraint(equalToConstant: 60),
            categoryImage.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }

    func configureLabel() {
        selectionStyle = .gray
        categoryLabel.text = "asdas"
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor,constant: 10),
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.topAnchor,constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
    }
}
extension ProductCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
        //cell.backgroundColor = .blue
        return cell
        
        
    }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
       }
    
    
    
    
    
}
