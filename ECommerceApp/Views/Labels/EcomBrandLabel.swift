//
//  EcomBrandLabel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 14.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class EcomBrandLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(fontSize: CGFloat,weight: UIFont.Weight){
        self.init()
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    func configureLabel() {
        
        textAlignment = .left
        textColor = .darkGray
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
