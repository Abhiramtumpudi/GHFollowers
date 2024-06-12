//
//  GFRepoItemVc.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 04/06/24.
//

import UIKit

class GFRepoItemVc: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
        
    }
    
    private func configureItem() {
        itemInfoVcOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoVcTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func didTapActionButton() {
        delegate.didTapGitHubProfile(for: user)
    }
}
