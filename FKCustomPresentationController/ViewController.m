//
//  ViewController.m
//  FKCustomPresentationController
//
//  Created by 周宏辉 on 2018/4/3.
//  Copyright © 2018年 forkid. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "USGPresentationController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


- (IBAction)normalPresent:(UIButton *)sender {

    NextViewController *controller = [NextViewController new];
    
    [self customDirectionalPresentViewController:controller animated:YES];
    
}

- (IBAction)RoundPresent:(UIButton *)sender {

    CGFloat corner = [self.textField.text floatValue];
    
    NextViewController *controller = [NextViewController new];
    
    [self customDirectionalPresentViewController:controller cornerRadius:corner animated:YES];
    
}

- (IBAction)fadePresent:(UIButton *)sender {
    
    NextViewController *controller = [NextViewController new];
    
    [self customFadedPresentViewController:controller animated:YES];
    
    
}


@end
