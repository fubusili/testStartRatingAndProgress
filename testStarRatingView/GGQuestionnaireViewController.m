//
//  ViewController.m
//  testStarRatingView
//
//  Created by hc_cyril on 16/5/30.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "GGQuestionnaireViewController.h"
#import "HCSStarRatingView.h"
#import "Masonry.h"
#import <IQKeyboardManager.h>
#import "GGCircleProgressView.h"
#import "UIColor+Hexadecimal.h"
#import <UAProgressView/UAProgressView.h>
#import <AudioToolbox/AudioToolbox.h>
#import "GGCircleProgressView.h"

@interface GGQuestionnaireViewController ()
@property (nonatomic, strong) HCSStarRatingView *starRatingView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UAProgressView *progressView;
@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) CGFloat localProgress;
@property (nonatomic, assign) SystemSoundID horn;
@end

@implementation GGQuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpSubviews];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    self.progressView = [[UAProgressView alloc ]initWithFrame:CGRectMake(100, 300, 60, 60)];
    self.progressView.tintColor = [UIColor colorWithRed:224.6/255.0 green:58.6/255.0 blue:60.2/255.0 alpha:1.0];
    self.progressView.backCircleColor = nil;
    self.progressView.borderWidth = 4.0;
    self.progressView.lineWidth = 4.0;
    self.progressView.fillOnTouch = NO;
    [self.view addSubview:self.progressView];
    
//    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.height.and.with.equalTo(@(60));
//    }];

    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 32.0)];
    textLabel.font = [UIFont fontWithName:@"Arial" size:25];//@"HelveticaNeue-UltraLight"
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = self.progressView.tintColor;
    textLabel.backgroundColor = [UIColor clearColor];
    self.progressView.centralView = textLabel;
    
    self.progressView.fillChangedBlock = ^(UAProgressView *progressView, BOOL filled, BOOL animated){
        UIColor *color = (filled ? [UIColor whiteColor] : progressView.tintColor);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [(UILabel *)progressView.centralView setTextColor:color];
            }];
        } else {
            [(UILabel *)progressView.centralView setTextColor:color];
        }
    };
    
    self.progressView.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress){
        NSString *percentStr = @"%";
        NSString *textStr = [NSString stringWithFormat:@"%2.0f%@", progress * 100,percentStr];
        NSMutableAttributedString *textAttribtedStr= [[NSMutableAttributedString alloc] initWithString:textStr];
        [textAttribtedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:12] range:NSMakeRange(textStr.length - percentStr.length, percentStr.length)];
        [(UILabel *)progressView.centralView setAttributedText:textAttribtedStr];
    };
    self.progressView.progress = 0;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

#pragma mark -



- (void)updateProgress:(NSTimer *)timer {
    if (!_paused && _localProgress < 1) {
        _localProgress = _localProgress + 0.01;//((int)((_localProgress * 100.0f) + 1.01) % 100) / 100.0f;
        [self.progressView setProgress:_localProgress];
    }
}

- (void)setUpSubviews {

    [self.view addSubview:self.starRatingView];
    [self.starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.equalTo(self.view);
        make.height.equalTo(@(100));
    }];
    
}

#pragma mark - get and set methods
- (HCSStarRatingView *)starRatingView {

    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] init];//WithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)
        _starRatingView.maximumValue = 10;
        _starRatingView.minimumValue = 0;
        _starRatingView.emptyStarImage = [UIImage imageNamed:@"starRating_star_gray"];
        _starRatingView.filledStarImage = [UIImage imageNamed:@"starRating_star_yellow"];
        
    }
    return _starRatingView;
}

@end
