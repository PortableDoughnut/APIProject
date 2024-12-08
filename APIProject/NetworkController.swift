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
				"Invalid newwork connection"
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
		request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
		
			do {
				var (data, response) = try await URLSession.shared.data(for: request)
				
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
}
