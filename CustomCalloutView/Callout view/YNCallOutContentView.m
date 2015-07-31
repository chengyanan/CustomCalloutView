//
//  YNCallOutContentView.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/31.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNCallOutContentView.h"
@interface YNCallOutContentView()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *title;
@end

@implementation YNCallOutContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.title];
        
        [self settingLayout];
    }
    return self;
}

- (void)settingLayout {
    
}
- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(10, (self.frame.size.height -50 - 10) / 2, 50, 50);
        _imageView.layer.cornerRadius = 25;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"avator"];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 6, CGRectGetMinY(self.imageView.frame), 130, 50);
        _title.numberOfLines = 0;
        _title.font = [UIFont systemFontOfSize:13];
        _title.text = @"我自定义的大头针,好不好看 biu biu biu ~";
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}
@end
