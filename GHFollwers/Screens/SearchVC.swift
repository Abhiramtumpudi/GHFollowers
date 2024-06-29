//
//  SearchVC.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 10/05/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let userNametextField = GHTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var topConstarintsConstants : NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configuretextField()
        configureCallToActionButton()
        createTapgestureRecognizerToDismisskeyboard()
       
    }
    
    var textFieldValidation :  Bool {
        return !userNametextField.text!.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNametextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createTapgestureRecognizerToDismisskeyboard() {
        
        let Tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func pushFollowersList() {
        
        guard textFieldValidation else {
            
              presentGFAlertToDisplayOnMainTread(title: "Empty Username",
                                               message: "Please Enter a Username or it is empty 😄",
                                               buttonTitle: "OK")
              return
        }
        
        userNametextField.resignFirstResponder()
        
        let followersListVc = FollowersListVC(username: userNametextField.text!)
        
        navigationController?.pushViewController(followersListVc, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.image
        
        let topConstraints : CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20: 80
        
        topConstarintsConstants = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraints)
        topConstarintsConstants.isActive = true
        
        NSLayoutConstraint.activate([
            
                      
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    
    }
    
    func configuretextField() {
        view.addSubview(userNametextField)
        userNametextField.delegate = self
        NSLayoutConstraint.activate([
            userNametextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNametextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNametextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNametextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersList), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}


extension SearchVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersList()
        return true
    }
}
