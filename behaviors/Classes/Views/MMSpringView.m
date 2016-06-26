//
//  MMSpringView.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMSpringView.h"

@implementation MMSpringView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置附着行为的振幅和频率
        self.attachment.damping = 0.5;
        self.attachment.frequency = 0.7;
        
        // MARK: - 方式一,开启定时器
//        // 1.创建定时器
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refresh)];
//        
//        // 2.添加到运行循环
//        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        
        // MARK: - 方式二,KVO
        /**
         *  KVC -> 键值编码!

         *  KVO -> 键值监听! 本质是通过通知实现的!
         *  在dealloc中要移除监听!
         *  工作原理: 轮询! 效率比较差!
         *  黑魔法!
         */
        
        // 1.通过监听boxView的中心点的改变,实现重绘
        /**
         self.boxView  -> 被监听的对象
         oberver       -> 负责监听的对象
         keyPath       -> 监听的属性
         options       -> 监听什么值
         context       -> 上下文信息,可以写nil.在移除的时候可以用到!
         */
        [self.boxView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

#pragma mark - KVO的监听方法
/**
 *  KVO对应的监听方法
 *
 *  @param keyPath 监听的属性
 *  @param object  被监听的对象
 *  @param change  改变的信息
 *  @param context 上下文信息
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    NSLog(@"方块在跑动");
    [self setNeedsDisplay];

}

#pragma mark - 在刷新方法中一直重绘
- (void)refresh {

    [self setNeedsDisplay];
    
}

- (void)dealloc {
    
    // 移除对boxView的监听!
//    [self.boxView removeObserver:self forKeyPath:@"center" context:nil];
    
    [self.boxView removeObserver:self forKeyPath:@"center"];
    
}






@end
