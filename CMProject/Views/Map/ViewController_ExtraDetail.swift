//
//  ViewController_ExtraDetail.swift
//  CMProject
//
//  Created by Kan Onn Kit on 13/8/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
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
        img_attractionImg.image = attractionImage!
        
        txt_attractionDetail.layer.cornerRadius = 8.0
        txt_attractionDetail.text = attractionDetail!.replacingOccurrences(of: "\\n", with: "\n")
        
        label_imgCredit.text = "Image by \(imageCredits!)"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}
