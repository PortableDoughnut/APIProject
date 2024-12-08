//
//  Fish.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//
import UIKit

struct Fish: Codable {
	var name: String
	var image: URL
	
	enum CodingKeys: String, CodingKey {
		case name
		case image = "image_url"
	}
}

extension Fish: CustomStringConvertible { var description: String { name } }
