//
//  FollowersListVc.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 10/05/24.
//

import UIKit

class FavouritesListVc: UIViewController {

    let tableView   = UITableView()
    var favorites  : [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavorites()
    }
    
    private func configureNav() {
        view.backgroundColor  = .systemBackground
        title                 = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reUseId)
        
    }
    
    func getFavorites() {
        
        PersistanceManager.getFavorites {[weak self] results in
            guard let self = self else {return}
            switch results{
            case .success(let favorites):
                if favorites.isEmpty {
                    emptyStateView(message: "no favorites?\nPlease add one on favorites", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertToDisplayOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


extension FavouritesListVc : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell         = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reUseId) as! FavoritesCell
        let favoriteData = favorites[indexPath.row]
        cell.set(favorite: favoriteData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc            = favorites[indexPath.row]
        let destVc        = FollowersListVC(username: vc.login)
       
        
        navigationController?.pushViewController(destVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        let favorite  = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertToDisplayOnMainTread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            
        }
    }
}
