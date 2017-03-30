# Transition
动画转场和交互 tabBar、Navi、present

>[转场动画](https://github.com/lichory/Transition)主要是tabBar、Navi、present ；其实它里面设置到了  主要涉及到了 `动画`、`交互` 

**1 . TabBar的切换**
>tabbarVC  里面本身含有 `<UITabBarControllerDelegate>`这个代理，这个时候我们定义一个 `id<UITabBarControllerDelegate> `类型的实例`MyTransitionTabbarDelegateManager`是现实里面的 动画和交互，让tabBarVC的`delegate `= `MyTransitionTabbarDelegateManager`对象

下面是代码实现
>  MyTransitionTabbarDelegateManager

```
#import "MyTransitionTabbarDelegateManager.h"
#import "MyTransitionTabBarAnimator.h"

@interface MyTransitionTabbarDelegateManager ()

@property (nonatomic,strong) UIPercentDrivenInteractiveTransition * interactiveTransition;

@end

@implementation MyTransitionTabbarDelegateManager

- (instancetype)init {

if (self = [super init]) {

self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
self.interactive = NO;
}
return self;
}


//切换动画
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
NSInteger toIndex   = [tabBarController.viewControllers indexOfObject:toVC];

NSLog(@"from:%@;to:%@",fromVC,toVC);

/* 确定方向 **/
MyTransitionTabBarAnimator * animator = [[MyTransitionTabBarAnimator alloc]init];
animator.isSlideToRight = fromIndex > toIndex?YES:NO;
return animator;
}

//交互动画
- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {

if (self.interactive) {

return self.interactiveTransition;
}
return nil;
}



@end

```

>交互主要是 通过实现 tabBarVC的子类，在里面添加手势 

```
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
```

>里面的 `动画MyTransitionTabBarAnimator` 主要是实现`动画时间`和`动画交互` ，接下来就是交互 我们通过 `MyTransitionTabbarDelegateManager` 里面的 `UIPercentDrivenInteractiveTransition` 主要是控制百分比、取消和完成


**2 . 导航的切换**
> 也是一样我们定义一个对象遵循 `<UINavigationControllerDelegate>` 协议的一个对象`MyNaiTransitionManager` 来管理 里面的 `动画` 和 `交互`

**3 . present的切换**

>也是一样，假设 vc1 =present =》vc2，这个时候需要实现 vc2的代理`UIViewControllerTransitioningDelegate`的实例 `MyVCTransionManager` ,其实我们可以要知道 在vc2 中我们才能获取到 vc1的view 和vc2的view




