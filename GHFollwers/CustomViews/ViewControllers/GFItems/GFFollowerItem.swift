//
//  GFFollowerItem.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 04/06/24.
//


import UIKit

class GFFollowerItemVc: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
        
    }
    
    private func configureItem() {
        itemInfoVcOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoVcTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
