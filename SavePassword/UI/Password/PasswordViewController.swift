//
//  PasswordViewController.swift
//  SavePassword
//
//  Created by Damon Cricket on 15.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PasswordViewControllerDelegate

protocol PasswordViewControllerDelegate: class {
    
    func passwordViewController(_ vc: PasswordViewController, didChangePassword password: LoginPassword, index: Int)
}

// MARK: - PasswordViewController

class PasswordViewController: UIViewController {
    
    weak var delegate: PasswordViewControllerDelegate?
    
    
    @IBOutlet weak var loginTextField: UITextField?
    
    @IBOutlet weak var passwordTextField: UITextField?
    
    
    @IBOutlet var editBarButton: UIBarButtonItem!
    
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    @IBOutlet var cancelBarButton: UIBarButtonItem!
    
    
    var password: LoginPassword!
    
    var idx: Int = 0

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTextFields()
        
        setCancelBarButtonItem(isEnabled: false)
    }
    
    // MARK: - UIActions

    @IBAction func editBarButtonTap(sender: UIBarButtonItem) {
        setCancelBarButtonItem(isEnabled: true)
        setTextFields(isEnabled: true)
        navigationItem.rightBarButtonItems?[0] = doneBarButton
        loginTextField?.becomeFirstResponder()
    }
    
    @IBAction func doneBarButtonTap(sender: UIBarButtonItem) {
        let pswd = LoginPassword(login: loginTextField?.text ?? "", password: passwordTextField?.text ?? "")
        delegate?.passwordViewController(self, didChangePassword: pswd, index: idx)
        setTextFields(isEnabled: false)
        setCancelBarButtonItem(isEnabled: false)
        navigationItem.rightBarButtonItems?[0] = editBarButton
    }
    
    @IBAction func cancelBarButtonTap(sender: UIBarButtonItem) {
        setTextFields(isEnabled: false)
        fillTextFields()
        setCancelBarButtonItem(isEnabled: false)
        navigationItem.rightBarButtonItems?[0] = editBarButton
    }
    
    private func setCancelBarButtonItem(isEnabled: Bool) {
        navigationItem.rightBarButtonItems?[1].isEnabled = isEnabled
        navigationItem.rightBarButtonItems?[1].tintColor = isEnabled ? UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1) : UIColor.clear
    }
    
    private func fillTextFields() {
        loginTextField?.text = password.login
        passwordTextField?.text = password.password
    }
    
    private func setTextFields(isEnabled: Bool) {
        loginTextField?.isEnabled = isEnabled
        passwordTextField?.isEnabled = isEnabled
    }
}
