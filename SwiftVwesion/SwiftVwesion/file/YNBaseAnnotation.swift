//
//  YNBaseAnnotation.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/14.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import MapKit

class YNBaseAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var index: Int32?
    
    init(coordinate: CLLocationCoordinate2D) {
   
        self.coordinate = coordinate
    }
}
