//
//  AlertVC.swift
//  ECommerceApp
//
//  Created by DenizCagilligecit on 13.10.2020.
//  Copyright © 2020 Deniz Cagilligecit. All rights reserved.
//

import UIKit


class AlertVC: UIViewController {
    
    var alertTitle:String?
    var message:String?
    var buttonTitle:String?
//
//    var alertTitleLabel = MovTitleLabel(fontSize: 25, alignment: .center)
//    var messageBodyLabel = MovBodyLabel(textAlignment: .center)
//    var alertButton = MovButton(title: "Ok", backgroundColor: .red)
//
    var alertTitleLabel = UILabel()
    var messageBodyLabel = UILabel()
    var alertButton = EcomButton(title: "Ok")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(title:String,message:String,buttonTitle:String) {
        self.init()
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var containerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureAlertTitleLabel()
        configureMessageBodyLabel()
        configureAlertButton()
    }
    
    func configureContainerView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.black.cgColor
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant:  300),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
        
    }
    func configureAlertTitleLabel() {
        containerView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitle ?? "Something went wrong"
        alertTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertTitleLabel.textAlignment = .center
        alertTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            alertTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            alertTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func configureMessageBodyLabel() {
        containerView.addSubview(messageBodyLabel)
        messageBodyLabel.text = message ?? "Error"
        messageBodyLabel.translatesAutoresizingMaskIntoConstraints = false
       messageBodyLabel.translatesAutoresizingMaskIntoConstraints = false
       messageBodyLabel.textAlignment = .center
       messageBodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        NSLayoutConstraint.activate([
            messageBodyLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 12),
            messageBodyLabel.leadingAnchor.constraint(equalTo: alertTitleLabel.leadingAnchor),
            messageBodyLabel.trailingAnchor.constraint(equalTo: alertTitleLabel.trailingAnchor),
            messageBodyLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        
    }
    func configureAlertButton() {
        
        containerView.addSubview(alertButton)
        let padding: CGFloat = 30

        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            alertButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        alertButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
    }
    @objc func pressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
