//
//  MMPushView.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMPushView.h"

@interface MMPushView ()

/**
 *  小黑图
 */
@property (nonatomic, weak) UIImageView *maskImgView;

/**
 * 移动过程中的当前点
 */
@property (nonatomic, assign) CGPoint currentP;

/**
 * 推力行为
 */
@property (nonatomic, strong) UIPushBehavior *push;

@end

@implementation MMPushView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // MARK: - 0.小黑圈图片
        // 0.1 创建图片框
        UIImageView *maskImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AttachmentPoint_Mask"]];
        
        // 0.2 默认隐藏
        maskImgView.hidden = YES;
        // 0.3 添加
        [self addSubview:maskImgView];
        
        // 0.4 赋值
        _maskImgView = maskImgView;
        
        // MARK: - 0.2 蓝色小视图
        UIView *blueV = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
        
        blueV.backgroundColor = [UIColor blueColor];
        
        [self addSubview:blueV];
        
        
        // MARK: - 1.拖拽手势识别器
        // 1.1 创建识别器
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        
        // 1.2 添加
        [self addGestureRecognizer:pan];
        
        // MARK: - 2.推动行为
        // 1.创建推动行为
        /**
         UIPushBehaviorModeContinuous      持续推动!
         UIPushBehaviorModeInstantaneous   单次推!
         */
        UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.boxView] mode:UIPushBehaviorModeInstantaneous];
        
        // 2.添加
        [self.animator addBehavior:push];
        
        // 3.赋值
        _push = push;
        
        // MARK: - 3.碰撞检测行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.boxView, blueV]];
        
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        [self.animator addBehavior:collision];
    }
    return self;
}

// 1.3 实现方法
- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    
    // 0.获取触摸点
    CGPoint loc = [recognizer locationInView:self];
    

    // 1.判断状态,执行不同操作
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始,显示图片,并且在手底下");
        // 1.需要显示图片框
        self.maskImgView.hidden = NO;
        // 2.图片框在触摸点的位置
        self.maskImgView.center = loc;
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"移动");
        
        // 1.记录当前点
        _currentP = loc;
        
        // 2.重绘
        [self setNeedsDisplay];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束,隐藏");
        // 1.隐藏图片
        self.maskImgView.hidden = YES;
        
        // MARK: -2.设置推力的力度和方向,active单次推需要设置为YES
        // 1.直角边的长度
        CGFloat offsetX = self.maskImgView.center.x - self.currentP.x;
        CGFloat offsetY = self.maskImgView.center.y - self.currentP.y;
        
        // 2.计算斜边的长度
        CGFloat distance = hypot(offsetX, offsetY);
        
        // 3.计算角度
        CGFloat angle = atan2(offsetY, offsetX);
        
        // 方向
        self.push.angle = angle;
        // 力度
        self.push.magnitude = distance;
        // 生效
        self.push.active = YES;
        
        
        // 3.结束后,清除线!
        // - 将两个点都置为0
        self.maskImgView.center = CGPointZero;
        self.currentP = CGPointZero;
        
        [self setNeedsDisplay];
        
    }

}

#pragma mark - 绘图的方法
- (void)drawRect:(CGRect)rect {

    // 1.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 2.设置起点
    [path moveToPoint:self.maskImgView.center];
    
    // 3.添加线 -> 移动过程中的当前点!
    [path addLineToPoint:self.currentP];
    
    // 4.设置属性
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    [[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0] setStroke];
    
    // 5.渲染
    [path stroke];

}














@end
