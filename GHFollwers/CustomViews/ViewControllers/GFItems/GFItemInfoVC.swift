//
//  GFItemInfoVcViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 04/06/24.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView     = UIStackView()
    let itemInfoVcOne = GFItemInfoView()
    let itemInfoVcTwo = GFItemInfoView()
    let actionButton  = GFButton()
    
    var user : User!
    
    init(user : User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgrounView()
        layoutUI()
        stackViewConfiguration()
    }
    
    func configureBackgrounView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func stackViewConfiguration() {
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoVcOne)
        stackView.addArrangedSubview(itemInfoVcTwo)
        
    }
    
    private func layoutUI() {
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
    }

}
