//
//  Notifications.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 25/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TasksController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    
    var notificacoes:[notificacao]?
    let cellId = "cellId"
    let waintingCellId = "waintingCellId"
    let doneCellId = "doneCellId"
    
    let titles = ["Em esprera", "respondidas"]
    
    
    let menuTopBar: MenuBar = {
        let menu = MenuBar()
        
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    /*override func viewDidAppear(_ animated: Bool) {
        menuTopBar.setSelectecCell()
        menuTopBar.setupHorizontalBar()
    }*/

    private func getWaitingNotificacons() {
        
        ApiService.shared.fetchWaitingNotifications{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    private func listenToWaintingNotification()
    {
        ApiService.shared.listenToWaitingNotification{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setupMenuTopBar() // funcao que
        getWaitingNotificacons()
        listenToWaintingNotification()
        setupCollectionView()
        setupViewTitleLabel()
        
        
        
        
        
    }
    
    fileprivate func setupViewTitleLabel()
    {
        navigationItem.title = "Notificações"
        navigationController?.navigationBar.isTranslucent = false
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Notificações"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    fileprivate func setupCollectionView()
    {
        /*if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }*/
        collectionView?.backgroundColor = .white
        collectionView?.register(notification.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        collectionView?.isScrollEnabled = true
        
        collectionView?.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        
    }
    
    fileprivate func setupMenuTopBar()
    {
        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuTopBar)
        menuTopBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuTopBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //menuTopBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
 
    /*
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
  
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
    }
    
    */
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return notificacoes?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! notification
        
        cell.notificacao = self.notificacoes?[indexPath.item]
        
        
        return cell
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    
}

