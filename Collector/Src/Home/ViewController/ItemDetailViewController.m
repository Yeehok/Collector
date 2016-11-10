//
//  ItemDetailViewController.m
//  Collector
//
//  Created by Yeehok on 2016/11/1.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Masonry.h"

#import "DataItemModel.h"

@interface ItemDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataItem *item;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *generalArray;
@property (nonatomic, strong) NSMutableArray *detailArray;

@end

@implementation ItemDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNavigationBar];
    
    [self buildTableView];
    
}

#pragma mark Interface

- (void)setCurrentItem:(DataItem *)item {
    self.item = item;
}

#pragma mark Navigation bar

- (void)buildNavigationBar {
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(pushDoneButton)];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    self.navigationItem.title = NSLocalizedString(@"detailTitle", nil);
}

- (void)pushDoneButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table view

- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.dataSource = [[NSMutableArray alloc] init];
    self.generalArray = [[NSMutableArray alloc] init];
    self.detailArray = [[NSMutableArray alloc] init];
    
    UITableViewCell *itemNameCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    itemNameCell.textLabel.text = NSLocalizedString(@"itemName", nil);
    itemNameCell.textLabel.textColor = [UIColor blackColor];
    itemNameCell.detailTextLabel.text = @"";
    [self.generalArray addObject:itemNameCell];
    
    UITableViewCell *itemTypeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    itemTypeCell.textLabel.text = NSLocalizedString(@"itemType", nil);
    itemTypeCell.textLabel.textColor = [UIColor blackColor];
    itemTypeCell.detailTextLabel.text = @"";
    [self.generalArray addObject:itemTypeCell];
    
    UITableViewCell *itemInfoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    itemInfoCell.textLabel.text = NSLocalizedString(@"itemInfo", nil);
    itemInfoCell.textLabel.textColor = [UIColor blackColor];
    itemInfoCell.detailTextLabel.text = @"";
    [self.detailArray addObject:itemInfoCell];
    
    [self.dataSource addObject:self.generalArray];
    [self.dataSource addObject:self.detailArray];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    cell.detailTextLabel = YES;
}

@end
