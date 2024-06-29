//
//  UserInfoVcViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 29/05/24.
//

import UIKit
import SafariServices

protocol UserInfoVcDelegate : AnyObject {
    func didTapGitHubProfile(for user : User)
    func didTapFollowers(for user : User)
}

class UserInfoVc: UIViewController {
    
    let headerView     = UIView()
    let itemOneView    = UIView()
    let itemTwoView    = UIView()
    var username       : String!
    let datalabel      = GFBodyLabel(textAlignment: .center)
    var itemViews      : [UIView] = []
    weak var delegate  : FollowersListVcDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVc))
        navigationItem.rightBarButtonItem = doneButtonItem
        layoutUI()  
        NetworkManager.shared.getuserInfo(for: username) {[weak self] results in
            
            guard let self = self else {return}
            
            switch results {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureWithUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentGFAlertToDisplayOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        
    }
    
    func configureWithUIElements(with user : User) {
        
        let repoItem             = GFRepoItemVc(user: user)
        repoItem.delegate        = self
        
        let followerItemVc       = GFFollowerItemVc(user: user)
        followerItemVc.delegate  = self
        
        self.add(childVc: repoItem,     to: self.itemOneView)
        self.add(childVc: followerItemVc, to: self.itemTwoView)
        self.add(childVc: GFUserHeaderVC(user: user),   to: self.headerView)
        self.datalabel.text = "GitHub Since \(user.createdAt.convertToMonthyear())"
        
    }
    
    func layoutUI() {
        
        let padding : CGFloat = 20
        
        itemViews = [headerView , itemOneView , itemTwoView , datalabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -padding),
            ])
            
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.heightAnchor.constraint(equalToConstant: 140),
            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: 140),
            datalabel.topAnchor.constraint(equalTo: itemTwoView.bottomAnchor, constant: padding),
            datalabel.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    @objc func dismissVc () {
        dismiss(animated: true, completion: nil)
    }
    
    func add(childVc : UIViewController , to containerView : UIView) {
        
        addChild(childVc)
        containerView.addSubview(childVc.view)
        childVc.view.frame = containerView.bounds
        childVc.didMove(toParent: self)
    }
}

extension UserInfoVc : UserInfoVcDelegate {
    
    func didTapGitHubProfile(for user : User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentGFAlertToDisplayOnMainTread(
                title: "Invalid Url",
                message: "Please recheck Url",
                buttonTitle: "OK")
            return
        }
        
        self.safariViewControllerExtension(with: url)
    }
    
    func didTapFollowers(for user : User) {
        
        guard  user.followers != 0 else {
            self.presentGFAlertToDisplayOnMainTread(title: "No Followera", message: "No Followers for this profile", buttonTitle: "OK")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVc()
    }
    
}
    

