//
//  RepresentativeTableViewController.swift
//  APIProject
//
//  Created by Gwen Thelin on 12/7/24.
//

import UIKit

class RepresentativeTableViewController: UITableViewController {
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var loadingDelegate: LoadingDelegate?
	var senate: [Member] = []
	var houseOfRepresentatives: [Member] = []
	
	let networkController: NetworkController = .init()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		loadingDelegate = self
		loadRepresentatives()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 0:
				return senate.count
			case 1:
				return houseOfRepresentatives.count
			default:
				return 0
		}
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
				tableView.dequeueReusableCell(withIdentifier: "RepresentativeCell", for: indexPath)
				as? RepresentativeTableViewCell
		else { return UITableViewCell() }
		
		let currentRepresentative =
		indexPath.section == 0 ? senate[indexPath.row] : houseOfRepresentatives[indexPath.row]
		
		cell.configure(with: currentRepresentative)

        return cell
    }
	
	func loadRepresentatives(state: String = "UT") {
		Task {
			do {
				loadingDelegate?.startLoading()
				let representatives = try await networkController.fetchRepresentative(state: state)
				
				if let representatives = representatives {
					for representative in representatives {
						switch representative.terms.item.first?.chamber {
							case "House of Representatives":
								houseOfRepresentatives.append(representative)
							case "Senate":
								senate.append(representative)
							default:
								break
						}
					}
				}
				DispatchQueue.main.async {
					self.tableView.reloadData()
					self.loadingDelegate?.stopLoading()
				}
			} catch {
				print("Error: \(error)")
				loadingDelegate?.stopLoading()
			}
		}
	}
}
