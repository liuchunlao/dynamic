//
//  MMListController.m
//  behaviors
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MMListController.h"
#import "MMDemoController.h"

@interface MMListController ()

/**
 *  存放所有行为的数组
 */
@property (nonatomic, strong) NSArray *behaviorsArr;

@end

@implementation MMListController

// MARK: - 1.重用标识符
static NSString *reuseIdentifier = @"cllID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"仿真行为";
    
    // 1.让tableView注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    // 2.取消多余的cell -> 只要有对象占据footerView,就不会显示多余的行!
    self.tableView.tableFooterView = [[UIView alloc] init];
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1.创建demoVc对象
    MMDemoController *demoVc = [[MMDemoController alloc] init];
    
    // 1.2 设置标题
    demoVc.navigationItem.title = self.behaviorsArr[indexPath.row][@"title"];
    
    // 1.3 demoVc中需要传入条件进行判断
    demoVc.funcId = (int)indexPath.row;
    
    // 2.跳转
    [self.navigationController pushViewController:demoVc animated:YES];
}


#pragma mark - 数据源方法
// 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

// 行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.behaviorsArr.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 2.设置数据
    cell.textLabel.text = self.behaviorsArr[indexPath.row][@"title"];
    
    // 2.2 设置箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 3.返回cell
    return cell;
}


#pragma mark - 懒加载
- (NSArray *)behaviorsArr {

    if (!_behaviorsArr) {
        _behaviorsArr = @[
                          @{
                              @"title" : @"吸附行为"
                              },
                          @{
                              @"title" : @"推动行为"
                              },
                          @{
                              @"title" : @"刚性附着行为"
                              },
                          @{
                              @"title" : @"弹性附着行为"
                              },
                          @{
                              @"title" : @"碰撞检测行为"
                              }
                          
                          ];
    }
    return _behaviorsArr;
    
}



@end
