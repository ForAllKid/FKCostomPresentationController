//
//  NextViewController.m
//  FKCustomPresentationController
//
//  Created by 周宏辉 on 2018/4/3.
//  Copyright © 2018年 forkid. All rights reserved.
//

#import "NextViewController.h"
#import "TestViewController.h"
#import "FKNavigationController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];    
    self.preferredContentSize = CGSizeMake(100.f, 100.f);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (CGSize)preferredContentSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(screenSize.width, screenSize.height/2.f);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Test";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestViewController *controller = [TestViewController new];

    if (self.navigationController) {
        
        [self.navigationController pushViewController:controller animated:YES];
        
    } else {
        
        FKNavigationController *nav = [FKNavigationController initWithController:controller];
        [self presentViewController:nav animated:YES completion:NULL];
        
    }

}



@end
