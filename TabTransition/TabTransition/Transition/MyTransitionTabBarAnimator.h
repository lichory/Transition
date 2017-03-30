//
//  MyTransitionTabBarAnimator.h
//  TabTransition
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 动画转场 **/
@interface MyTransitionTabBarAnimator : NSObject<UIViewControllerAnimatedTransitioning>

// 从左边往 右边滑动
@property (nonatomic,assign) BOOL isSlideToRight;


@end
