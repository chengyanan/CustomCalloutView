//
//  YNCallOutAnnotation.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/14.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import MapKit

class YNCallOutAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
    }
}
