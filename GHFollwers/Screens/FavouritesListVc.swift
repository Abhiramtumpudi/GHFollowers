//
//  FollowersListVc.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 10/05/24.
//

import UIKit

class FavouritesListVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistanceManager.getFavorites { results in
            switch results{
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
