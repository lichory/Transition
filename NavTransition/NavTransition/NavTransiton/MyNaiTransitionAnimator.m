//
//  MyNaiTransitionAnimator.m
//  NavTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyNaiTransitionAnimator.h"

@implementation MyNaiTransitionAnimator

//动画的是时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

//动画执行的过程
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView   = toVC.view;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //把目标视图加入进去
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    if (self.isPush) {
        
        [containerView bringSubviewToFront:toView];
        toView.frame = CGRectOffset(containerView.bounds, CGRectGetWidth(containerView.bounds), 0);
        fromView.frame = containerView.bounds;
        
        [UIView animateWithDuration:duration animations:^{
            
            toView.frame = containerView.bounds;
            fromView.transform = CGAffineTransformMakeScale(0.8, 0.9);
        } completion:^(BOOL finished) {
            
            fromView.transform = CGAffineTransformIdentity;
            BOOL wasCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!wasCancelled];
        }];
    } else { //pop
        
        [containerView bringSubviewToFront:fromView];
        toView.frame = containerView.bounds;
        toView.transform = CGAffineTransformMakeScale(0.8, 0.9);
        fromView.frame = containerView.bounds;
        [UIView animateWithDuration:duration animations:^{
            
            toView.frame = containerView.bounds;
            toView.transform = CGAffineTransformIdentity;
            fromView.frame = CGRectOffset(containerView.bounds, CGRectGetWidth(containerView.frame), 0);
        } completion:^(BOOL finished) {
            
            BOOL wasCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}


@end


















