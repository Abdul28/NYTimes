//
//  UITableView+Ext.swift
//  ECS
//
//  Created by Abdul on 10/29/19.
//  Copyright © 2019 Abdul. All rights reserved.
//



import UIKit

extension UITableView {
	func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
		guard let lastIndexPath = indexPathsForVisibleRows?.last else {
			return false
		}

		return lastIndexPath == indexPath
	}
}
