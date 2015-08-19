//
//  YNCallOutAnnotationView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/14.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import MapKit

class YNCallOutAnnotationView: MKAnnotationView {

    let kArror_height: CGFloat = 10
    
    lazy var contentView: UIView = {
        return UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 15))
        }()
    
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.centerOffset = CGPointMake(0, -76);
        self.frame = CGRectMake(0, 0, 200, 80);
        self.backgroundColor = UIColor.clearColor()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.contentView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 出现的动画
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        animateIn()
    }
    
    func animateIn() {
   
        let scale: CGFloat = 0.001
        self.transform = CGAffineTransformMake(scale, 0, 0, scale, 0, 0)
        
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            
            let scaleIn: CGFloat = 1.1
            self.transform = CGAffineTransformMake(scaleIn, 0, 0, scaleIn, 0, 0)
            
        }) { (Bool) -> Void in
            
          self.animateInStepTwo()
        }
    }
    
    func animateInStepTwo() {
        
        UIView.animateWithDuration(0.075, animations: { () -> Void in
            
            let scale: CGFloat = 1.0
            self.transform = CGAffineTransformMake(scale, 0, 0, scale, 0, 0)
            
            }) { (Bool) -> Void in
                
                
        }
        
    }
    
    //MARK: - 画一个背景气泡
    override func drawRect(rect: CGRect) {
        
        drawInContext(UIGraphicsGetCurrentContext())
    }
    
    func drawInContext(context: CGContextRef) {
   
        CGContextSetLineWidth(context, 0.5)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor)
        getDrawPath(context)
        CGContextDrawPath(context, kCGPathFillStroke)
    }
    
    func getDrawPath(context: CGContextRef) {
        
        let rect = self.bounds
        let radius: CGFloat = 6.0
        
        let minx = CGRectGetMinX(rect)
        let midx = CGRectGetMidX(rect)
        let maxx = CGRectGetMaxX(rect)
        let miny = CGRectGetMinY(rect)
        let maxy = CGRectGetMaxY(rect) - kArror_height
        
        CGContextMoveToPoint(context, midx + kArror_height, maxy);
        
        CGContextAddLineToPoint(context,midx, maxy + kArror_height);
        CGContextAddLineToPoint(context,midx - kArror_height, maxy);
        
        CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
        CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
        CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
        
        CGContextClosePath(context);
        
    }
    
    
}
