//
//  ViewController.swift
//  CCSQLiteDataiOS
//
//  Created by dengyouhua on 22/01/2018.
//  Copyright © 2018 CC | ccworld1000@gmail.com. All rights reserved.
//  https://github.com/ccworld1000/CCSQLite
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CCSQLiteData.writeList()
        if let list = CCSQLiteData.readList() {
            print(list)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

