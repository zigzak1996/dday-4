//
//  PresentDetailTransition.m
//  day 4
//
//  Created by Student on 18.06.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "PresentDetailTransition.h"

@implementation PresentDetailTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *detailVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    detailVC.view.alpha=0.0;
    
    CGRect frame = containerView.bounds;
    frame.origin.y+=20;
    frame.size.height-=20;
    
    detailVC.view.frame=frame;
    [containerView addSubview:detailVC.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        detailVC.view.alpha=1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
