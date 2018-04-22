//
//  FKNavigationController.m
//  FKCustomPresentationController
//
//  Created by 周宏辉 on 2018/4/13.
//  Copyright © 2018年 forkid. All rights reserved.
//

#import "FKNavigationController.h"

@interface FKNavigationController ()

@end

@implementation FKNavigationController

+ (FKNavigationController *)initWithController:(UIViewController *)controller {
    FKNavigationController *nav = [[FKNavigationController alloc] initWithRootViewController:controller];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
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
