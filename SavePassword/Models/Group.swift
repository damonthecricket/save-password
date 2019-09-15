//
//  Group.swift
//  SafePassword
//
//  Created by Damon Cricket on 12.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import Foundation

// MARK: - Group

class Group: NSObject, NSCoding, NSSecureCoding {

    struct Coding {
        static let name = "name.coding.key"
        static let loginPasswords = "login.passwords.coding.key"
    }
    
    static var supportsSecureCoding: Bool = true
    
    private(set) var name: String = ""
    
    private(set) var logPasswords: [LoginPassword] = []
    
    // MARK: - Object LifeCycle
    
    init(name: String, logPasswords: [LoginPassword] = []) {
        self.name = name
        self.logPasswords = logPasswords
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: Coding.name) as! String
        let logPasswords = (aDecoder.decodeObject(forKey: Coding.loginPasswords) as? [LoginPassword]) ?? []
        
        self.init(name: name, logPasswords: logPasswords)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Coding.name)
        aCoder.encode(logPasswords, forKey: Coding.loginPasswords)
    }
    
    // MARK: - Append
    
    func append(_ loginPassword: LoginPassword) {
        if !logPasswords.contains(loginPassword) {
            logPasswords.append(loginPassword)
        }
    }
    
    // MARK: - Remove
    
    func remove(_ loginPassword: LoginPassword) {
        if let idx = logPasswords.firstIndex(of: loginPassword) {
            logPasswords.remove(at: idx)
        }
    }
    
    // MARK: - Update
    
    func update(_ idx: Int, _ loginPassword: LoginPassword) {
        logPasswords[idx] = loginPassword
    }
    
    // MARK: - Equality
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name && lhs.logPasswords == rhs.logPasswords
    }
}
