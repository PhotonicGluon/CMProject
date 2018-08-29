//
//  ViewController_ExtraDetail.swift
//  CMProject
//
//  Created by Kan Onn Kit on 13/8/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//
// NOTE: This is a subview where info is gotten from the
//       previous view.
//

import UIKit

class ViewController_ExtraDetail: UIViewController {
    // Inputs
    
    // Outputs
    @IBOutlet weak var img_attractionImg: UIImageView!
    @IBOutlet weak var txt_attractionDetail: UITextView!
    @IBOutlet weak var label_imgCredit: UILabel!
    
    // Vars
    var attractionTitle: String?
    var attractionDetail: String?
    var attractionImage: UIImage?
    var imageCredits: String?
    
    // Func
    override func viewDidLoad() {
        print()
        print("LOADING 'DETAILS' SUBVIEW")
        
        self.title = attractionTitle!
        
        img_attractionImg.layer.cornerRadius = 8.0
        img_attractionImg.clipsToBounds = true
        img_attractionImg.layer.borderColor = UIColor.black.cgColor
        img_attractionImg.layer.borderWidth = 2.0
        img_attractionImg.image = attractionImage!  // Set the image
        
        txt_attractionDetail.layer.cornerRadius = 8.0
        txt_attractionDetail.layer.borderColor = UIColor.black.cgColor
        txt_attractionDetail.layer.borderWidth = 2.0
        txt_attractionDetail.text = attractionDetail!.replacingOccurrences(of: "\\n", with: "\n")  // Properly parse the data
        
        label_imgCredit.text = "Image by \(imageCredits!)"  // Credits for the image
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}
