//
//  MMDemoController.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMDemoController.h"
#import "MMBaseView.h"
#import "MMSnapView.h"
#import "MMPushView.h"
#import "MMAttachmentView.h"
#import "MMSpringView.h"
#import "MMCollisionView.h"

@interface MMDemoController ()

@end

@implementation MMDemoController

#pragma mark - 测试
- (void)demo {
    // MARK: - 测试baseView
    // 1.创建baseView对象
    MMBaseView *baseView = [[MMBaseView alloc] initWithFrame:self.view.bounds];
    // 2.添加
    [self.view addSubview:baseView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // MARK: - 根据传入的代号确定加载哪个视图
    // 1.判断
    MMBaseView *baseView; // 多态!
    
    switch (self.funcId) {
            
        case kDemoFuncSnap:
            baseView = [[MMSnapView alloc] initWithFrame:self.view.bounds];
            break;
            
        case kDemoFuncPush:
            baseView = [[MMPushView alloc] initWithFrame:self.view.bounds];
            break;
            
        case kDemoFuncAttachment:
            baseView = [[MMAttachmentView alloc] initWithFrame:self.view.bounds];
            break;
            
        case kDemoFuncSpring:
            baseView = [[MMSpringView alloc] initWithFrame:self.view.bounds];
            break;
            
        case kDemoFuncCollision:
            baseView = [[MMCollisionView alloc] initWithFrame:self.view.bounds];
            break;
            
        default:
            break;
    }
    
    // 添加
    [self.view addSubview:baseView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
