//
//  DogViewController.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

class FishViewController: UIViewController {
	@IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
	@IBOutlet weak var newFishButton: UIButton!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	var loadingDelegate: LoadingDelegate?
	let networkController: NetworkController = .init()
	var fishes: [Fish]?

	override func viewDidLoad() {
        super.viewDidLoad()
		loadingDelegate = self
		setFishes()
    }
	
	@MainActor
	func setFishes() {
		Task {
			do {
				loadingDelegate?.startLoading()
				fishes = try await networkController.fetchFish()
				setup()
			} catch {
				print("Error: \(error)")
			}
			loadingDelegate?.stopLoading()
		}
	}
    
	func setup() {
		let fishToUse: Fish? = fishes?.randomElement()
		
		imageView.image = fishToUse?.image.asImage ??
		UIImage(systemName: "exclamationmark.triangle.fill")
		
		nameLabel.text = fishToUse?.name ?? "Error"
	}
	
	
	@IBAction func newFishButtonPressed(_ sender: Any) {
		setup()
	}
}
