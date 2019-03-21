//
//  Register.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//


import UIKit

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedArea = months[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

class RegisterViewController: UIViewController
{
    var section_selected: Int?
    
    var selectedArea: String?
    
    let months = ["Vila do Conde",
                  "Sanfins",
                  "Açores",
                  "Macedo de Cavaleiros",
                  "Oliveira de Azeméis",
                  ]
    
    let plusPhotoButton: UIButton =
    {
        let param = UIButton(type: .system)
        
        param.setTitle("Add Photo", for: UIControl.State.normal)
        param.setTitleColor(UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0), for: UIControl.State.normal)
        param.layer.cornerRadius = 70
        param.layer.borderColor = UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0).cgColor
        param.titleLabel?.textColor = UIColor.blue
        param.layer.borderWidth = 2
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let area_colaborador: UIPickerView = {// lista de areas possíveis em que o colaborador pode trabalhar
        let param = UIPickerView()
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let fullname: UITextField =
    {
        let param = UITextField()
        param.placeholder = "Nome Completo"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let NIF: UITextField =
    {
        let param = UITextField()
        param.placeholder = "NIF"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let email: UITextField =
    {
        let param = UITextField()
        param.placeholder = "Email"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let iban: UITextField =
    {
        let param = UITextField()
        param.placeholder = "IBAN"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let phonenumber: UITextField =
    {
        let param = UITextField()
        param.placeholder = "Telemóvel"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let password: UITextField =
    {
        let param = UITextField()
        param.placeholder = "Password"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        param.translatesAutoresizingMaskIntoConstraints = false
        
        return param
    }()
    
    let password1: UITextField =
    {
        let param = UITextField()
        param.placeholder = "Repetir a password"
        
        param.borderStyle = .roundedRect
        param.backgroundColor = UIColor(white: 0, alpha: 0.03)
        param.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    
    let registerButton: UIButton =
    {
        let param = UIButton()
        param.setTitle("Registar", for: UIControl.State.normal)
        param.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.5)
        param.addTarget(self, action: #selector(register_user), for: UIControl.Event.touchUpInside)
        param.isEnabled = false
        
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        area_colaborador.delegate = self
        
        setupViews()
        
        view.backgroundColor = UIColor.white
        
    }
    
    @objc func handle_registing()
    {
        print("k")
    }
    
    @objc func handleTextInputChange()
    {
        let formValid = email.text?.count ?? 0 > 0 && fullname.text?.count ?? 0 > 0 && NIF.text?.count ?? 0 > 0 && password.text?.count ?? 0 > 0 && password1.text?.count ?? 0 > 0 && iban.text?.count ?? 0 > 0 && phonenumber.text?.count ?? 0 > 0 && password1.text == password.text && email.text?.contains("@") ?? true
        
        if formValid
        {
            registerButton.isEnabled = true;
            registerButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.9)
        }else
        {
            registerButton.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.5)
        }
        
    }
    
    fileprivate func setupViews()
    {
        view.addSubview(plusPhotoButton)
        view.addSubview(email)
        view.addSubview(area_colaborador)
        view.addSubview(registerButton)
    
        
        
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        
        
        let stackView = UIStackView(arrangedSubviews: [fullname, NIF, email, iban, password, password1,phonenumber])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 15),
             stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
             stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-25),
             stackView.heightAnchor.constraint(equalToConstant: 360)
            ])
        
        area_colaborador.topAnchor.constraint(equalTo: phonenumber.bottomAnchor, constant: 5).isActive = true
        area_colaborador.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        area_colaborador.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive=true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive=true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-25).isActive=true
        registerButton.heightAnchor.constraint(equalToConstant: 60).isActive=true
        
    }
    
    @IBAction func register_user()
    {
        let user = Register(email: email.text!, NIF: Int(NIF.text!) ?? 0, senha: password1.text!, name: fullname.text!, phonenumber: Int(phonenumber.text!) ?? 0, iban: iban.text!, area: self.selectedArea!)
        
        
        
        user.registerUser { result in
            switch result {
            case .success(let granted) :
                if granted
                {
                    print("access is granted")
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    print("access is denied")
                }
            case .failure(let error): print(error)
            }
            
        }
        
        
    }
}
