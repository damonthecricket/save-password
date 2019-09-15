//
//  MenuTableViewCell.swift
//  SavePassword
//
//  Created by Damon Cricket on 12.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - MenuTableViewCell

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel?

    // MARK: - Adjust
    
    func adjust(withGroup group: Group) {
        label?.text = group.name
    }
}
