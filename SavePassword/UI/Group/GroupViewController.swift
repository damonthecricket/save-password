//
//  GroupViewController.swift
//  SavePassword
//
//  Created by Damon Cricket on 13.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - GroupViewController

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PasswordViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet var deleteBarButtonItem: UIBarButtonItem!
    
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    
    
    var group: Group!
    
    var idx: Int = 0
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = group.name
        
        tableView?.tableFooterView = UIView()
    }
    
    // MARK: - Transition
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "show.password.storyboard.identifier" {
            let vc = segue.destination as! PasswordViewController
            let idx = tableView!.indexPathForSelectedRow!.row
            let password = group.logPasswords[idx]
            vc.password = password
            vc.idx = idx
            vc.delegate = self
        }
    }
    
    // MARK: - UIActions
    
    @IBAction func addBarButtonTap(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Enter login, password", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "login"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "password"
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            let loginTextField = alert.textFields![0] as UITextField
            let passwordTextField = alert.textFields![1] as UITextField
            if let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty {
                let loginPassword = LoginPassword(login: login, password: password)
                self.group.append(loginPassword)
                GroupService.shared.update(self.idx, self.group)
                self.tableView?.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(alert, animated: true)
    }
    
    @IBAction func deleteBarButtonTap(sender: UIBarButtonItem) {
        tableView?.setEditing(true, animated: true)
        navigationItem.rightBarButtonItems![1] = doneBarButtonItem
    }
    
    @IBAction func doneBarButtonTap(sender: UIBarButtonItem) {
        tableView?.setEditing(false, animated: true)
        navigationItem.rightBarButtonItems![1] = deleteBarButtonItem
    }
    
    // MARK: - UITableViewDataSource / UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.logPasswords.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "group.cell.identifier", for: indexPath) as! GroupTableViewCell
        let loginPassword = group.logPasswords[indexPath.row]
        cell.adjust(withLoginPassword: loginPassword)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete password?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { alert in
                let idx = indexPath.row
                let loginPassword = self.group.logPasswords[idx]
                self.group.remove(loginPassword)
                GroupService.shared.update(idx, self.group)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { alert in
            })
            
            present(alert, animated: true)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - PasswordViewControllerDelegate
    
    func passwordViewController(_ vc: PasswordViewController, didChangePassword password: LoginPassword, index: Int) {
        group.update(index, password)
        GroupService.shared.update(idx, group)
        tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}
