//
//  ViewController.m
//  CustomCalloutView
//
//  Created by 农盟 on 15/7/31.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YNBaseAnnotation.h"
#import "YNCallOutAnnotation.h"
#import "YNCallOutAnnotationView.h"
#import "YNLocationAnnotation.h"
#import "YNCallOutContentView.h"

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong)  MKMapView *mapview;

@property (nonatomic, strong)  YNCallOutAnnotation *callOutAnnotation;
@property (nonatomic, strong)  YNCallOutAnnotationView *callOutAnnotationView;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mapview];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[YNBaseAnnotation class]]) {
        
        static NSString *identify = @"PINANNOTATIONVIEW";
        
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        pinAnnotationView.canShowCallout = NO;
        return pinAnnotationView;
        
    } else  if ([annotation isKindOfClass:[YNCallOutAnnotation class]]){
        
        static NSString *identify = @"CALLOUTANNOTATIONVIEW";
        
        YNCallOutAnnotationView *callOutAnnotationView = (YNCallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (callOutAnnotationView == nil) {
            callOutAnnotationView = [[YNCallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        
        callOutAnnotationView.alpha = 1.0;
        self.callOutAnnotationView = callOutAnnotationView;
        YNCallOutContentView *view = [[YNCallOutContentView alloc] initWithFrame:callOutAnnotationView.bounds];
        [callOutAnnotationView addSubview:view];
        
        return callOutAnnotationView;
        
    } else if ([annotation isKindOfClass:[YNLocationAnnotation class]]) {
        
        static NSString *identify = @"LOCATIONANNOTATIONVIEW";
        
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        pinAnnotationView.canShowCallout = YES;
        pinAnnotationView.image = [UIImage imageNamed:@"tarBar_nearby_off"];
        pinAnnotationView.calloutOffset = CGPointMake(-1, -2);
        return pinAnnotationView;
    }
    
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[YNBaseAnnotation class]]) {
        
        YNCallOutAnnotation *callOutAnnotation = [[YNCallOutAnnotation alloc] init];
        
        [callOutAnnotation setCoordinate:view.annotation.coordinate];
        [mapView addAnnotation:callOutAnnotation];
        self.callOutAnnotation = callOutAnnotation;
    }
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if (self.callOutAnnotation) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.callOutAnnotationView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [self.mapview removeAnnotation: self.callOutAnnotation];
            
            self.callOutAnnotation = nil;
        }];
        
    }
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    CLLocationCoordinate2D centerCoordinate1 = CLLocationCoordinate2DMake(34.42, 113.42);
    
    YNBaseAnnotation *baseAnnotation = [[YNBaseAnnotation alloc] init];
    [baseAnnotation setCoordinate:centerCoordinate1];
    [_mapview addAnnotation:baseAnnotation];
    
    CLLocationCoordinate2D locationCenterCoordinate = CLLocationCoordinate2DMake(34.10, 113.30);
    YNLocationAnnotation *locationAnnotation = [[YNLocationAnnotation alloc] init];
    [locationAnnotation setCoordinate:locationCenterCoordinate];
    locationAnnotation.title = @"hello coder";
    locationAnnotation.subtitle = @"时光穿梭到未来的2080年看看";
    [self.mapview addAnnotation:locationAnnotation];
    [self.mapview selectAnnotation:locationAnnotation animated:YES];
}

#pragma getters and setters
- (MKMapView *)mapview {
    if (_mapview == nil) {
        _mapview = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _mapview.mapType = MKMapTypeStandard;
        _mapview.userTrackingMode = MKUserTrackingModeFollow;
        _mapview.delegate = self;
        CLLocationCoordinate2D centerCoordinate1 = CLLocationCoordinate2DMake(34.42, 113.42);
        
        MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);
        MKCoordinateRegion regin = MKCoordinateRegionMake(centerCoordinate1, span);
        [_mapview setRegion:regin animated:YES];
        
    }
    return _mapview;
}


@end
