//
//  MMAttachmentView.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMAttachmentView.h"

@interface MMAttachmentView ()

/**
 *  附着点的图片框
 */
@property (nonatomic, weak) UIImageView *anchorImgView;


/**
 *  偏移点的图片框
 */
@property (nonatomic, weak) UIImageView *offsetImgView;




@end

@implementation MMAttachmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
#pragma mark - 1.刚性附着行为
        
        // 1.创建行为
        // 1.1 偏移的距离
        UIOffset offset = UIOffsetMake(10, 10);
        // 1.2 附着点
        CGPoint anchorP = CGPointMake(self.center.x, 264);
        
        // 1.3 创建行为
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.boxView offsetFromCenter:offset attachedToAnchor:anchorP];
        
        // 2.添加给仿真者
        [self.animator addBehavior:attachment];
        
        // 赋值
        _attachment = attachment;
        
#pragma mark - 2.添加指示的图片框!
        // 1.加载图片
        UIImage *smallImg = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        
        // MARK: -2.1 附着点的图片框
        // - 创建图片框
        UIImageView *anchorImgView = [[UIImageView alloc] initWithImage:smallImg];
        // - 设置中心点
        anchorImgView.center = anchorP;
        // - 添加
        [self addSubview:anchorImgView];
        // - 赋值
        _anchorImgView = anchorImgView;
        
        
        // MARK: -2.2 偏移点位置的图片框
        // - 创建图片框
        UIImageView *offsetImgView = [[UIImageView alloc] initWithImage:smallImg];
        // - 设置中心点
        CGSize boxSize = self.boxView.bounds.size;
        offsetImgView.center = CGPointMake(boxSize.width * 0.5 + offset.horizontal, boxSize.height * 0.5 + offset.vertical);
        
        // - 添加
        [self.boxView addSubview:offsetImgView];
        // - 赋值
        _offsetImgView = offsetImgView;
        
        
#pragma mark - 3.拖拽手势识别器
        // 1.创建拖拽
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        // 2.添加
        [self addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - 拖拽的方法
- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    
    // 1.获取触摸点
    CGPoint loc = [recognizer locationInView:self];
    
    // 2.修改附着行为的附着点
    self.attachment.anchorPoint = loc;
    // 2.2 修改图片框的位置
    self.anchorImgView.center = loc;
    
    
    // 3.重绘
    [self setNeedsDisplay];
}

#pragma mark - 绘图方法
- (void)drawRect:(CGRect)rect {

    // 1.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 2.设置起点
    [path moveToPoint:self.anchorImgView.center];
    
    // 3.画线
    // 直接绘制,坐标是有问题的.需要进行坐标转换!
//    [path addLineToPoint:self.offsetImgView.center];
    
    CGPoint newP = [self convertPoint:self.offsetImgView.center fromView:self.boxView];
    [path addLineToPoint:newP];
    
    
    // 4.设置属性
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    [[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0] setStroke];
    
    // 5.渲染
    [path stroke];
}



@end
