//
//  FollowersListVC.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 17/05/24.
//

import UIKit

protocol FollowersListVcDelegate : AnyObject {
    func didRequestFollowers(for userName : String)
}

class FollowersListVC: UIViewController, UISearchControllerDelegate {
    
    enum Section { case main }
    
    var followers : [Follower] = []
    var filteredFollowers : [Follower] = []
    var username : String!
    var page = 1
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    var hasMoreFollowers = true
    var isSearching =  false
    
    init(username :  String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title    = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVcNav()
        configureCollectionView()
        configureDiffableDataSource()        
        getFollowers(username: username, page: page)
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getFollowers(username: String , page: Int) {
        viewLoading()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] results in

            guard let self = self else {return}
            self.dismissLoadingView()
            switch results {
            case .success(let followers) :
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go and follow 😀."
                    DispatchQueue.main.async {
                        self.emptyStateView(message: message, in: self.view)
                    }
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertToDisplayOnMainTread(title: "Bad stuff happens", message: error.rawValue, buttonTitle: "OK")
                print(error)
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        let userInfovc      = UserInfoVc()
        userInfovc.username = follower.login
        userInfovc.delegate = self
        let navController   = UINavigationController(rootViewController: userInfovc)
        present(navController, animated: true)
        
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Username"
        navigationItem.searchController = searchController
    }
    
    func configureVcNav() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton

    }
    
    func configureDiffableDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section , Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
        
    }
    
    func updateData(on followers : [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot , animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        viewLoading()
        NetworkManager.shared.getuserInfo(for: username) {[weak self] results in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch results {
            case .success(let user):
             
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    guard let self = self else {return}
                    guard let error = error else {
                        self.presentGFAlertToDisplayOnMainTread(title: "Added User",
                                                                message: "Succesfully added this user to favorites",
                                                                buttonTitle: "Yes!")
                        return
                    }
                    self.presentGFAlertToDisplayOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")

                }
                
            case .failure(let error):
                self.presentGFAlertToDisplayOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")

            }
        }
    }
    
}


extension FollowersListVC : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsety                   = scrollView.contentOffset.y
        let contentHeight             = scrollView.contentSize.height
        let height                    = scrollView.frame.size.height
        
        if offsety > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
}


extension FollowersListVC : UISearchResultsUpdating , UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: self.followers)
    }
    
}

extension FollowersListVC : FollowersListVcDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.username      = userName
        title              = userName
        page               = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: userName, page: page)
    }
    
    
}
