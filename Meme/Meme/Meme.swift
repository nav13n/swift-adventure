//
//  Meme.swift
//  Meme
//
//  Created by Naveen Pandey on 17/08/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//

import Foundation
import UIKit

class Meme : NSObject{
    
    var topText : NSString!
    var bottomText: NSString!
    var image:UIImage!
    var memedImage:UIImage!
    
    init(topText:NSString, bottomText:NSString,image:UIImage,memedImage:UIImage){
        self.topText=topText
        self.bottomText=bottomText
        self.image=image
        self.memedImage=memedImage
    }
    
}
