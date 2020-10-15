//
//  ViewController+Ext.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 13.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String,message: String,buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
