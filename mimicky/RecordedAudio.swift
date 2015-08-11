//
//  RecordedAudio.swift
//  mimicky
//
//  Created by Naveen Pandey on 04/05/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL,title:String){
        self.filePathUrl=filePathUrl
        self.title=title
    }
    
}
