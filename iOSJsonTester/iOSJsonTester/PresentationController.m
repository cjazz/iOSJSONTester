//
//  PresentationController.m

#import "PresentationController.h"

@interface PresentationController ()

@property (nonatomic, readonly) UIView *dimmingView;

@end

@implementation PresentationController

- (UIView *)dimmingView
{
    static UIView *instance = nil;
    if (instance == nil) {
        instance = [[UIView alloc] initWithFrame:self.containerView.bounds];
        instance.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return instance;
}

- (void)presentationTransitionWillBegin
{
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 5;
    presentedView.layer.shadowColor = [[UIColor blackColor] CGColor];
    presentedView.layer.shadowOffset = CGSizeMake(0, 10);
    presentedView.layer.shadowRadius = 5;
    presentedView.layer.shadowOpacity = 0.5;

    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0;
    [self.containerView addSubview:self.dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
     if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGFloat wSize = 375; //320
    CGFloat hSize = 300; //295
    CGRect frame = CGRectMake((self.containerView.frame.size.width - wSize) / 2,(self.containerView.frame.size.height - hSize) / 2, wSize, hSize);
    return frame;
}

- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

@end
