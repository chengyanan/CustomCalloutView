//
//  YNCallOutAnnotationView.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/30.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNCallOutAnnotationView.h"

#define CalloutMapAnnotationViewBottomShadowBufferSize 6.0f
#define CalloutMapAnnotationViewContentHeightBuffer 8.0f
#define CalloutMapAnnotationViewHeightAboveParent 2.0f
#define  Arror_height 10

@interface YNCallOutAnnotationView()

@end
@implementation YNCallOutAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.centerOffset = CGPointMake(0, -76);
        
        self.frame = CGRectMake(0, 0, 200, 80);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark - 在加入到父视图之后显示一个跳动的动画
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self animateIn];
}

- (void)animateIn {
    
    CGFloat scale = 0.001f;
    self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat scale = 1.1;
        self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
        
    } completion:^(BOOL finished) {
        
        [self animateInStepTwo];
    }];
    
}

- (void)animateInStepTwo {
    
    [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGFloat scale = 1.0;
        self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
        
    } completion:^(BOOL finished) {
        
//        [self animateInStepThree];
    }];

}

- (void)animateInStepThree {
    [UIView beginAnimations:@"animateInStepThree" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.035];
    
    CGFloat scale = 1.0;
    self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
    
    [UIView commitAnimations];
}


#pragma mark - 在view里面画带箭头的气泡,像calloutView一样
-(void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    
    [self getDrawPath:context];
    CGContextDrawPath(context, kCGPathFillStroke);
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    // midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect)-Arror_height;
    
    CGContextMoveToPoint(context, midx+Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    
    
    CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
////      self.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

#pragma mark － getters and setters

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 15);
        
    }
    return _contentView;
}

@end
