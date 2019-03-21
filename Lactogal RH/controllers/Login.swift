//
//  Login.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //============================================================
    let logo_label: UIImageView =
    {
        let param = UIImageView()
        let image = UIImage(named: "lactogal_logo")
        param.image = image
        param.contentMode = .scaleToFill
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    
    
    let email_field: UITextField =
    {
        let param = UITextField()
        param.placeholder = "example@website.com"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let password_field: UITextField =
    {
        let param = UITextField()
        param.placeholder = "**************"
        param.isSecureTextEntry = true
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let loginButton: UIButton =
    {
        let param = UIButton()
        param.setTitle("Login", for: UIControl.State.normal)
        param.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)
   
        param.addTarget(self, action: #selector(handle_login), for: UIControl.Event.touchUpInside)
        param.isEnabled = false
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let is_not_registered_button: UIButton =
    {
        let param = UIButton()
        
        param.setTitleColor(UIColor(red:2/255, green:23/255, blue:68/255, alpha:0.7), for: UIControl.State.normal)
        
        let attributedText = NSMutableAttributedString(string: "Ainda não tem conta?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedText.append(NSMutableAttributedString(string: " Cadastre-se", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red:0/255, green:137/255, blue:123/255, alpha:1)]))
        
        param.setAttributedTitle(attributedText, for: UIControl.State.normal)
        
        param.addTarget(self, action: #selector(register_label), for: UIControl.Event.touchUpInside)
        
        param.layer.cornerRadius = 4
        //param.addTarget(self, action: #selector(to_register_page), for: UIControl.Event.touchUpInside)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    //============================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        view.backgroundColor = UIColor(red:247/255, green:247/255, blue:255/255, alpha:1)
        
        
        setupViews()
        
        
    }
    
    @objc func handleTextInputChange()
    {
        let formValid = email_field.text?.count ?? 0 > 0 && password_field.text?.count ?? 0 > 0 &&  email_field.text?.contains("@") ?? true
        
        if formValid
        {
            loginButton.isEnabled = true;
            loginButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:1)
        }else
        {
            loginButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)
        }
        
    }
    
    @objc func to_register_page()
    {
        let formValid = email_field.text?.count ?? 0 > 0 && password_field.text?.count ?? 0 > 0 &&  email_field.text?.contains("@") ?? true
        
        if formValid
        {
            loginButton.isEnabled = true;
            loginButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:1)
        }else
        {
            loginButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)
        }
        
    }
    
    @objc func register_label()
    {
        
        let registerView = RegisterViewController()
        
        navigationController?.pushViewController(registerView, animated: true)
        
        
    }
    
    
    
    @IBAction func handle_login()
    {
        print("Epa, ya")
        let param = Login(email: email_field.text!, password: password_field.text!)
        
        param.executeLogin() { result in
            switch result {
            case .success(let granted) :
                if granted {
                    print("access is granted")
                    self.present(bottomTabBarController(), animated: true, completion: nil)
                    
                } else {
                    print("access is denied")
                }
            case .failure(let error): print(error)
            }
            
            
            
        }
        
    }
    
    fileprivate func setupViews()
    {
        view.addSubview(logo_label)
        view.addSubview(email_field)
        view.addSubview(is_not_registered_button)
        
        logo_label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logo_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo_label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        loginButton.addTarget(self, action: #selector(handle_login), for: UIControl.Event.touchDown)
        
        
        let stackView = UIStackView(arrangedSubviews: [email_field, password_field, loginButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: logo_label.bottomAnchor, constant: 15),
             stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
             stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-25),
             stackView.heightAnchor.constraint(equalToConstant: 180)
            ])
        
        is_not_registered_button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive=true
        is_not_registered_button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive=true
        is_not_registered_button.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-25).isActive=true
        is_not_registered_button.heightAnchor.constraint(equalToConstant: 150)
        
        
    }
    
}




