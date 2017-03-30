//
//  MyNaviController.m
//  NavTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyNaviController.h"
#import "MyNaiTransitionManager.h"


@interface MyNaviController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) MyNaiTransitionManager * transitionManager;

@end

@implementation MyNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.transitionManager = [[MyNaiTransitionManager alloc]init];
    self.delegate = self.transitionManager;
    // 防止手势冲突
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    
    //只有pop的时候才会触发
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panPopAction:)];
    //在左边 边缘能够 处理
    popRecognizer.edges = UIRectEdgeLeft;
    popRecognizer.delegate = self;
    [self.view addGestureRecognizer:popRecognizer];
    
}

#pragma mark - 私有action方法
- (void)panPopAction:(UIScreenEdgePanGestureRecognizer*)popRecognizer {
    
    CGFloat translationX = [popRecognizer translationInView:self.view].x;
    CGFloat progress = fabs(translationX)/CGRectGetWidth(self.view.frame);
    switch (popRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            self.transitionManager.isActive = YES;
            [self popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            /* 比例的更新**/
            [self.transitionManager.interactivePopTransition updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            if (progress > 0.5) {
                
                [self.transitionManager.interactivePopTransition finishInteractiveTransition];
            } else {
                [self.transitionManager.interactivePopTransition cancelInteractiveTransition];
            }
            self.transitionManager.isActive = NO;
            break;
        }
        default: {
            
            [self.transitionManager.interactivePopTransition cancelInteractiveTransition];
            self.transitionManager.isActive = NO;
            break;
        }
            
    }

}


#pragma mark - 手势代理方法
// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断下当前控制器是否是跟控制器
    return (self.topViewController != [self.viewControllers firstObject]&& ![[self valueForKey:@"_isTransitioning"] boolValue]);
}



@end
