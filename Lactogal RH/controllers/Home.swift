//
//  Home.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//


import UIKit

class HomePageController: UITableViewController
{
    
    let cellId="cellId"
    
    let categories = ["Salários", "Legislação", "Horários", "Formação"]
    let categories_icons = [UIImage(named: "salary"), UIImage(named: "legislacao(50px)"), UIImage(named: "schedule"),UIImage(named: "jobs")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Início"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
       
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = true
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let view =  FormFiling()
        view.section_selected = indexPath.row
        
        navigationController?.pushViewController(view, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        let categorie = self.categories[indexPath.row]
        let categorie_icon = self.categories_icons[indexPath.row]
        
        cell.textLabel?.text = categorie
        cell.imageView?.image = categorie_icon
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return cell
    }
}
