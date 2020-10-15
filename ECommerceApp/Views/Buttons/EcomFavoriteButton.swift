//
//  EcomFavoriteButton.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 14.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class EcomFavoriteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
       translatesAutoresizingMaskIntoConstraints = false
       titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       tintColor = .red
       setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        
    }
}
