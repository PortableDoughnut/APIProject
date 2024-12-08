//
//  Extensions.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

protocol LoadingDelegate {
	func startLoading()
	func stopLoading()
}


extension URL {
	var asImage: UIImage? {
		guard let data = try? Data(contentsOf: self) else { return nil }
		return UIImage(data: data)
	}
}

extension FishViewController: LoadingDelegate {
	func startLoading() {
		imageView.isHidden = true
		nameLabel.isHidden = true
		newFishButton.isEnabled = false
		activityIndicatior.isHidden = false
		activityIndicatior.startAnimating()
	}
	
	func stopLoading() {
		activityIndicatior.stopAnimating()
		imageView.isHidden = false
		nameLabel.isHidden = false
		newFishButton.isEnabled = true
	}
	
	
}

extension RepresentativeTableViewController: LoadingDelegate {
	func startLoading() {
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()
	}
	
	func stopLoading() {
		activityIndicator.stopAnimating()
	}
	
	
}
