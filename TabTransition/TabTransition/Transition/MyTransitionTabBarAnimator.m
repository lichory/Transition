//
//  MyTransitionTabBarAnimator.m
//  TabTransition
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyTransitionTabBarAnimator.h"

@implementation MyTransitionTabBarAnimator


/* 动画执行时间 **/
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

/* 动画的执行 交互 **/
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSLog(@"animator: from:%@;to:%@",fromVC,toVC);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    
    UIView * fromView = fromVC.view;
    UIView * toView   = toVC.view;
    
    CGFloat  offset;
    //向右边滑动，toFrame 应该在在左边
    if (self.isSlideToRight) {
        offset = -1 * toFrame.size.width;
    }else {
        offset = 1 * toFrame.size.width;
    }
    fromView.frame = fromFrame;
    toView.frame   = CGRectOffset(toFrame, offset,0);
    
    [transitionContext.containerView addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        fromView.frame = CGRectOffset(fromFrame, -offset, 0);
        toView.frame = toFrame;
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}


@end
