//
//  ViewController.swift
//  SwiftVwesion
//
//  Created by 农盟 on 15/8/19.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var callOutAnnotationView: YNCallOutAnnotationView?
    var callOutAnnotation: YNCallOutAnnotation?
    
    var isDeleteAnnotation: Bool = false
    
    lazy var mapView: MKMapView = {
        var tempMapView = MKMapView(frame: self.view.bounds)
        tempMapView.showsUserLocation = true
        tempMapView.userTrackingMode = MKUserTrackingMode.Follow
        tempMapView.mapType = MKMapType.Standard
        tempMapView.delegate = self
        return tempMapView
        }()
    
    var coordinate: CLLocationCoordinate2D {
        
        return CLLocationCoordinate2DMake(43.7736, 113.718)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mapView)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.003739, 0.003201)
        let regin: MKCoordinateRegion = MKCoordinateRegionMake(self.coordinate, span)
        self.mapView.setRegion(regin, animated: true)
        
        addEnterpriseAnnotation()
    }
    
    
    //MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is YNBaseAnnotation {
            
            let identify = "PINANNOTATIONVIEW"
            var pinAnnotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identify) as? MKPinAnnotationView
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identify)
                
            }
            
            pinAnnotationView?.canShowCallout = false
            pinAnnotationView?.pinColor = MKPinAnnotationColor.Purple
            return pinAnnotationView
            
        } else if annotation is YNCallOutAnnotation {
            
            let callOutidentify = "CALLOUTANNOTATIONVIEW"
            var callOutAnnotationView: YNCallOutAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(callOutidentify) as? YNCallOutAnnotationView
            if callOutAnnotationView == nil {
                
                callOutAnnotationView = YNCallOutAnnotationView(annotation: annotation, reuseIdentifier: callOutidentify)
            }
            
            callOutAnnotationView!.alpha = 1.0
            self.callOutAnnotationView = callOutAnnotationView
            
            let contentView: ContentView = ContentView(frame: callOutAnnotationView!.bounds)
            
            callOutAnnotationView?.addSubview(contentView)
            
            return callOutAnnotationView
        }
        
        
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        if view.annotation is YNBaseAnnotation {
            
            self.isDeleteAnnotation = false
//            let baseAnnotation: YNBaseAnnotation = view.annotation as! YNBaseAnnotation
            
            //TODO: 纪录 baseAnnotation.index
            
            let callOutAnnotation = YNCallOutAnnotation(coordinate: view.annotation!.coordinate)
            mapView.addAnnotation(callOutAnnotation)
            self.callOutAnnotation = callOutAnnotation
        }
        
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        
        if let _ = self.callOutAnnotation {
            
            self.isDeleteAnnotation = true
            
            UIView.animateWithDuration(0.3 , animations: { () -> Void in
                
                self.callOutAnnotationView!.alpha = 0.0
                
                }, completion: { (finished) -> Void in
                    
                    if self.isDeleteAnnotation {
                        
                        if let _ = self.callOutAnnotation {
                        
                            self.mapView.removeAnnotation(self.callOutAnnotation!)
                            self.callOutAnnotation = nil
                            
                        }
                        
                        
                    }
                    
            })
            
            
        }
        
    }
    
    
    func addEnterpriseAnnotation() {
        
        let coordinate1: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.coordinate.latitude - 0.001, self.coordinate.longitude )
        let baseAnnotation1: YNBaseAnnotation = YNBaseAnnotation(coordinate: coordinate1)
        baseAnnotation1.index = 1
        
        let coordinate2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.coordinate.latitude + 0.001, self.coordinate.longitude )
        let baseAnnotation2: YNBaseAnnotation = YNBaseAnnotation(coordinate: coordinate2)
        baseAnnotation2.index = 2
        
        self.mapView.addAnnotations([baseAnnotation1, baseAnnotation2])
        
    }


}

