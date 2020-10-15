//
//  EcomButton.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 14.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

class EcomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
     convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
    }
    convenience init (title: String,font : CGFloat) {
        self.init()
        self.setTitle(title,for: .normal)
         titleLabel?.font = .systemFont(ofSize: font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkGray
        layer.cornerRadius = 5
    }
}
