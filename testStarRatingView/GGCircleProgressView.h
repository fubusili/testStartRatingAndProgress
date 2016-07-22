//
//  GGCircleProgressView.h
//  testStarRatingView
//
//  Created by hc_cyril on 16/6/22.
//  Copyright © 2016年 Clark. All rights reserved.
//  圆形进度条

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface GGCircleProgressView : UIView {
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
