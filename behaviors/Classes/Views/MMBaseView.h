//
//  MMBaseView.h
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBaseView : UIView

/**
 *  小方块
 */
@property (nonatomic, weak) UIImageView *boxView;

/**
 *  仿真者
 */
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end
