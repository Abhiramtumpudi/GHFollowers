//
//  GFTabBarViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 26/06/24.
//

import UIKit

class GFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .green
        self.viewControllers = [createSearchNC() , createFavouritesNC()]
    }
    
    func createSearchNC()-> UINavigationController {
        
        let searchVc = SearchVC()
        searchVc.title = "Search"
        searchVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVc)
        
    }
    
    func createFavouritesNC()-> UINavigationController {
        
        let FollowersListVc = FavouritesListVc()
        FollowersListVc.title = "Favorites"
        FollowersListVc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: FollowersListVc)
        
    }
    
  
}
