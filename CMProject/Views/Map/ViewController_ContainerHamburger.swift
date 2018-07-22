//
//  ViewController_ContainerHamburger.swift
//  CMProject
//
//  Created by Kan Onn Kit on 22/7/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import UIKit

class ViewController_ContainerHamburger: UIViewController {
    
    // Func
    @IBAction func btn_dirAssist_onTap(_ sender: Any)
    {
        NotificationCenter.default.post(name: NSNotification.Name("ShowDirections"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
