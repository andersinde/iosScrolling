//
//  ViewController.swift
//  LearningBlock6
//
//  Created by Anders Inde on 2019-06-25.
//  Copyright © 2019 ainders. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

	@IBOutlet weak var mySearchBar: UISearchBar!
	@IBOutlet weak var myTableView: UITableView!
	@IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!

	var lastContentOffset: CGFloat = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		myTableView.delegate = self
		myTableView.dataSource = self
		myTableView.backgroundColor = .clear
		myTableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
		myTableView.scrollIndicatorInsets = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
		myTableView.keyboardDismissMode = .onDrag
		navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.5373610046, blue: 0.3417848926, alpha: 1)
		
		mySearchBar.isTranslucent = false
		mySearchBar.barStyle = .default
		mySearchBar.searchBarStyle = .default
		mySearchBar.backgroundColor = .cyan
		mySearchBar.delegate = self
		
		
//		let wb = UIView(frame: mySearchBar.frame)
//		wb.backgroundColor = .white
//		self.view.addSubview(wb)
//		let constraint = NSLayoutConstraint(item: wb, attribute: .top, relatedBy: .equal, toItem: mySearchBar, attribute: .top, multiplier: 1, constant: 0)
//		NSLayoutConstraint.activate([constraint])

		self.view.bringSubviewToFront(mySearchBar)

	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let currentContentOffset = scrollView.contentOffset.y + 56
		let delta = currentContentOffset - lastContentOffset
		
		if delta > 0 {
			if currentContentOffset > 56 && searchBarTopConstraint.constant != 56 {
				searchBarTopConstraint.constant = min(searchBarTopConstraint.constant + delta, 56) // add delta if bar is not hidden
			} else {
				searchBarTopConstraint.constant = max(min(currentContentOffset, 56),0)
			}
		} else {
			if scrollView.contentOffset.y < scrollView.contentSize.height - scrollView.bounds.height { // if not at the bottom
				searchBarTopConstraint.constant = max(searchBarTopConstraint.constant + delta, 0) // add delta bar if bar is hidden
			}
		}
		
		lastContentOffset = currentContentOffset
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
	}

}

extension MyViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "id")!
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
	
}

extension MyViewController: UITableViewDelegate {
}

extension MyViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		if ![0, 56].contains(Int(searchBarTopConstraint.constant)) {
			UIView.animate(withDuration: 0.5, animations: {
				self.searchBarTopConstraint.constant = 0 //show
			})
		}
	}
}

