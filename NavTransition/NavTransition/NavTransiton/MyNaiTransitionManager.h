//
//  MyNaiTransitionManager.h
//  NavTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNaiTransitionManager : NSObject<UINavigationControllerDelegate>

//回退的交互 ，通过 手势的 来更改 它的 progress、finished、cancel
@property (nonatomic, readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic,assign) BOOL isActive;

@end
