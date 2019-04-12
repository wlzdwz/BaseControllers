//
//  BaseTabBarController.m
//  控件抽调
//
//  Created by wuliangzhi on 2019/3/16.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
/*
 1.tabItem的字体;
 2.tabaItem选中时的动态效果
 3.屏幕旋转
 */


#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "BaseViewController.h"
#import "BaseTableViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController
+(void)load{
    UITabBarItem *titleItem = [UITabBarItem appearance];
    //正常
    //    titleItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
    
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    //选中
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor redColor];
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加navVC
    [self addAllChildViewControllers];

    //添加一条分割线
//    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, 0.5)];
//    view.backgroundColor = [UIColor hexStringToColor:@"#bfbfbf"];
//    [self.tabBar addSubview:view];
    
}



- (void)addAllChildViewControllers {
    
    // 主页
    BaseTableViewController *assetVc = [[BaseTableViewController alloc] init];
    BaseNavController *assetRoot =  [self addOneChildViewController:assetVc image:nil selectedImage:nil title:@"控件"];
    
    // 消息
    BaseViewController *transactionVc = [[BaseViewController alloc] init];
    BaseNavController *messageRoot =   [self addOneChildViewController:transactionVc image:nil selectedImage:nil title:@"特效"];
    self.viewControllers = @[assetRoot,messageRoot];
    
}

#pragma mark - 添加一个子控制器

- (BaseNavController *)addOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    BaseNavController *navC = [[BaseNavController alloc] initWithRootViewController:viewController];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    navC.navigationBar.titleTextAttributes = attributes;
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = image;
//        navC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    navC.tabBarItem.selectedImage = selectedImage;
    
    return navC;
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    
    if([item.title isEqualToString:@"我的"])
    {
        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
    }
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [[tabbarbuttonArray[index] layer]
     addAnimation:animation forKey:nil];
}

-(UINavigationController *)selected_NavController{
    return self.selectedViewController;
}


#pragma mark ==========屏幕旋转==========
//是否旋转
-(BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

//控制 vc present进来的横竖屏和进入方向 ，支持的旋转方向必须包含改返回值的方向
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end
