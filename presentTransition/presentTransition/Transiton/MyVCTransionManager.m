//
//  MyVCTransionManager.m
//  presentTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyVCTransionManager.h"
#import "MyVCTransionAnimator.h"

@interface MyVCTransionManager ()

//手势的交互
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition * dismissInteractiveTransition;

@end

@implementation MyVCTransionManager


- (instancetype)init {
    
    if (self = [super init]) {
        
        self.isCanInteractiveTransiton = NO;
        self.dismissInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}

//present 动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    MyVCTransionAnimator * animator = [[MyVCTransionAnimator alloc]init];
    animator.isPresent = YES;
    return animator;
}

// dismissed 动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    MyVCTransionAnimator * animator = [[MyVCTransionAnimator alloc]init];
    animator.isPresent = NO;
    return animator;
}

//present 交互
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    
    return nil;
}

//dismiss交互
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    if (self.isCanInteractiveTransiton) {
        
        return self.dismissInteractiveTransition;
    }
    return nil;
}




@end
