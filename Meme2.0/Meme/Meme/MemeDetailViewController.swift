//
//  MemeDetailController.swift
//  Meme
//
//  Created by Naveen Pandey on 18/08/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//

import UIKit
class MemeDetailViewController:UIViewController{
    
    @IBOutlet weak var memeImageView: UIImageView!
    var selectedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Meme Detail"
        
        //Set the selected Meme Image to ImageView
        self.memeImageView.image=selectedMeme.image
        
    }
    
}
