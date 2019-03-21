//
//  User.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class Login {
    var email: String
    var senha: String
    
    init(email: String, password: String)
    {
        self.email = email
        self.senha = password
    }
    
    enum AuthResult {
        case success(Bool), failure(Error)
    }
    
    func executeLogin(completion: @escaping (AuthResult) -> ()) {
        Auth.auth().signIn(withEmail: email, password: senha, completion: {
            (user, err) in
            
            if let error = err
            {
                print("Algo deu errado: ", error)
                completion(.failure(error))
                return
            }
            
            completion(.success(true))
        })
        
        
    }
    
    
    
}

class Register {
    var success = Int()
    var email: String
    var name: String
    var senha: String
    var phonenumber: Int
    var iban: String
    var NIF: Int
    var area: String
    
    init(email: String, NIF: Int, senha: String, name: String, phonenumber: Int, iban: String, area: String) {
        self.email = email
        self.senha = senha
        self.name = name
        self.phonenumber = phonenumber
        self.iban = iban
        self.NIF = NIF
        self.area = area
        
    }
    
    enum AuthResult {
        case success(Bool), failure(Error)
    }
    
    
    func registerUser(completion: @escaping (AuthResult) -> ()) {
        
        Auth.auth().createUser(withEmail: self.email, password: self.senha) { (user, err) in
            
            if let error = err
            {
                print("Algo deu errado: ", error)
                completion(.failure(error))
                return
            }
            
            print("User entrou: ", user?.user.uid ?? "")
            completion(.success(true))
            
            guard let uid = user?.user.uid else { return }
            
            
            let userValues = ["fullname":self.name, "NIF": self.NIF, "email":self.email, "phonenumber": self.phonenumber, "IBAN": self.iban,  "worker_area": self.area, "is_staff": false] as [String : Any]
            
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).setData(userValues) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
         
            
        }
        
    }
    
    func login_user(completion: @escaping (AuthResult) -> ()) {
        
        Auth.auth().createUser(withEmail: self.email, password: self.senha) { (user, err) in
            
            if let error = err
            {
                print("Algo deu errado: ", error)
                completion(.failure(error))
                return
            }
            
            print("User entrou: ", user?.user.uid ?? "")
            completion(.success(true))
            
            guard let uid = user?.user.uid else { return }
            
            
            let userValues = ["fullname":self.name, "NIF": self.NIF, "email":self.email, "phonenumber": self.phonenumber] as [String : Any]
            let values = [uid: userValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let erro = err
                {
                    print("Failed to save user info into db: ", erro)
                    completion(.failure(erro))
                    
                    return
                }
                
                print("Successfully saved user info to db")
                completion(.success(true))
                
            })
            
        }
        
        
    }
    
    
}
