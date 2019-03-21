//
//  notifications.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 20/03/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit


class notification: BaseCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let imageView : UIImageView = { // icone indicativo da categoria à que a pergunta pertence
        let param  = UIImageView()
        param.image = UIImage(named: "salarios")
        param.contentMode = .scaleAspectFill
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let questionTextView: UILabel = { // a pergunta formuladda pelo colaborador
        let param = UILabel()
        param.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        param.text = "Que razões ... descontos neste recibo?"
        
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let argument_of_the_question: UITextView = { // a argumentação da dúvida ou pergunta
        let param = UITextView()
        param.text = "Suspendisse ad vel scelerisque a adipiscing nulla vitae curabitur ullamcorper aliquet justo blandit euismod parturient a gravida parturient ullamcorper non senectus est felis metus odio orci conubia.Himenaeos tristique."
        param.textColor =
            UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
        param.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        param.isEditable = false
        
        param.font = UIFont(name: "arial", size: 13)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let question_state_circle: UIView = { // circunferencia indicativa do estado da questao (em espera, a ser revista e respondida)
        let param = UIView()
        param.layer.cornerRadius = 10
        param.backgroundColor = UIColor(red:0.99, green:0.85, blue:0.21, alpha:1.0)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    let separator: UIView = { // circunferencia indicativa do estado da questao (em espera, a ser revista e respondida)
        let param = UIView()
        
        param.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        
        param.translatesAutoresizingMaskIntoConstraints = false
        return param
    }()
    
    
    
    fileprivate func questionShortner(question: String) -> String // funcao que
    {
        
        var returnString = question
        var i = 0
        
        if(question.count > 38)
        {
            returnString = ""
            
            for character in question
            {
                if (i < 34)
                {
                    returnString += String(character)
                    i += 1
                    
                }else
                {
                    returnString += "..."
                    break
                }
                
            }
            
        }
        
        return returnString
    }
    
    var notificacao: notificacao?
    {
        didSet
        {
            imageView.image = UIImage(named: notificacao?.categoria ?? "salarios")
            
            
            questionTextView.text = questionShortner(question: notificacao?.question ?? "")
            
            argument_of_the_question.text = notificacao?.argument ?? ""
            
            
            question_state_circle.backgroundColor = (notificacao?.is_picked)! ? UIColor.orange: UIColor(red:0.99, green:0.85, blue:0.21, alpha:1.0)
            
            //question_state_circle.backgroundColor = (notificacao?.is_complete)! ? UIColor.green: nil
            
            
        }
        
    }
    
    
        override func setupViews()
    {
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 3
        
        
        
        addSubview(imageView)
        addSubview(separator)
        addSubview(questionTextView)
        addSubview(argument_of_the_question)
        addSubview(question_state_circle)
       
        
        
        
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        
        questionTextView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        questionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        argument_of_the_question.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        argument_of_the_question.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant: 1).isActive = true
        argument_of_the_question.rightAnchor.constraint(equalTo: question_state_circle.leftAnchor, constant: -4).isActive = true
        argument_of_the_question.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        question_state_circle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        question_state_circle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        question_state_circle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        question_state_circle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        separator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
    }}

