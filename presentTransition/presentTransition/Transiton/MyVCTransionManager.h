//
//  MyVCTransionManager.h
//  presentTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyVCTransionManager : NSObject<UIViewControllerTransitioningDelegate>

//手势的交互
@property (nonatomic,readonly) UIPercentDrivenInteractiveTransition * dismissInteractiveTransition;
//是否可以进行手势交互
@property (nonatomic,assign) BOOL isCanInteractiveTransiton;

@end
