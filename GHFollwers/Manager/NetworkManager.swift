//
//  NetworkManager.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 18/05/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString , UIImage>()
    private let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for userName : String , page : Int , completed : @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endPoints = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
                                                    
        guard let url = URL(string: endPoints) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error  {
                completed(.failure(.unableTocomplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.serverDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try  decoder.decode([Follower].self, from: data)
                completed(.success(follower))
            } catch {
                    completed(.failure(.serverDataError))
            }
        }
        task.resume()
    }
    
    func getuserInfo(for userName : String  , completed : @escaping (Result<User, GFError>) -> Void) {
        
        let endPoints = baseUrl + "\(userName)"
                                                    
        guard let url = URL(string: endPoints) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error  {
                completed(.failure(.unableTocomplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.serverDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try  decoder.decode(User.self, from: data)
                completed(.success(follower))
            } catch {
                    completed(.failure(.serverDataError))
            }
        }
        task.resume()
    }
}
