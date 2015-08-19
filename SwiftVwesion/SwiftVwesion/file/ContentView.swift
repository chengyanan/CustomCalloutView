//
//  ContentView.swift
//  CalloutView
//
//  Created by 农盟 on 15/8/19.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class ContentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.image)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var image: UIImageView = {
        
        var tempImage = UIImageView(frame: CGRectMake(10, (self.frame.size.height-50-10) / 2, 50, 50))
        tempImage.layer.cornerRadius = 25
        tempImage.contentMode = UIViewContentMode.ScaleAspectFit
        tempImage.clipsToBounds = true
        tempImage.image = UIImage(named: "avator")
        return tempImage
        }()

}
