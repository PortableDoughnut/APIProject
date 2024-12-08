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
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var portraitImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(with representative: Member) {
		portraitImageView.image = representative.depiction.imageUrl.asImage ??
		UIImage(systemName: "exclamationmark.triangle.fill")
		nameLabel.text = representative.name
		partyLabel.text = representative.partyName
		stateLabel.text = representative.state
	}
}
