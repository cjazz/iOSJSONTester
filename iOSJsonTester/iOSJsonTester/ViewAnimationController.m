//
//  ViewAnimationController.m
//

#import "ViewAnimationController.h"

// Common Modal presentation

@implementation ViewAnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.isAppearing ? 0.4: 0.7;
}


//  Up and Down
- (void)animateTransition:(id)transitionContext
{
    // Obtain view state from the Context:
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // Obtain the container view:
    UIView *containerView = [transitionContext containerView];
    
    // Set the initial state:
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGAffineTransform completionTranslationTransform;
    UIViewController *animatingViewController;
    

    if (self.appearing) // Presenting
    {
        animatingViewController = toViewController;
        
        CGAffineTransform startingTranslationTransform = CGAffineTransformMakeTranslation(0, screenBounds.size.height);
        
        completionTranslationTransform = CGAffineTransformIdentity;
        
        // Set the toViewController to its initial position, since it wouldn't be on screen as yet:
        toViewController.view.transform = startingTranslationTransform;
        
        // Add the view of the incoming view controller:
        [containerView addSubview:toViewController.view];
    }
    else // Dismissing
    {
        animatingViewController = fromViewController;
        completionTranslationTransform = CGAffineTransformMakeTranslation(0, screenBounds.size.height);
    }
    
    // Animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0.35
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         animatingViewController.view.transform = completionTranslationTransform;
                     }
                     completion:^(BOOL finished){
                         if (!self.appearing)
                         {
                             // Removing fromViewController only on Dismissal
                             [fromViewController.view removeFromSuperview];
                         }
                         // Inform the context of completion:
                         [transitionContext completeTransition:YES];
                     }];
}

@end
