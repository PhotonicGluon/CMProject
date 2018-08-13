//
//  ViewController_ContainerMap.swift
//  CMProject
//
//  Created by Kan Onn Kit on 22/7/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import UIKit

class ViewController_ContainerMap: UIViewController {  // This is to store the additional view (i.e. Hamburger menu + Main view)
    // Inlets
    
    // Outlets
    @IBOutlet weak var constraint_sideMenu: NSLayoutConstraint!
    
    // Var
    let ANIMATION_DURATION = 0.2
    var hamburgerMenuOpen = false
    
    // Func
    @objc func toggleHamburgerMenu()
    {
        if hamburgerMenuOpen == false
        {
            print("Opened Hamburger Menu")
            constraint_sideMenu.constant = 0
        }
        else  // Then it must be true
        {
            print("Closed Hamburger Menu")
            constraint_sideMenu.constant = -182
        }
        hamburgerMenuOpen = !hamburgerMenuOpen  // Invert the state
        
        // Animate
        UIView.animate(withDuration: ANIMATION_DURATION)
        {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func showDirections()
    {
        print("Moving to Directions subview")
        toggleHamburgerMenu()  // Toggle before switch view
        performSegue(withIdentifier: "ShowDirections", sender: nil)
    }
    
    @IBAction func btn_hamburgerMenu_onTap(_ sender: Any)
    {
      toggleHamburgerMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add observers
        NotificationCenter.default.addObserver(self, selector: #selector(toggleHamburgerMenu), name: NSNotification.Name("ToggleHamburgerMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showDirections), name: NSNotification.Name("ShowDirections"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // Check if actually moving
        if self.isMovingFromParentViewController {
            self.constraint_sideMenu.constant = 0  // "Open" the menu
        }
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
