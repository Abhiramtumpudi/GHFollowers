//
//  GFUserHeaderVC.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 31/05/24.
//

import UIKit

class GFUserHeaderVC: UIViewController {
    
    
    let avatarImageView      = GFAvatarImageView(frame: .zero)
    let userNameLabel        = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel            = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView    = UIImageView()
    let locationLabel        = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel             = GFBodyLabel(textAlignment: .left)
    
    let user : User!
    
    init(user: User!) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubViews()
        layoutUI()
        configureUIelements ()
    }
    
    func configureUIelements () {
        
        avatarImageView.downLoadImageFromString(urlString: user.avatarUrl)
        userNameLabel.text     = user.login
        nameLabel.text         = user.name ?? "NA"
        locationLabel.text     = user.location ?? "NA"
        bioLabel.text          = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.pinSymbol)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func layoutSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
        

    }
    
    func layoutUI() {
        
        let padding : CGFloat          = 20
        let textImagepadding : CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagepadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagepadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagepadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagepadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        
        ])
    }
    
    
   


}
