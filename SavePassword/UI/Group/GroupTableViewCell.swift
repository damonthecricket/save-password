//
//  GroupTableViewCell.swift
//  SavePassword
//
//  Created by Damon Cricket on 14.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - GroupTableViewCell

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loginLabel: UILabel?
    
    @IBOutlet weak var passwordLabel: UILabel?
    
    // MARK: - Adjust
    
    func adjust(withLoginPassword loginPassword: LoginPassword) {
        loginLabel?.text = loginPassword.login
        passwordLabel?.text = loginPassword.password
    }
}
