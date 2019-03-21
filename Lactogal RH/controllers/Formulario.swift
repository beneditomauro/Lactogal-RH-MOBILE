//
//  Formulario.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase


extension FormFiling: UIPickerViewDelegate, UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMonth = months[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
}
class FormFiling: UIViewController
{
    var section_selected: Int?
    
    var selectedMonth: String?
    
    let months = ["_",
                  "Janeiro",
                  "Fevereiro",
                  "Março",
                  "Abril",
                  "Maio",
                  "Junho",
                  "Julho",
                  "Agosto",
                  "Setembro",
                  "Outubro",
                  "Novembro",
                  "Dezembro"]
    

    
    //============= Esclarecimento uis
    
    let mes_salario_label: UILabel = {
        let param = UILabel()
        param.text = "o mês referente ao recibo:"
        param.font = UIFont(name: "Arial", size: 20)
        param.textColor = UIColor.lightGray
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let mes_salario: UIPickerView = {
        let param = UIPickerView()
     
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let salario_questao_label: UILabel = {
        let param = UILabel()
        param.text = "Gostaria de adicionar mais detalhes?"
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let salario_questao_textbox: UITextField = {
        let param = UITextField()
        
        param.font = UIFont(name: "Arial", size: 14)
        param.layer.borderColor = UIColor.lightGray.cgColor
        param.layer.borderWidth = 1
        param.placeholder = "Questão"
        
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
  
    let salario_pergunta: UITextView = {
        let param = UITextView()
        param.isEditable = true
        param.font = UIFont(name: "Arial", size: 14)
        param.layer.borderColor = UIColor.lightGray.cgColor
        param.layer.borderWidth = 1
        
        
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
 
    
    let salario_button: UIButton = {
        let param = UIButton()
        param.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)
        param.setTitle("Mandar Pergunta", for: UIControl.State.normal)
        
        param.layer.cornerRadius = 4
        param.addTarget(self, action: #selector(sendQuestion), for: UIControl.Event.touchUpInside)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let add_photo: UIButton =
    {
        let param = UIButton(type: .system)
        
        param.setTitle("Anexar imagem", for: UIControl.State.normal)
        param.setTitleColor(UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.5), for: UIControl.State.normal)
        param.layer.cornerRadius = 60
        param.layer.borderColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.5).cgColor
        param.titleLabel?.textColor = UIColor.blue
        param.layer.borderWidth = 1
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    // ============ />§
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
       
        print(section_selected!)
        
        mes_salario.delegate = self
        
        
        if (section_selected == 0)
        {
            setupSalarioViews()
 
        }
    }
    
    @objc fileprivate func sendQuestion()
    {
        let uid = Auth.auth().currentUser?.uid
        let detalhe =  salario_pergunta.text ?? " "
        let categoria = "salary"
        let month = selectedMonth ?? ""
        let pergunta = salario_questao_textbox.text ?? " "
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
       
        let question = ["question": pergunta, "argument" : detalhe, "categoria": categoria, "date": result, "is_picked": false, "is_complete": false, "month": month] as [String : Any]
        
        let db = Firestore.firestore()
        
          
        
        db.collection("/question/" + uid! + "/questions").addDocument(data: question) { err in
            if let err = err
            {
                print("Error writing document: \(err)")
            } else
            {
                print("Document successfully written!")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
        
        
    }
    
    fileprivate func setupSalarioViews()
    {
        view.addSubview(salario_button)
        view.addSubview(mes_salario_label)
        view.addSubview(mes_salario)
        view.addSubview(salario_pergunta)
        view.addSubview(add_photo)
        view.addSubview(salario_questao_label)
        view.addSubview(salario_questao_textbox)
        
        
        mes_salario_label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mes_salario_label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mes_salario_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mes_salario.topAnchor.constraint(equalTo: mes_salario_label.bottomAnchor, constant:1).isActive=true
        mes_salario.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    
        
        salario_questao_textbox.topAnchor.constraint(equalTo: mes_salario.bottomAnchor, constant: -2).isActive = true
        salario_questao_textbox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        salario_questao_textbox.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        salario_questao_textbox.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        salario_questao_textbox.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        salario_questao_label.topAnchor.constraint(equalTo: salario_questao_textbox.bottomAnchor, constant: -2).isActive = true
        salario_questao_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        salario_pergunta.topAnchor.constraint(equalTo: salario_questao_label.bottomAnchor, constant: 3).isActive=true
        salario_pergunta.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        salario_pergunta.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        salario_pergunta.heightAnchor.constraint(equalToConstant:155).isActive = true
        
        add_photo.topAnchor.constraint(equalTo: salario_pergunta.bottomAnchor, constant: 5).isActive=true
        add_photo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        add_photo.heightAnchor.constraint(equalToConstant: 120).isActive=true
        add_photo.widthAnchor.constraint(equalToConstant: 120).isActive=true
        
        
        salario_button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive=true
        salario_button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive=true
        salario_button.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-25).isActive=true
        salario_button.heightAnchor.constraint(equalToConstant: 60).isActive=true
        
        
    }
}
