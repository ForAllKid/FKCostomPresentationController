//
//  USGPresentationController.h
//  USGPresentationController
//
//  Created by ForKid on 2017/11/7.
//  Copyright © 2017 forkid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


NS_ENUM_AVAILABLE_IOS(8_0) typedef NS_ENUM(NSInteger, USGPresentationControllerAnimationStyle) {
    USGPresentationControllerAnimationStyleFaded = 0,
    USGPresentationControllerAnimationStyleDirection,
};

NS_ENUM_AVAILABLE_IOS(8_0) typedef NS_ENUM(NSUInteger, USGPresentationControllerDirection) {
    USGPresentationControllerDirectionFromTop = 0,
    USGPresentationControllerDirectionFromLeft,
    USGPresentationControllerDirectionFromBottom,
    USGPresentationControllerDirectionFromRight,
    USGPresentationControllerDirectionFromDefault = USGPresentationControllerDirectionFromBottom,
};

NS_CLASS_AVAILABLE_IOS(8_0) @interface USGPresentationController : UIPresentationController
<UIViewControllerTransitioningDelegate>


/**
 animation style, default is 'USGPresentationControllerAnimationStyleFaded'
 */
@property (nonatomic) USGPresentationControllerAnimationStyle animationStyle;

/**
 the presented view controller's view direction when showing, default is from bottom
 
 NOTE: it only used when the animationStyle is 'USGPresentationControllerAnimationStyleDirection'
 */
@property (nonatomic) USGPresentationControllerDirection fromDirection;

/**
animation duration, default is 0.35s
 */
@property (nonatomic) NSTimeInterval animationDuration;

/**
 use blur effect or not, default is NO
 */
@property (nonatomic) BOOL userBlurEffect;

/**
 round corner, default is 0.f
 */
@property (nonatomic) CGFloat roundCornerRadius;

@end


#pragma mark -

@interface UIViewController (CustomPresentationController)


/**
 prensent a view controller by default direction

 @param presentedViewController the presented view controller
 @param animated use animation or not
 */
- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController
                                      animated:(BOOL)animated;

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController
                                 fromDirection:(USGPresentationControllerDirection)fromDirection
                                      animated:(BOOL)animated;

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)presentedViewController
                                  cornerRadius:(CGFloat)cornerRadius
                                      animated:(BOOL)animated;

- (void)customFadedPresentViewController:(__kindof UIViewController *)presentedViewController
                                animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
