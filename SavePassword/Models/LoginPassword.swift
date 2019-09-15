//
//  LoginPassword.swift
//  SavePassword
//
//  Created by Damon Cricket on 13.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import Foundation

// MARK: - LoginPassword

class LoginPassword: NSObject, NSCoding, NSSecureCoding {

    struct Coding {
        static let login = "login.coding.key"
        static let password = "password.coding.key"
    }
    
    static var supportsSecureCoding: Bool = true
    
    private(set) var login: String = ""
    
    private(set) var password: String = ""
    
    // MARK: - Object LifeCycle
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        let login = aDecoder.decodeObject(forKey: Coding.login) as! String
        let password = aDecoder.decodeObject(forKey: Coding.password) as! String
        
        self.init(login: login, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(login, forKey: Coding.login)
        aCoder.encode(password, forKey: Coding.password)
    }
    
    // MARK: - Equality
    
    static func ==(lhs: LoginPassword, rhs: LoginPassword) -> Bool {
        return lhs.login == rhs.login && lhs.password == rhs.password
    }
}
