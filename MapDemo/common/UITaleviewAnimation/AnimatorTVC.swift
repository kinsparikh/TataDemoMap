

import UIKit

final class AnimatorTVC {
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
