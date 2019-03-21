//
//  notification_done.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 20/03/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit

class NotificationDoneView: NotificationsWaintingView {
    override func listeningNotifications() {
        ApiService.shared.listenToDoneNotification{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
        }}
    
    override func fetchNotifications() {
        ApiService.shared.listenToDoneNotification{(notificacoes: [notificacao]) in
            
            self.notificacoes = notificacoes
            self.collectionView.reloadData()
        }
        }
        
        
   
    
    }

