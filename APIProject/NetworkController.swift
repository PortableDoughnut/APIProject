//
//  NetworkController.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit
import Foundation

enum NetworkControllerError: Error, LocalizedError{
	case invalidURL
	case responseSetupError
	case invalidResponse
}

extension NetworkControllerError: CustomStringConvertible{
	var description: String{
		switch self{
			case .invalidURL:
				"Invalid URL"
			case .responseSetupError:
				"Could not setup HTTP response"
			case .invalidResponse:
				"Invalid network connection"
		}
	}
}

class NetworkController {
	func fetchFish() async throws -> [Fish]?{
		var toReturn: [Fish]?
		
		var fishURLComponents: URLComponents = .init()
		fishURLComponents.scheme = "https"
		fishURLComponents.host = "api.nookipedia.com"
		fishURLComponents.path += "/nh/fish"
		
		guard let url = fishURLComponents.url else { throw NetworkControllerError.invalidURL }
		
		var request: URLRequest = .init(url: url)
		request.addValue(AC_API_KEY, forHTTPHeaderField: "X-API-KEY")
		
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse
				else { throw NetworkControllerError.responseSetupError }
				
				guard httpResponse.statusCode == 200
				else {
					print("Status Code: \(httpResponse.statusCode)")
					throw NetworkControllerError.invalidResponse
				}
				
				toReturn = try JSONDecoder().decode([Fish].self, from: data)
			} catch {
				print("Error: \(error)")
			}
		return toReturn
	}
	
	func fetchRepresentative(state stateCode: String, district: Int) async throws -> [Member]? {
		var toReturn: [Member]?
		
		guard let url: URL = .init(
			string: "https://api.congress.gov/v3/member/\(stateCode)/\(district)?currentMember=true&api_key=\(US_API_KEY)"
		) else { throw NetworkControllerError.invalidURL }
	
		
		var request: URLRequest = .init(url: url)
		request.addValue(US_API_KEY, forHTTPHeaderField: "api_key")
		do {
			let (data, response) = try await URLSession.shared.data(for: request)
			
			guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse
			else { throw NetworkControllerError.responseSetupError }
			
			guard httpResponse.statusCode == 200
			else {
				print("Status Code: \(httpResponse.statusCode)")
				throw NetworkControllerError.invalidResponse
			}
			
			let representatives = try JSONDecoder().decode(Representative.self, from: data)
			
			toReturn = representatives.members
		} catch {
			print("Error: \(error)")
		}
		
		return toReturn
	}
}
