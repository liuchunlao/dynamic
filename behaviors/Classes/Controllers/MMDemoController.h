//
//  MMDemoController.h
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

// MARK: - 1.定义枚举
typedef enum {
    
    kDemoFuncSnap,
    kDemoFuncPush,
    kDemoFuncAttachment,
    kDemoFuncSpring,
    kDemoFuncCollision

}kDemoFunc;

@interface MMDemoController : UIViewController

/**
 *  功能代号,根据这个代号确定加载哪个视图
 */
//@property (nonatomic, assign) int funcId;

@property (nonatomic, assign) kDemoFunc funcId;

@end
