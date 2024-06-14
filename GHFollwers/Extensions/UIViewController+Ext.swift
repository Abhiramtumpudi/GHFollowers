//
//  UIViewController+Ext.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 17/05/24.
//

import UIKit
import SafariServices

fileprivate var containerView : UIView!

extension UIViewController {
    
    func presentGFAlertToDisplayOnMainTread(title : String , message : String , buttonTitle : String) {
        
        DispatchQueue.main.async {
            
            let alertVc = AlertVcViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true)

        }

    }
    
    func safariViewControllerExtension(with url : URL) {
        let safariVc = SFSafariViewController(url: url)
        safariVc.preferredControlTintColor = .systemGreen
        present(safariVc, animated: true)
    }
    
    
    func viewLoading() {
        
        containerView = UIView(frame: view.frame)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func emptyStateView(message : String , in View : UIView) {
        let stateView = GFEmptyFollowerView(message: message)
        stateView.frame = view.bounds
        view.addSubview(stateView)
    }
}
