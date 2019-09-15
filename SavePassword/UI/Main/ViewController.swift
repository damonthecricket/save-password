//
//  ViewController.swift
//  SafePassword
//
//  Created by Damon Cricket on 12.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = UIStoryboard(name: "Menu", bundle: Bundle.main).instantiateInitialViewController()!
        add(menu)
    }

    func add(_ vc: UIViewController) {
        addChild(vc)
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: vc)
    }
}

