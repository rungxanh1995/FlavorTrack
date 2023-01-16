//
//  PersistenceManager.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-16.
//

import Foundation

/// Declared as enum to prevent initialization
enum PersistenceManager {
	private static let defaults: UserDefaults = .standard
	
	static func retrieveFavoritesAndHandleError() -> Result<[Business], Self.PersistenceError> {
		guard let favoritesData = Self.defaults.object(forKey: Self.Keys.favorites) as? Data else {
			return .success([]) /// should be first time using the app without any favorites
		}
		
		do {
			let favorites = try JSONDecoder().decode([Business].self, from: favoritesData)
			return .success(favorites)
		} catch {
			return .failure(.unableToRetrieveFavorites)
		}
	}
	
	static func saveFavoritesAndHandleError(_ favorites: [Business]) -> Self.PersistenceError? {
		do {
			let encodedData = try JSONEncoder().encode(favorites)
			Self.defaults.set(encodedData, forKey: Self.Keys.favorites)
			return nil
		} catch {
			return .unableToFavorite
		}
	}
	
	static func updateWith(_ favorite: Business, forAction actionType: Self.ActionType) -> Self.PersistenceError? {
		let retrieved = retrieveFavoritesAndHandleError()
		
		switch retrieved {
			case .success(var favorites):
				switch actionType {
					case .add:
						guard !favorites.contains(favorite) else {
							return .alreadyInFavorites
						}
						
						favorites.append(favorite)
					case .remove:
						favorites.removeAll { $0.id == favorite.id }
				}
				return saveFavoritesAndHandleError(favorites)
				
			case .failure(let error): return error
		}
	}
}

extension PersistenceManager {
	
	internal enum Keys {
		static let favorites: String = "favorites"
	}
	
	internal enum PersistenceError: String, Error {
		case unableToFavorite = "Unable to favorite 🙁"
		case unableToRetrieveFavorites = "Unable to retrieve favorites from local storage 🥲"
		case alreadyInFavorites = "You already favorited this place. Nothing else to be done here 😄"
	}
	
	internal enum ActionType {
		case add
		case remove
	}
}
