//
//  MMSnapView.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMSnapView.h"

@interface MMSnapView ()

/**
 *  吸附行为
 */
@property (nonatomic, strong) UISnapBehavior *snapBehavior;

@end

@implementation MMSnapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 点按的手势识别器
        // 1.创建点按手势识别器
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        // 2.添加
        [self addGestureRecognizer:tap];
    }
    return self;
}

// 3.实现点按的方法
- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    
    // 1.获取触摸点
    CGPoint loc = [recognizer locationInView:self];
    
    // 2.修改吸附行为的吸附点
    self.snapBehavior.snapPoint = loc;
    
    // 3.将行为添加给仿真者
    [self.animator addBehavior:self.snapBehavior];


}

#pragma mark - 懒加载吸附行为
- (UISnapBehavior *)snapBehavior {

    if (_snapBehavior == nil) {
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:self.boxView snapToPoint:CGPointZero];
    }
    return _snapBehavior;
}


// 方式一
- (void)demo1:(UITapGestureRecognizer *)recognizer {

    // 0.移除所有的仿真行为 方式一,直接移除
    // 0.2方式二,将吸附行为进行懒加载! -> 在点击屏幕的时候,直接修改吸附行为的吸附点!
    [self.animator removeAllBehaviors];
    
    // 1.获取触摸点
    CGPoint loc = [recognizer locationInView:self];
    
    // 2.吸附行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.boxView snapToPoint:loc];
    
    // 振幅,值越大,晃动幅度越小!
    snap.damping = 1.0;
    
    // 3.将行为交给仿真者执行仿真
    [self.animator addBehavior:snap];
    
}












@end
