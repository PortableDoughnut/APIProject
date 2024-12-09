//
//  Represenitive.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

struct RepresentativeResponse: Codable {
	let results: [Representative]
}

struct Representative: Codable {
	let name: String
	let party: String
	let state: String
	let district: String
	let phone: String
	let office: String
	let link: String
}
