//
//  MyTransitionTabbarDelegateManager.h
//  TabTransition
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 实现 tabBar的动画 和 交互 **/
@interface MyTransitionTabbarDelegateManager : NSObject<UITabBarControllerDelegate>

/* 是否 交互 **/
@property (nonatomic,assign) BOOL interactive;

/*遵循<UIViewControllerInteractiveTransitioning>协议的实例 **/
@property (nonatomic,readonly) UIPercentDrivenInteractiveTransition * interactiveTransition;

@end
