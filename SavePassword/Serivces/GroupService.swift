//
//  GroupService.swift
//  SafePassword
//
//  Created by Damon Cricket on 12.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import Foundation

// MARK: - GroupService

class GroupService {
    
    struct Constants {
    
        static let groups = "groups.user.defaults.key"
    }
    
    static let shared = GroupService()
    
    private(set) var groups: [Group] = [Group]()
    
    // MARK: - Init
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: Constants.groups), let groups = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Group] {
            self.groups = groups
        }
    }
    
    // MARK: - Add
    
    func add(_ name: String) {
        let group = Group(name: name)
        groups.append(group)
        archive()
    }
    
    // MARK: - Remove
    
    func remove(_ group: Group) {
        if let idx = groups.firstIndex(of: group) {
            groups.remove(at: idx)
            archive()
        }
    }
    
    // MARK: - Update
    
    func update(_ idx: Int, _ group: Group) {
        groups[idx] = group
        archive()
    }
    
    // MARK: - Archive
    
    private func archive() {
        let data = NSKeyedArchiver.archivedData(withRootObject: groups)
        UserDefaults.standard.set(data, forKey: Constants.groups)
    }
}
