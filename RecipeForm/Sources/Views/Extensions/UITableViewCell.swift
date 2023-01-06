//
//  UITableViewCell.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 06.01.2023.
//

import UIKit

extension UITableViewCell {
    
    /// Table view in which cell is being presented.
    var tableView: UITableView? {
        return superview as? UITableView
    }
    
    /// Cell's index path.
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
    
}
