//
//  UserInfoVcViewController.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 29/05/24.
//

import UIKit

class UserInfoVc: UIViewController {
    
    let headerView   = UIView()
    let itemOneView  = UIView()
    let itemTwoView  = UIView()
    var username : String!
    var itemViews : [UIView] = []

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
                    self.add(childVc: GFUserHeaderVC(user: user),   to: self.headerView)
                    self.add(childVc: GFRepoItemVc(user: user),     to: self.itemOneView)
                    self.add(childVc: GFFollowerItemVc(user: user), to: self.itemTwoView)
                }
                
            case .failure(let error):
                self.presentGFAlertToDisplayOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        
    }
    
    func layoutUI() {
        
        let padding : CGFloat = 20
        
       
        itemViews = [headerView , itemOneView , itemTwoView]
        
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
            itemTwoView.heightAnchor.constraint(equalToConstant: 140)
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

    
   
   
    

