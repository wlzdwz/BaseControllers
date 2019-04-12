//
//  BaseViewController.m
//  控件抽调
//
//  Created by wuliangzhi on 2019/3/16.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49-64)];
    view.backgroundColor = [UIColor redColor];
    view.tag = 1001;
    [self.view addSubview:view];
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    dotView.backgroundColor = [UIColor brownColor];
    [view addSubview:dotView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [dotView addGestureRecognizer:tap];
    
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    UIViewController *vc= [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置这个值之后,控制器的坐标会在导航条之下,tabBar之上;
- (UIRectEdge)edgesForExtendedLayout{
    return UIRectEdgeNone;
}


#pragma mark ==========屏幕旋转==========
//默认是所有的VC不支持旋转:因为大多数情况下不需要支持旋转
- (BOOL)shouldAutorotate{
    return NO;
}

//默认是支持竖直方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
