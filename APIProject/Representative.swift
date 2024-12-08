//
//  Represenitive.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

struct Representative: Codable {
  var members: [Member]
}

struct Member: Codable {
  var depiction: Depiction
  var name: String
  var partyName: String
  var state: String
  var terms: Terms
}

struct Depiction: Codable {
  var imageUrl: URL
}

struct Terms: Codable {
  var item: [TermItem]
}

struct TermItem: Codable {
  var chamber: String
  var startYear: Int
}
