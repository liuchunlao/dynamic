//
//  MMCollisionView.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMCollisionView.h"

@interface MMCollisionView () <UICollisionBehaviorDelegate>

@end

@implementation MMCollisionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // MARK: - 1.添加红色视图
        UIView *redV = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 180, 40)];
        
        redV.backgroundColor = [UIColor redColor];
        
        [self addSubview:redV];
        
        
        // MARK: - 2.给方块添加重力行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.boxView]];
        
        [self.animator addBehavior:gravity];
        
        
        // MARK: - 3.碰撞检测行为 -> 添加边界
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.boxView]];
        
        // 设置边界!
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        // MARK: - 3.1 手动添加线段边界
        [collision addBoundaryWithIdentifier:@"线条" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(180, 400)];
        
        // MARK: - 3.2 手动添加路径边界
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:150 startAngle:0 endAngle:M_PI clockwise:YES];
//        
//        [collision addBoundaryWithIdentifier:@"路径" forPath:path];
        
        
        // MARK: - 3.3 设置碰撞检测行为的代理
        collision.collisionDelegate = self;
        
        [self.animator addBehavior:collision];
        
    }
    return self;
}

#pragma mark - 边缘检测行为的代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {

    NSLog(@"%@", identifier);
    
    // 1.强转为真实类型
    UIImageView *imgView = (UIImageView *)item;
    
    // 2.如果是碰撞到手动添加的边界
    NSString *ident = (NSString *)identifier;
    if ([ident isEqualToString:@"线条"]) {
        
        imgView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    }
    

}


//- (void)drawRect:(CGRect)rect {
//
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:150 startAngle:0 endAngle:M_PI clockwise:YES];
//    
//    [path stroke];
//}

@end
