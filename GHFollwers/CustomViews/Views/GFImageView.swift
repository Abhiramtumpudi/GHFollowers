//
//  GFImageView.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 21/05/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius                         = 10
        clipsToBounds                              = true
        image                                      = placeHolderImage
        translatesAutoresizingMaskIntoConstraints  = false
    }
    
    func downLoadImageFromString(urlString : String) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            print("download from cache")
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task =  URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self =  self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            print("download from url")
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
    
}
