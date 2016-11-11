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
#import "ItemDetailViewCell.h"

@interface ItemDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataItem *item;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, strong) UIBarButtonItem *editButton;
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
    self.backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                    target:self
                                                                    action:@selector(pushBackButton)];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                    target:self
                                                                    action:@selector(pushEditButton)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(pushDoneButton)];
    self.navigationItem.leftBarButtonItem = self.backButton;
    self.navigationItem.rightBarButtonItem = self.editButton;
    self.navigationItem.title = NSLocalizedString(@"detailTitle", nil);
}

- (void)pushBackButton {
    for (ItemDetailViewCell *i in self.generalArray) {
        [i exitEditMode];
    }
    for (ItemDetailViewCell *i in self.detailArray) {
        [i exitEditMode];
    }
    self.navigationItem.rightBarButtonItem = self.editButton;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushEditButton {
    for (ItemDetailViewCell *i in self.generalArray) {
        [i enterEditMode];
    }
    for (ItemDetailViewCell *i in self.detailArray) {
        [i enterEditMode];
    }
    self.navigationItem.rightBarButtonItem = self.doneButton;
}

- (void)pushDoneButton {
    for (ItemDetailViewCell *i in self.generalArray) {
        [i exitEditMode];
    }
    for (ItemDetailViewCell *i in self.detailArray) {
        [i exitEditMode];
    }
    self.navigationItem.rightBarButtonItem = self.editButton;
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
    
    ItemDetailViewCell *itemNameCell = [[ItemDetailViewCell alloc] init];
    itemNameCell.title.text = NSLocalizedString(@"itemName", nil);
    itemNameCell.currentText.text = @"1123";
    [self.generalArray addObject:itemNameCell];
    
    ItemDetailViewCell *itemTypeCell = [[ItemDetailViewCell alloc] init];
    itemTypeCell.title.text = NSLocalizedString(@"itemType", nil);
    itemTypeCell.currentText.text = @"143124713894714";
    [self.generalArray addObject:itemTypeCell];
    
    ItemDetailViewCell *itemTimeCell = [[ItemDetailViewCell alloc] init];
    itemTimeCell.title.text = NSLocalizedString(@"itemTime", nil);
    itemTimeCell.currentText.text = @"2016-11-11";
    [self.generalArray addObject:itemTimeCell];
    
    ItemDetailViewCell *itemInfoCell = [[ItemDetailViewCell alloc] init];
    itemInfoCell.title.text = NSLocalizedString(@"itemInfo", nil);
    itemInfoCell.currentText.text = @"4312413414";
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
