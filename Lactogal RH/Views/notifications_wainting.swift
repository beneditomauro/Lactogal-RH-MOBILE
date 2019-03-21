//
//  notifications_wainting.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 19/03/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit

class NotificationsWaintingView: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        cv.translatesAutoresizingMaskIntoConstraints = true
        return cv
    }()
    
    var notificacoes: [notificacao]?
    
    let cellId = "cellId"
    
    func fetchNotifications() {
        
        ApiService.shared.fetchWaitingNotifications{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    func listeningNotifications()
    {
        ApiService.shared.listenToWaitingNotification{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchNotifications()
        listeningNotifications()
        
        
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        collectionView.register(notification.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificacoes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! notification
        
        cell.notificacao = notificacoes?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //
        
    }
    
    
}

