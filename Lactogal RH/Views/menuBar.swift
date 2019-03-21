//
//  menuBar.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 13/03/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){}
}
class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let cellId = "cellId"
    let imagenames = ["waiting", "done"]
    var homeController: TasksController?
    
    
  
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupHorizontalBar()
        
        collectionView.register(menuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let selectedIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: [])
       
        
        backgroundColor =  UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.7)
    }
    
    func setSelectecCell()
    {
        let selectedIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: [])
    }
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
     func setupHorizontalBar()
    {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.white
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! menuCell
        
        cell.imageicon.image = UIImage(named: imagenames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageicon.tintColor = UIColor(red:91/255, green:14/255, blue:13/255, alpha:0.7)
        
        cell.backgroundColor = UIColor(red:0/255, green:137/255, blue:123/255, alpha:0.9)
        
        return cell
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 2
        print(x)
        
        horizontalBarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.layoutIfNeeded()
                    }, completion: nil)
        
       
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class menuCell:BaseCell {
    
    var imageicon: UIImageView = {
        let param = UIImageView()
        param.image = UIImage(named: "done")?.withRenderingMode(.alwaysTemplate)
        param.tintColor = UIColor(red:91/255, green:14/255, blue:13/255, alpha:0.7)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    override var isHighlighted: Bool
        {
        didSet{
            imageicon.tintColor = isHighlighted ? UIColor.white : UIColor(red:91/255, green:14/255, blue:13/255, alpha:0.7)
        }
    }
    override var isSelected: Bool
        {
        didSet{
             imageicon.tintColor = isSelected ? UIColor.white : UIColor(red:91/255, green:14/255, blue:13/255, alpha:0.7)
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageicon)
        imageicon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageicon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}

