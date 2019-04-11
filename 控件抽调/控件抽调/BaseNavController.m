//
//  BaseNavController.m
//  控件抽调
//
//  Created by wuliangzhi on 2019/3/16.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航条为透明(默认为透明,根视图的坐标从(0,0)开始)
    self.navigationBar.translucent = YES;
    //导航条的背景颜色
    self.navigationBar.barTintColor = [UIColor lightGrayColor];
    //导航条的文字和图片的颜色
//    self.navigationBar.tintColor = [UIColor yellowColor];
    
    //返回按钮自定义之后,侧滑返回手势失效,这里需要重新设置代理
    //1.获取系统自带滑动手势的target对象,
    id target = self.interactivePopGestureRecognizer.delegate;
    //2.创建全屏滑动手势,调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    //3.设置手势代理,拦截手势触发
    pan.delegate = self;
    //4.给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    //5.禁止系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark ==========UIGestureRecognizerDelegate==========
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count > 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回按钮
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 25, 25);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回图标"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        //将两个BarButtonItem都返回给NavigationItem
        viewController.navigationItem.leftBarButtonItems = @[leftBarBtn];
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    
    [super pushViewController:viewController animated:animated];

}

- (void)leftBarBtnClicked:(UIButton *)sender{
    [self popViewControllerAnimated:YES];
}

#pragma mark ==========屏幕旋转==========
- (BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
