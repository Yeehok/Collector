//
//  ItemListViewController.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemListViewController.h"

#import "DataItemModel.h"
#import "Masonry.h"

@interface ItemListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataItemModel *model;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIToolbar *headerBar;

@end

@implementation ItemListViewController

- (void)loadData {
    self.model = [DataItemModel getInstance];
    
    [self.model createGroupWithInitialiseItem:[[DataItem alloc] initWithItemName:@"Black"
                                                                        itemType:@"Sweater"
                                                                     lastUseTime:[NSDate date]
                                                                      infomation:@"1"]];
    [((DataItemGroup *)self.model.allGroups[0]) addObject:[[DataItem alloc] initWithItemName:@"white"
                                                                                    itemType:@"Sweater"
                                                                                 lastUseTime:[NSDate date]
                                                                                  infomation:@"2"]];
    [((DataItemGroup *)self.model.allGroups[0]) addObject:[[DataItem alloc] initWithItemName:@"color"
                                                                                    itemType:@"Sweater"
                                                                                 lastUseTime:[NSDate date]
                                                                                  infomation:@"3"]];
    
    [self.model createGroupWithInitialiseItem:[[DataItem alloc] initWithItemName:@"Thin blue"
                                                                        itemType:@"Jeans"
                                                                     lastUseTime:[NSDate date]
                                                                      infomation:@"4"]];
    
    [self.model createGroupWithInitialiseItem:[[DataItem alloc] initWithItemName:@"Select dark blue"
                                                                        itemType:@"Coats"
                                                                     lastUseTime:[NSDate date]
                                                                      infomation:@"7"]];
    [((DataItemGroup *)self.model.allGroups[2]) addObject:[[DataItem alloc] initWithItemName:@"OnePiece black"
                                                                                    itemType:@"Coats"
                                                                                 lastUseTime:[NSDate date]
                                                                                  infomation:@"8"]];
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testimg"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.headerBar = [[UIToolbar alloc] init];
    self.headerBar.translucent = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerBar];
    
    //
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
//    [btn addTarget:self action:@selector(pushbutton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    //
    
    [self.headerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).with.offset(64);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.headerBar.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.model.allGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [((DataItemGroup *)self.model.allGroups[section]).allItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    DataItemGroup *t = self.model.allGroups[indexPath.section];
    DataItem *i = [t.allItems objectAtIndex:indexPath.row];
    cell.textLabel.text = i.itemName;
    cell.detailTextLabel.text = i.itemInfo;
    
    NSLog(@"CELL信息：%@", cell);
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((DataItemGroup *)self.model.allGroups[section]).type;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    return @"the same FOOTER!";
//}

@end
