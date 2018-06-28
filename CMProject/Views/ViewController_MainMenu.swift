//
//  ViewController_MainMenu.swift
//  CMProject
//
//  Created by Kan Onn Kit on 28/6/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import UIKit

class ViewController_MainMenu: UIViewController {
    // Inlet
    
    // Outlet
    @IBOutlet weak var btn_Map: UIButton!
    @IBOutlet weak var btn_AboutSG: UIButton!
    @IBOutlet weak var btn_Credits: UIButton!
    
    
    // Variables
    
    // Func
    
    override func viewDidLoad() {
        self.title = "APPNAME"
        
        // Update button look
        btn_Map.layer.borderWidth = 1  // Update
        btn_Map.layer.borderColor = UIColor.red.cgColor  // Update
        btn_Map.layer.cornerRadius = 10  // Update
        btn_Map.layer.backgroundColor = UIColor.red.cgColor
        
        btn_AboutSG.layer.borderWidth = 1  // Update
        btn_AboutSG.layer.borderColor = UIColor.red.cgColor  // Update
        btn_AboutSG.layer.cornerRadius = 10  // Update
        btn_AboutSG.layer.backgroundColor = UIColor.red.cgColor
        
        btn_Credits.layer.borderWidth = 1  // Update
        btn_Credits.layer.borderColor = UIColor.red.cgColor  // Update
        btn_Credits.layer.cornerRadius = 10  // Update
        btn_Credits.layer.backgroundColor = UIColor.red.cgColor
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

