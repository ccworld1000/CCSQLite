//
//  ViewController.swift
//  CCSQLiteDatamacOS
//
//  Created by dengyouhua on 22/01/2018.
//  Copyright © 2018 CC | ccworld1000@gmail.com. All rights reserved.
//  https://github.com/ccworld1000/CCSQLite
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        CCSQLiteData.writeList()
        if let list = CCSQLiteData.readList() {
            print(list)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

