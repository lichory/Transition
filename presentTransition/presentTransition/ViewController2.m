//
//  ViewController2.m
//  presentTransition
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController2.h"
#import "MyVCTransionManager.h"

@interface ViewController2 ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) MyVCTransionManager * transionManager;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.transionManager = [[MyVCTransionManager alloc]init];
    self.transitioningDelegate = self.transionManager;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断下当前控制器是否是跟控制器
    
    UIPanGestureRecognizer * pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGFloat vY = [pan velocityInView:self.view].y;
    //下拉禁止，只能上提
    if (vY > 0) {
        return NO;
    }
    return YES;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGFloat translationY = [pan translationInView:self.view].y;
    CGFloat progress = fabs(translationY)/CGRectGetHeight(self.view.frame);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            
            self.transionManager.isCanInteractiveTransiton = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            /* 比例的更新**/
            [self.transionManager.dismissInteractiveTransition updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            if (progress > 0.5) {
                
                [self.transionManager.dismissInteractiveTransition finishInteractiveTransition];
            } else {
                [self.transionManager.dismissInteractiveTransition cancelInteractiveTransition];
            }
            self.transionManager.isCanInteractiveTransiton = NO;
            break;
        }
        default: {
            
            self.transionManager.isCanInteractiveTransiton = NO;
            break;
        }
            
    }
}


- (IBAction)dismissClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
