//
//  PersistanceManager.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 17/06/24.
//

import Foundation

enum PersistanceType {
    case add , remove
}

enum PersistanceManager {
    
    static let defaults = UserDefaults.standard
    
    enum keys {
        
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite : Follower , actionType : PersistanceType , completed : @escaping (GFError?)-> Void) {
        getFavorites { results in
            switch results {
            case .success(let favorites):
                var retrieveFavorites = favorites
                switch actionType {
                case .add :
                    guard !retrieveFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrieveFavorites.append(favorite)
                case .remove :
                    retrieveFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: retrieveFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func getFavorites(completed : @escaping(Result<[Follower], GFError>)-> Void) {
        
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
         
        do {
            let decoder   = JSONDecoder()
            let favorites = try  decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.getFavoritesData))
        }
        
    }
    
    static func save(favorites : [Follower])-> GFError? {
        
        do {
            let encoder          = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defaults.set(encoderFavorites, forKey: keys.favorites)
            return nil
        } catch {
            return .getFavoritesData
        }
        
    }
}
