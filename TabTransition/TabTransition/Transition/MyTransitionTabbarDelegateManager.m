//
//  MyTransitionTabbarDelegateManager.m
//  TabTransition
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyTransitionTabbarDelegateManager.h"
#import "MyTransitionTabBarAnimator.h"

@interface MyTransitionTabbarDelegateManager ()

@property (nonatomic,strong) UIPercentDrivenInteractiveTransition * interactiveTransition;

@end

@implementation MyTransitionTabbarDelegateManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        self.interactive = NO;
    }
    return self;
}


//切换动画
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex   = [tabBarController.viewControllers indexOfObject:toVC];
    
    NSLog(@"from:%@;to:%@",fromVC,toVC);
    
    /* 确定方向 **/
    MyTransitionTabBarAnimator * animator = [[MyTransitionTabBarAnimator alloc]init];
    animator.isSlideToRight = fromIndex > toIndex?YES:NO;
    return animator;
}

//交互动画
- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.interactive) {
        
        return self.interactiveTransition;
    }
    return nil;
}



@end
