//
//  AlertVcViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 17/05/24.
//

import UIKit

class AlertVcViewController : UIViewController {
    
    let containerView = GFAlertViewController()
    var titleLabel    = GFTitleLabel(textAlignment: .center, fontSize: 20)
    var messageLabel  = GFBodyLabel(textAlignment: .center)
    var actionButton  = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle : String?
    var message : String?
    var buttonTitle : String?
    
    init(title: String , message: String , buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        configureContainerView() 
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
    }
    
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
            
            
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        self.titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle("OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVc), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        
        messageLabel.text = message ?? "unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVc() {
        dismiss(animated: true)
    }
    
}
