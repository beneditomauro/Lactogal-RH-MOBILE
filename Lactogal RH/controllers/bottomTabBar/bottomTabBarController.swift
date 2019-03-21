//
//  bottomTabBarController.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class bottomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.tintColor =  UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)

       
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        let userView = HomePageController()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let tasks = TasksController(collectionViewLayout: layout)
        let tasks_done = DoneTasksController(collectionViewLayout: layout)
        
        
        userView.navigationItem.title = "Início"
       
        userView.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings")?.withRenderingMode((.alwaysOriginal)), style: .plain, target: self, action: #selector(handleSignOut))
        
        //userView.navigationController?.navigationBar.isTranslucent = false
        
        tasks_done.navigationItem.title = "Notificações em espera"
        tasks_done.navigationController?.isNavigationBarHidden = false
        tasks_done.tabBarItem.selectedImage = UIImage(imageLiteralResourceName: "waiting_notifications")

        
        tasks.navigationItem.title = "Notificações em espera"
        tasks.navigationController?.isNavigationBarHidden = false
        tasks.tabBarItem.selectedImage = UIImage(imageLiteralResourceName: "profile_unselected")
        
        
        let navController = UINavigationController(rootViewController: userView)
        let navController1 = UINavigationController(rootViewController: tasks)
        let navController2 = UINavigationController(rootViewController: tasks_done)
        
        navController.tabBarItem.selectedImage = UIImage(named: "home_selected")
        navController.tabBarItem.image = UIImage(named: "home_unselected")
        
        navController1.tabBarItem.selectedImage = UIImage(named: "waiting_notifications")
        navController1.tabBarItem.image = UIImage(named: "waiting_notifications")
        
        navController2.tabBarItem.selectedImage = UIImage(named: "profile_unselected")
        navController2.tabBarItem.image = UIImage(named: "profile_unselected")
       
        
        
        viewControllers = [navController,navController1, navController2]
        
        
        
    }
    
    @objc func handleSignOut()
    {
        let uiAlert = UIAlertController(title: nil, message: "Tem a certeza que deseja sair?", preferredStyle: .actionSheet)
        
        uiAlert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {(_) in
            print("Yall niggas funny")
            
            do
            {
                try Auth.auth().signOut()
                let loginView = LoginViewController()
                
                self.present(loginView, animated: true, completion: nil)
            }catch let authError
            {
                print(authError)
            }
            
        }))
        
        uiAlert.addAction((UIAlertAction(title: "Cancel", style: .cancel, handler: nil)))
        
        present(uiAlert, animated: true, completion: nil)
        
        print("You know")
        
    }
    
}
