//
//  iosJob.swift
//  AsiaSpaApp
//
//  Created by Ebrahim  Mo Gedamy on 7/2/2020.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//
  
import UIKit

class You {
    static var neediOSoftwareEng : Bool?
}
class Browser {
    class func open(url : String){
    }
}
class Twitter {
    class func retweet(url : String){
    }
}
class LinkedIn {
    class func share(url : String){
    }
}
//
//  iosJob.swift
//  AsiaSpaApp
//
//  Created by Ebrahim  Mo Gedamy on 7/2/2020.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

if You.neediOSoftwareEng == true {
    Browser.open(url: "https://github.com/EbrahiMoGedami?tab=repositories")
    Browser.open(url: "https://www.slideshare.net/slideshow/embed_code/key/aWQIj5H6wqJK40")
}else{
    Twitter.retweet(url: "https://www.slideshare.net/slideshow/embed_code/key/aWQIj5H6wqJK40")
    LinkedIn.share(url: "https://www.slideshare.net/slideshow/embed_code/key/aWQIj5H6wqJK40")
}

