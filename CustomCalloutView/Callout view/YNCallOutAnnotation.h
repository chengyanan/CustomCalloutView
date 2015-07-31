//
//  YNCallOutAnnotation.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/30.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface YNCallOutAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
