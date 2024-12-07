//
//  Extensions.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

extension URL {
	var asImage: UIImage? {
		guard let data = try? Data(contentsOf: self) else { return nil }
		return UIImage(data: data)
	}
}
