//
//  ApiService.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 19/03/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ApiService: NSObject {
    
    static let shared = ApiService()
    private var notificacoes:[notificacao]?
    
    func fetchWaitingNotifications(completion: @escaping ([notificacao]) -> ()){
 
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        //"/question/" + uid! + "/questions"
        
        db.collection("/question/" + uid! + "/questions").whereField("is_complete", isEqualTo: false)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    self.notificacoes = [notificacao]()
                    for document in querySnapshot!.documents {
                        
                        //print("\(document.documentID) => \(document.data())")
                        let not = notificacao()
                        
                        
                        not.question = document.data()["question"] as? String
                        not.argument = document.data()["argument"] as? String
                        not.is_picked = document.data()["is_picked"] as? Bool
                        not.is_complete = document.data()["is_complete"] as? Bool
                        not.date = document.data()["date"] as? String
                        not.categoria = document.data()["categoria"] as? String
                        
                        self.notificacoes?.append(not)
                        
                    }
                    DispatchQueue.main.async {
                        completion(self.notificacoes ?? [notificacao]())
                    }
                  
                }
        }
    }
    
    func listenToWaitingNotification(completion: @escaping ([notificacao]) -> ())
    {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("/question/" + uid! + "/questions").whereField("is_complete", isEqualTo: false)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    let not = notificacao()
                    self.notificacoes?.removeAll()
                    
                    
                    not.question = document.data()["question"] as? String
                    not.argument = document.data()["argument"] as? String
                    not.is_picked = document.data()["is_picked"] as? Bool
                    not.is_complete = document.data()["is_complete"] as? Bool
                    not.date = document.data()["date"] as? String
                    not.categoria = document.data()["categoria"] as? String
                    
                    self.notificacoes?.append(not)
                    
                }
                DispatchQueue.main.async {
                    completion(self.notificacoes ?? [notificacao]())
                }
                
        }
        
        
    }
    
    func fetchNotificationsDone(completion: @escaping ([notificacao]) -> ()){
        
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        //"/question/" + uid! + "/questions"
        
        db.collection("/question/" + uid! + "/questions").whereField("is_complete", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    self.notificacoes = [notificacao]()
                    for document in querySnapshot!.documents {
                        
                        //print("\(document.documentID) => \(document.data())")
                        let not = notificacao()
                        
                        
                        not.question = document.data()["question"] as? String
                        not.argument = document.data()["argument"] as? String
                        not.is_picked = document.data()["is_picked"] as? Bool
                        not.is_complete = document.data()["is_complete"] as? Bool
                        not.date = document.data()["date"] as? String
                        not.categoria = document.data()["categoria"] as? String
                        
                        self.notificacoes?.append(not)
                        
                    }
                    DispatchQueue.main.async {
                        completion(self.notificacoes ?? [notificacao]())
                    }
                    
                }
        }
    }
    
    func listenToDoneNotification(completion: @escaping ([notificacao]) -> ())
    {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("/question/" + uid! + "/questions").whereField("is_complete", isEqualTo: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    let not = notificacao()
                    self.notificacoes?.removeAll()
                    
                    
                    not.question = document.data()["question"] as? String
                    not.argument = document.data()["argument"] as? String
                    not.is_picked = document.data()["is_picked"] as? Bool
                    not.is_complete = document.data()["is_complete"] as? Bool
                    not.date = document.data()["date"] as? String
                    not.categoria = document.data()["categoria"] as? String
                    
                    self.notificacoes?.append(not)
                    
                }
                DispatchQueue.main.async {
                    completion(self.notificacoes ?? [notificacao]())
                }
                
        }
        
        
    }
}
