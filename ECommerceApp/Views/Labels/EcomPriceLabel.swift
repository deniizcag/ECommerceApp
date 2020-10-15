//
//  EcomPriceLabel.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 14.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class EcomPriceLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(alignment: NSTextAlignment,font : CGFloat,weight: UIFont.Weight ) {
        self.init()
        self.font = UIFont.systemFont(ofSize: font, weight: weight)
        self.textAlignment = alignment
    }
    
    func configureLabel() {
    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .center
    textColor = .darkGray
    font = UIFont.systemFont(ofSize: 25, weight: .medium)
    }

}
