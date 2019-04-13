//
//  UIView+WLZExtension.h
//  百思不得姐
//
//  Created by wuliangzhi on 2017/7/20.
//  Copyright © 2017年 wuliangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLZExtension)

/** x值*/
@property(nonatomic,assign)CGFloat x;
/**y值*/
@property(nonatomic,assign)CGFloat y;
/**宽度*/
@property(nonatomic,assign)CGFloat width;
/**高度*/
@property(nonatomic,assign)CGFloat height;

/**frame*/
@property(nonatomic,assign)CGSize size;

@property(nonatomic,assign)CGFloat centerX;

@property(nonatomic,assign)CGFloat centerY;


/** 在分类中声明@property,只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量*/

@end
