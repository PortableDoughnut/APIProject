//
//  RepresentativeTableViewCell.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {
	@IBOutlet weak var partyLabel: UILabel!
	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var internetButton: UIButton!
	@IBOutlet weak var nameLabel: UILabel!
	
	var linkString: String?
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(with representative: Representative) {
		nameLabel.text = representative.name
		partyLabel.text = representative.party
		stateLabel.text = representative.state
		linkString = representative.link
	}
	
	@IBAction func internetButtonPressed(_ sender: UIButton) {
		guard let url: URL = .init(string: linkString!) else { return }
		UIApplication.shared.open(url)
	}
}
