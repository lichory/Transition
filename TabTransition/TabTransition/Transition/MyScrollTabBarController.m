//
//  MyScrollTabBarController.m
//  TabTransition
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyScrollTabBarController.h"
#import "MyTransitionTabbarDelegateManager.h"

@interface MyScrollTabBarController ()

/* 处理 页面交换 和 动画 **/
@property (nonatomic,strong) MyTransitionTabbarDelegateManager * tabBarDelegateManager;

@end

@implementation MyScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarDelegateManager = [[MyTransitionTabbarDelegateManager alloc]init];
    self.delegate = self.tabBarDelegateManager;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
    NSInteger i = 0;
    for (UIViewController * vc in self.viewControllers) {
        
        NSLog(@"vc_%ld:%@",(long)i++,vc);
    }
    
}

#pragma mark - 私有方法
- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGFloat translationX = [pan translationInView:self.view].x;
    CGFloat progress = fabs(translationX)/CGRectGetWidth(self.view.frame);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            
            self.tabBarDelegateManager.interactive = YES;
            /* 
             *根据pan的速度 来判断 滑动的方向
             * 假设 两点（x1，0），（x2，0）；
             * 如果 x1 -》x2 滑动，如果向右边滑动 那么 x2 > x1;那么x1-x2<0;
             ***/
            CGFloat vX = [pan velocityInView:self.view].x;
            if (vX < 0) { // 说明是向右边滑动
                
                NSInteger tmpSelectedIndex = self.selectedIndex +1;
                if (tmpSelectedIndex < self.viewControllers.count) {
                    self.selectedIndex = tmpSelectedIndex;
                }
            } else {
                
                NSInteger tmpSelectedIndex = self.selectedIndex -1;
                if (tmpSelectedIndex >= 0) {
                    self.selectedIndex = tmpSelectedIndex;
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            /* 比例的更新**/
            [self.tabBarDelegateManager.interactiveTransition updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            if (progress > 0.5) {
                
                [self.tabBarDelegateManager.interactiveTransition finishInteractiveTransition];
            } else {
                [self.tabBarDelegateManager.interactiveTransition cancelInteractiveTransition];
            }
            self.tabBarDelegateManager.interactive = NO;
            break;
        }
        default: {
            
            break;
        }
           
    }
}





@end
