//
//  UIHelper.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 23/05/24.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumFlowLayout(in view : UIView)-> UICollectionViewFlowLayout {
       let width                           = view.bounds.width
       let padding : CGFloat               = 12
       let minimumItemSpace : CGFloat      = 10
       let availableWidth                  = width - (padding * 2) - (minimumItemSpace * 2)
       let itemWidth                       = availableWidth / 3
        
       let flowLayout                      = UICollectionViewFlowLayout()
       flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
       flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
       return flowLayout
   }
}
