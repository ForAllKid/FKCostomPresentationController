//
//  USGPresentationController.m
//  USGPresentationController
//
//  Created by ForKid on 2017/11/7.
//  Copyright © 2017 forkid. All rights reserved.
//

#import "USGPresentationController.h"


@interface USGPresentationControllerBlurView : UIVisualEffectView

//@property (nonatomic, strong) UIBlurEffect *effect;

@end

@implementation USGPresentationControllerBlurView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIBlurEffectStyle style = UIBlurEffectStyleExtraLight;
        UIBlurEffect *eff = [UIBlurEffect effectWithStyle:style];
        self.effect = eff;
        
    }
    return self;
}

@end


#pragma mark -

@interface USGPresentationControllerDimmingView : UIControl


@end

@implementation USGPresentationControllerDimmingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    }
    return self;
}

@end

#pragma mark -


@interface USGPresentationControllerWrapperView : UIView



@end

@implementation USGPresentationControllerWrapperView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end


#pragma mark -

@interface USGPresentationController ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) USGPresentationControllerDimmingView *dimmingView;
@property (nonatomic, strong) USGPresentationControllerWrapperView *wrapperView;
@property (nonatomic, strong) USGPresentationControllerBlurView *blurView;

@end

@implementation USGPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        _animationStyle = USGPresentationControllerAnimationStyleFaded;
        _animationDuration = 1.35f;
        _userBlurEffect = NO;
        _roundCornerRadius = 0.f;
        _fromDirection = USGPresentationControllerDirectionFromDefault;
        
    }
    return self;
}

- (void)setAnimationStyle:(USGPresentationControllerAnimationStyle)animationStyle{
    _animationStyle = animationStyle;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration{
    _animationDuration = animationDuration;
}

- (void)setUserBlurEffect:(BOOL)userBlurEffect{
    _userBlurEffect = userBlurEffect;
}

- (void)setFromDirection:(USGPresentationControllerDirection)fromDirection {
    _fromDirection = fromDirection;
}

- (void)setRoundCornerRadius:(CGFloat)roundCornerRadius {
    _roundCornerRadius = roundCornerRadius;
}

- (UIView *)presentedView {
    return self.wrapperView;
}

- (void)presentationTransitionWillBegin{
    
    //presented view controller's view
    UIView *presentedView = super.presentedView;
    presentedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //dimming view
    
    USGPresentationControllerDimmingView *dimmingView = [[USGPresentationControllerDimmingView alloc] initWithFrame:self.containerView.bounds];
    
    dimmingView.alpha = 0.f;
    
    [dimmingView addTarget:self
                    action:@selector(dismissController)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.containerView addSubview:dimmingView];
    
    self.dimmingView = dimmingView;

    if (_userBlurEffect) {
        
        USGPresentationControllerBlurView *blurView = [[USGPresentationControllerBlurView alloc] initWithFrame:self.containerView.bounds];
        [self.containerView addSubview:blurView];
        self.blurView = blurView;
        dimmingView.backgroundColor = [UIColor clearColor];
        
    }
    
    USGPresentationControllerWrapperView *wrapperView = [[USGPresentationControllerWrapperView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
    
    presentedView.frame = wrapperView.bounds;
    [wrapperView addSubview:presentedView];
    wrapperView.layer.cornerRadius = self.roundCornerRadius;
    
    if (_userBlurEffect) {
        wrapperView.backgroundColor = [UIColor clearColor];
    }
    
    self.wrapperView = wrapperView;

    self.blurView.effect = nil;
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        self.blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        self.dimmingView.alpha = 1.f;
        
    } completion:NULL];
    
}

- (void)dismissController{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
}


- (void)presentationTransitionDidEnd:(BOOL)completed{
    
    if (completed == NO) {
        self.dimmingView = nil;
        self.wrapperView = nil;
        if (self.blurView) {
            self.blurView = nil;
        }
    }
    
}




- (void)dismissalTransitionWillBegin{
    
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
      
        self.dimmingView.alpha = 0.f;
        self.blurView.effect = nil;

    } completion:NULL];
}



- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
    if (completed) {
        self.dimmingView = nil;
        self.wrapperView = nil;
        if (self.blurView) {
            self.blurView = nil;
        }
    }
}

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
    self.wrapperView.frame = self.frameOfPresentedViewInContainerView;
}


//
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

//
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    
    CGSize presentedViewPreferSize = ((UIViewController *)container).preferredContentSize;
    CGSize superPreferSize = [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    
    if (presentedViewPreferSize.width == 0) {
        presentedViewPreferSize.width = superPreferSize.width;
    }
    
    if (presentedViewPreferSize.height == 0) {
        presentedViewPreferSize.height = superPreferSize.height;
    }
    
    
    if (container == self.presentedViewController) {
        
        return presentedViewPreferSize;
        
    }else{
        return superPreferSize;
    }
    
}

- (CGRect)frameOfPresentedViewInContainerView{
    
    CGRect containerBounds = self.containerView.bounds;
    
    //这里在[self sizeForChild]方法里面对size做了大小的处理
    CGSize presentedViewSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerBounds.size];

    CGRect presentedViewControllerFrame = CGRectMake(0, 0, presentedViewSize.width, presentedViewSize.height);
    
    presentedViewControllerFrame.origin.x = (containerBounds.size.width - presentedViewSize.width) / 2.f;
    
    BOOL isFaded = _animationStyle == USGPresentationControllerAnimationStyleFaded;
    
    if (isFaded) {
        
        presentedViewControllerFrame.origin.y = (containerBounds.size.height - presentedViewSize.height)/2;
        presentedViewControllerFrame.size.height = presentedViewSize.height;
        
    }else{
        presentedViewControllerFrame.origin.y = containerBounds.size.height - presentedViewSize.height;
        presentedViewControllerFrame.size.height = presentedViewSize.height;
    }

    
    return presentedViewControllerFrame;
}


