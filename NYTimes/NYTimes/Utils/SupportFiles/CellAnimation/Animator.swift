//
//  Animator.swift
//  ECS
//
//  Created by Abdul on 10/29/19.
//  Copyright © 2019 Abdul. All rights reserved.
//

import UIKit

final class Animator {
	private var hasAnimatedAllCells = false
	private let animation: Animation

	init(animation: @escaping Animation) {
		self.animation = animation
	}

	func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
		guard !hasAnimatedAllCells else {
			return
		}

		animation(cell, indexPath, tableView)

		hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
	}
}
