//
//  ViewController.m
//  testReplicatorLayerView
//
//  Created by billionsfinance-resory on 15/11/7.
//  Copyright © 2015年 Resory. All rights reserved.
//

#import "ViewController.h"

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                  // 屏幕宽度
#define SYS_DEVICE_HE2IGHT   ([[UIScreen mainScreen] bounds].size.height)                 // 屏幕长度

@interface ViewController ()

@property (nonatomic, strong) CAReplicatorLayer *loveLayer;
@property (nonatomic, strong) CAReplicatorLayer *musicLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark - Layer Init

- (void)loveReplicatorLayer
{
    _loveLayer = [CAReplicatorLayer layer];
    _loveLayer.instanceCount = 40;                // 40个layer
    _loveLayer.instanceDelay = 0.2;               // 每个0.2出现一个layer
    _loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    _loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    _loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    _loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    
    // 爱心路径
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 400) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 + 200, 20)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 - 200, 20)];
    [tPath closePath];
    
    // 具体的layer
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake(SYS_DEVICE_WIDTH/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    // 动作效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    [_loveLayer addSublayer:tView.layer];
    [self.view.layer addSublayer:_loveLayer];
}

- (void)musicReplicatorLayer
{
    _musicLayer = [CAReplicatorLayer layer];
    _musicLayer.frame = CGRectMake(0, 0, 60, 100);
    _musicLayer.position = self.view.center;
    _musicLayer.instanceCount = 3;
    _musicLayer.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
    _musicLayer.instanceDelay = 0.2;
    _musicLayer.backgroundColor = [UIColor greenColor].CGColor;
    _musicLayer.masksToBounds = YES;
    [self.view.layer addSublayer:_musicLayer];
    
    CALayer *tLayer = [CALayer layer];
    tLayer.frame = CGRectMake(10, 100, 10, 30);
    tLayer.backgroundColor = [UIColor redColor].CGColor;
    [_musicLayer addSublayer:tLayer];
    
    CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    musicAnimation.duration = 0.35;
    musicAnimation.fromValue = @(100);
    musicAnimation.toValue = @(85);
    musicAnimation.autoreverses = YES;
    musicAnimation.repeatCount = MAXFLOAT;
    
    [tLayer addAnimation:musicAnimation forKey:@"musicAnimation"];
}

#pragma mark -
#pragma mark - Layer Action

- (IBAction)showLoveAnimation:(id)sender
{
    [self layerClear];
    [self loveReplicatorLayer];
}

- (IBAction)showMusicAnimation:(id)sender
{
    [self layerClear];
    [self musicReplicatorLayer];
}

- (void)layerClear
{
    [_musicLayer removeFromSuperlayer];
    [_loveLayer removeFromSuperlayer];
}
@end
