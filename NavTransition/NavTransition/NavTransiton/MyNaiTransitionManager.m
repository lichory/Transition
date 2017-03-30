//
//  MyNaiTransitionManager.m
//  NavTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyNaiTransitionManager.h"
#import "MyNaiTransitionAnimator.h"


@interface MyNaiTransitionManager ()

//回退的交互
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation MyNaiTransitionManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.isActive = NO;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}

#pragma mark - UINavigationControllerDelegate

// 动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationNone) {
        return nil;
    }
    
    MyNaiTransitionAnimator * naviAnimator = [[MyNaiTransitionAnimator alloc]init];
    naviAnimator.isPush = (operation == UINavigationControllerOperationPush);
    return naviAnimator;
}

//手势交互
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.isActive) {
        
        return self.interactivePopTransition;
    }
    return nil;
}

@end