#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? self.animationDuration : 0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{


    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];

    BOOL isFaded = self.animationStyle == USGPresentationControllerAnimationStyleFaded;
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);

    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    
    if (isFaded) {

        toView.frame = toFrame;
        
        if (isPresenting) {
            toView.alpha = 0.f;
            toView.layer.shouldRasterize = YES;
            toView.layer.rasterizationScale = UIScreen.mainScreen.scale;
            [containerView addSubview:toView];
        }

        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:1.f initialSpringVelocity:2.f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            if (isPresenting) {
                toView.alpha = 1.f;
            }else {
                fromView.alpha = 0.f;
            }
            
            
        } completion:^(BOOL finished) {
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
            
        }];
        
    
    }else{
        
        CGVector offset;
        CGFloat delta = isPresenting ? 1.f : -1.f;
        
        switch (self.fromDirection) {
                
            case USGPresentationControllerDirectionFromTop: {
    
                offset = CGVectorMake(0.f, -1.f * delta);
                
                break;
            }
                
            case USGPresentationControllerDirectionFromLeft:
                
                offset = CGVectorMake(-1.f * delta, 0.f);
                
                break;
                
            case USGPresentationControllerDirectionFromBottom:
                
                offset = CGVectorMake(0.f, 1.f * delta);

                break;
                
            case USGPresentationControllerDirectionFromRight:
                
                offset = CGVectorMake(1.f *delta, 0.f);
                
                break;
                
            default:
                
                toFrame = CGRectMake(toFrame.origin.x, CGRectGetMaxY(containerView.frame), toFrame.size.width, toFrame.size.height);

                
                break;
        }
        
        if (isPresenting) {
            
            // For a presentation, the toView starts off-screen and slides in.
            fromView.frame = fromFrame;
            
            CGRect initialToFrame = CGRectMake(containerView.frame.size.width * offset.dx,
                                               toView.frame.size.height * offset.dy,
                                               containerView.frame.size.width,
                                               toView.frame.size.height);
            
            toView.frame = initialToFrame;
            
        } else {
            
            fromView.frame = fromFrame;
            toView.frame = toFrame;
        }
        
        
        if (isPresenting){
            [containerView addSubview:toView];
        }
        
        [UIView animateWithDuration:animationDuration animations:^{
   
            
            if (isPresenting) {
                
                CGRect finalToFrame = CGRectMake(containerView.frame.size.width * offset.dx,
                                                 0.f,
                                                 containerView.frame.size.width,
                                                 toView.frame.size.height);

                toView.frame = finalToFrame;
                
            } else {
                // For a dismissal, the fromView slides off the screen.
//                fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
//                                              fromFrame.size.height * offset.dy);
            }
            
        } completion:^(BOOL finished) {

            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
            
        }];
    
    }
    
}

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


@end


#pragma mark -


@implementation UIViewController (CustomPresentationController)

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController
                                      animated:(BOOL)animated{

    [self customDirectionalPresentViewController:presentedViewController
                                   fromDirection:USGPresentationControllerDirectionFromBottom
                                        animated:animated];
}

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController
                                 fromDirection:(USGPresentationControllerDirection)fromDirection
                                      animated:(BOOL)animated {
    
    [self _customePresentViewController:presentedViewController
                         animationStyle:USGPresentationControllerAnimationStyleDirection
                          fromDirection:fromDirection
                           cornerRadius:0.f
                                useBlur:NO
                               duration:0.35f
                               animated:animated];
    
}

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController cornerRadius:(CGFloat)cornerRadius animated:(BOOL)animated {

    [self _customePresentViewController:presentedViewController
                         animationStyle:USGPresentationControllerAnimationStyleDirection
                          fromDirection:USGPresentationControllerDirectionFromDefault
                           cornerRadius:cornerRadius
                                useBlur:NO
                               duration:0.35f
                               animated:animated];

}


- (void)customFadedPresentViewController:(__kindof UIViewController *)presentedViewController animated:(BOOL)animated{
    
    [self _customePresentViewController:presentedViewController
                         animationStyle:USGPresentationControllerAnimationStyleFaded
                          fromDirection:USGPresentationControllerDirectionFromDefault
                           cornerRadius:0.f
                                useBlur:NO
                               duration:0.35f
                               animated:animated];
    
}


- (void)_customePresentViewController:(UIViewController *)presentedViewController
                       animationStyle:(USGPresentationControllerAnimationStyle)animationStyle
                        fromDirection:(USGPresentationControllerDirection)fromDirection
                         cornerRadius:(CGFloat)cornerRadius
                              useBlur:(BOOL)useBlur
                             duration:(NSTimeInterval)duration
                             animated:(BOOL)animated{
    
    USGPresentationController *presentationController = [[USGPresentationController alloc] initWithPresentedViewController:presentedViewController presentingViewController:self];
    
    presentationController.animationStyle    = animationStyle;
    presentationController.userBlurEffect    = useBlur;
    presentationController.fromDirection     = fromDirection;
    presentationController.roundCornerRadius = cornerRadius;
    presentationController.animationDuration = duration;
    
    presentedViewController.transitioningDelegate = presentationController;
    [self presentViewController:presentedViewController animated:animated completion:NULL];
    
}

@end

