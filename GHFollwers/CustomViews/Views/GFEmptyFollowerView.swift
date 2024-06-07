//
//  GFFollowerView.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 26/05/24.
//

import UIKit

class GFEmptyFollowerView: UIView {
    
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    var imageLogoView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message : String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(imageLogoView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        imageLogoView.image = UIImage(named: "empty-state-logo")
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageLogoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageLogoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
            
        ])
    }
}
