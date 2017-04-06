//
//  LoginCollectionViewCell.swift
//  Audible
//
//  Created by Stef on 4/6/17.
//  Copyright © 2017 Stef. All rights reserved.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI elements
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "logo")
        
        return image
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        //logo
        NSLayoutConstraint.activate(
            [logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
             logoImageView.widthAnchor.constraint(equalToConstant: 160.0),
             logoImageView.heightAnchor.constraint(equalToConstant: 160.0),
             logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 200.0),])
        //textfields
        NSLayoutConstraint.activate(
            [emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8.0),
             emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32.0),
             emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
             emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32.0),])
        NSLayoutConstraint.activate(
            [passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16.0),
             passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32.0),
             passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
             passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32.0),])
        //login button
        NSLayoutConstraint.activate(
            [loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
             loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32.0),
             loginButton.heightAnchor.constraint(equalToConstant: 50.0),
             loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32.0),])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
