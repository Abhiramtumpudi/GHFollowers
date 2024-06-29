//
//  GFAlertViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 27/06/24.
//

import UIKit

class GFAlertViewController: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor        = .systemBackground
        layer.cornerRadius     = 16
        layer.borderWidth      = 2
        layer.borderColor      = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
