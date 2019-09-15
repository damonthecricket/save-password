//
//  MenuViewController.swift
//  SafePassword
//
//  Created by Damon Cricket on 12.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - MenuViewController

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var deleteBarButtonItem: UIBarButtonItem!
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.tableFooterView = UIView()
        tableView?.estimatedRowHeight = 55.0
        tableView?.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeChangeNotification(notification:)), name: UIContentSizeCategory.didChangeNotification , object: nil)
    }
    
    // MARK: - Notification
    
    @objc func contentSizeChangeNotification(notification: Notification) {
        tableView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "show.group.storyboard.identifier" {
            let indexPath = tableView!.indexPathForSelectedRow!
            let group = GroupService.shared.groups[indexPath.row]
            let vc = segue.destination as! GroupViewController
            vc.group = group
            vc.idx = indexPath.row
        }
    }
    
    // MARK: - UIActions
    
    @IBAction func deleteTap(sender: UIBarButtonItem) {
        tableView?.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = doneBarButtonItem
    }
    
    @IBAction func doneTap(sender: UIBarButtonItem) {
        tableView?.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem = deleteBarButtonItem
    }
    
    @IBAction func addTap(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add", message: "Name enter", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Group name"
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text, !text.isEmpty, !GroupService.shared.groups.contains(Group(name: text)) {
                GroupService.shared.add(text)
                self.deleteBarButtonItem.isEnabled = true
                self.tableView?.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            alert.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupService.shared.groups.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "group.cell.id", for: indexPath) as! MenuTableViewCell
        let group = GroupService.shared.groups[indexPath.row]
        cell.adjust(withGroup: group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let group = GroupService.shared.groups[indexPath.row]
            
            let alert = UIAlertController(title: "Delete group", message: "Are you sure you want to delete \(group.name) group", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { action in
                let group = GroupService.shared.groups[indexPath.row]
                GroupService.shared.remove(group)
                self.deleteBarButtonItem.isEnabled = !GroupService.shared.groups.isEmpty
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
            })
            
            present(alert, animated: true)
        default:
            break
        }
    }
}
