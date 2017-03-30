//
//  MyVCTransionAnimator.m
//  presentTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyVCTransionAnimator.h"

@implementation MyVCTransionAnimator

//动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}
//动画的过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView   = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    CGRect containerBounds = containerView.bounds;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.isPresent) {
        
        toView.frame = CGRectOffset(containerBounds, 0, CGRectGetHeight(containerBounds));
        [containerView bringSubviewToFront:toView];
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            toView.frame = containerBounds;
        } completion:^(BOOL finished) {
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    } else {
        
        [containerView bringSubviewToFront:fromView];
        [UIView animateWithDuration:duration animations:^{
            
            fromView.frame = CGRectOffset(containerBounds, 0, -CGRectGetHeight(containerBounds));
        }completion:^(BOOL finished) {
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
    
    
}

@end
