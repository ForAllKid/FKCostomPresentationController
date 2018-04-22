//
//  USGPresentationController.h
//  USGPresentationController
//
//  Created by ForKid on 2017/11/7.
//  Copyright © 2017年 bottle. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, USGPresentationControllerAnimationStyle) {
    USGPresentationControllerAnimationStyleFaded = 0,//渐变
    USGPresentationControllerAnimationStyleDirection,//弹出
};


NS_CLASS_AVAILABLE_IOS(8_0) @interface USGPresentationController : UIPresentationController
<UIViewControllerTransitioningDelegate>


/**
 动画风格，默认Faded
 */
@property (nonatomic) USGPresentationControllerAnimationStyle animationStyle;

/**
 动画时间 默认0.35s
 */
@property (nonatomic) NSTimeInterval animationDuration;

/**
 是否启用毛玻璃效果，默认为NO
 */
@property (nonatomic) BOOL userBlurEffect;

///圆角
@property (nonatomic) CGFloat roundCornerRadius;

@end


#pragma mark -

@interface UIViewController (CustomPresentationController)


- (void)customDirectionalPresentViewController:(__kindof UIViewController *)controller animated:(BOOL)animated;

- (void)customDirectionalPresentViewController:(__kindof UIViewController *)controller cornerRadius:(CGFloat)cornerRadius animated:(BOOL)animated;

- (void)customFadedPresentViewController:(__kindof UIViewController *)controller animated:(BOOL)animated;

- (void)customPresentViewWithPresentationController:(id<UIViewControllerTransitioningDelegate>)presentationController presentedViewController:(__kindof UIViewController *)controller animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
