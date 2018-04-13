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
#import "FKNavigationController.h"

@class CellItem;

typedef void(^CellItemHandler)(CellItem *item);

@interface CellItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) CellItemHandler handler;

+ (CellItem *)itemWithTitle:(NSString *)title handler:(CellItemHandler)handler;

@end

@implementation CellItem

+ (CellItem *)itemWithTitle:(NSString *)title handler:(CellItemHandler)handler {
    
    CellItem *one = [self.class new];
    one->_title = title;
    one->_handler = handler;
    
    return one;
    
}

@end


//MARK: -

@interface CellItemGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray <CellItem *> *items;

@end

@implementation CellItemGroup

- (NSMutableArray<CellItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

@end



//MARK: -


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <CellItemGroup *> *groups;

@end

@implementation ViewController


//MARK: LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUISet];
}

//MARK: Override

//MARK: UISet

- (void)configUISet{
    self.title = @"Test";
    [self.view addSubview:self.tableView];
}

//MARK: Delegate && DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.groups[section].title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.groups[indexPath.section].items[indexPath.row].title;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CellItem *item = self.groups[indexPath.section].items[indexPath.row];
    
    if (item.handler) {
        item.handler(item);
    }
}


//MARK: Actions

//MARK: Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

//MARK: NotificationCenter

//MARK: Observer

//MARK: Setter

//MARK: Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray<CellItemGroup *> *)groups {
    if (!_groups) {
        
        CellItemGroup *groupOne = [CellItemGroup new];
        groupOne.title = @"viewControllerTest";
        
        {
            CellItem *one_fade = [CellItem itemWithTitle:@"Fade" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                [self customFadedPresentViewController:controller animated:YES];
                
            }];
            
            
            
            CellItem *one_Dir = [CellItem itemWithTitle:@"Dir" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                [self customDirectionalPresentViewController:controller animated:YES];
                
            }];
            
            
            CellItem *one_Dir_Cor = [CellItem itemWithTitle:@"Dir&Corner" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                [self customDirectionalPresentViewController:controller cornerRadius:10.f animated:YES];
                
            }];
            
            [groupOne.items addObjectsFromArray:@[one_fade, one_Dir, one_Dir_Cor]];
            
        }
    
        
        CellItemGroup *groupOne_Nav = [CellItemGroup new];
        
        groupOne_Nav.title = @"navigationControllerTest";
        
        {
            
            CellItem *one_fade = [CellItem itemWithTitle:@"Fade" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                FKNavigationController *nav = [FKNavigationController initWithController:controller];
                [self customFadedPresentViewController:nav animated:YES];
                
            }];
            
            
            CellItem *one_Dir = [CellItem itemWithTitle:@"Dir" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                FKNavigationController *nav = [FKNavigationController initWithController:controller];
                [self customDirectionalPresentViewController:nav animated:YES];
                
            }];
            
            
            CellItem *one_Dir_Cor = [CellItem itemWithTitle:@"Dir&Corner" handler:^(CellItem *item) {
                
                NextViewController *controller = [NextViewController new];
                FKNavigationController *nav = [FKNavigationController initWithController:controller];
                [self customDirectionalPresentViewController:nav cornerRadius:10.f animated:YES];
                
            }];
            
            [groupOne_Nav.items addObjectsFromArray:@[one_fade, one_Dir, one_Dir_Cor]];

        }

        _groups = @[groupOne, groupOne_Nav];
    }
    return _groups;
}

@end
