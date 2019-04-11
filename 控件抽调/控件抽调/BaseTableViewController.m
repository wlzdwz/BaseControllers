//
//  BaseTableViewController.m
//  控件抽调
//
//  Created by wuliangzhi on 2019/3/16.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
}

- (void)setupBasic{
    //系统默认的是scrollView会在导航栏之下,赋值该属性之后,默认坐标(0,0),这样tableView的内容可以从上拖到导航条之下
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    AdjustsScrollViewInsetNever(self, self.tableView);
    
    //    顶部紧挨着标题框
    CGFloat top = NAVIGATION_BAR_HEIGHT;
    //底部紧挨着工具条
    CGFloat bottom = self.tabBarController.tabBar.frame.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);    
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath-----%zi",indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

//测试
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseViewController *vc = [[BaseViewController alloc] init];
    vc.fd_prefersNavigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==========屏幕旋转==========

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
