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
    @IBOutlet weak var btn_AboutSG: UIButton! // NOTE: Now has been updated to SGEvents
    @IBOutlet weak var btn_Credits: UIButton!
//    @IBOutlet weak var btn_Directions: UIButton!
    
    
    // Variables
    let BOARDER_WIDTH  = CGFloat(5)
    let BOARDER_COLOR = UIColor.red.cgColor
    let CORNER_RADIUS = CGFloat(30)
    let BACKGROUND_COLOR = UIColor.red.cgColor
    
    // Func
    
    override func viewDidLoad() {
        print("LOADING 'MAIN MENU' VIEW CONTROLLER")
        
        self.title = "Main Menu"
        
        // Update button look
        btn_Map.layer.borderWidth = BOARDER_WIDTH
        btn_Map.layer.borderColor = BOARDER_COLOR
        btn_Map.layer.cornerRadius = CORNER_RADIUS
//        btn_Map.layer.backgroundColor = BACKGROUND_COLOR
        
        btn_AboutSG.layer.borderWidth = BOARDER_WIDTH
        btn_AboutSG.layer.borderColor = BOARDER_COLOR
        btn_AboutSG.layer.cornerRadius = CORNER_RADIUS
//        btn_AboutSG.layer.backgroundColor = BACKGROUND_COLOR
        
        btn_Credits.layer.borderWidth = BOARDER_WIDTH
        btn_Credits.layer.borderColor = BOARDER_COLOR
        btn_Credits.layer.cornerRadius = CORNER_RADIUS
//        btn_Credits.layer.backgroundColor = BACKGROUND_COLOR
        
//        btn_Directions.layer.borderWidth = BOARDER_WIDTH
//        btn_Directions.layer.borderColor = BOARDER_COLOR
//        btn_Directions.layer.cornerRadius = CORNER_RADIUS
//        btn_Directions.layer.backgroundColor = BACKGROUND_COLOR
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

