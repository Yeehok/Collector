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
#import "TimeCalculator.h"
#import "ItemDatePickerViewController.h"

typedef enum : NSUInteger {
    TypeItemName,
    TypeItemType,
    TypeItemTime,
    TypeItemDetail,
} ItemType;

@interface ItemDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataItem *item;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *generalArray;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) TimeCalculator *time;
@property (nonatomic, strong) ItemDatePickerViewController *datePickViewController;

@end

@implementation ItemDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildDataSource];
        self.time = [TimeCalculator getInstance];
        //table view
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //navigation bar
        self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                        target:self
                                                                        action:@selector(pushEditButton)];
        self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                        target:self
                                                                        action:@selector(pushDoneButton)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildNavigationBar];
    
    [self buildTableView];
    
}

#pragma mark Interface

- (void)setCurrentItem:(DataItem *)item {
    self.item = item;
    [self buildItemWithType:TypeItemName Index:0 Detail:self.item.itemName];
    [self buildItemWithType:TypeItemType Index:1 Detail:self.item.itemType];
    [self buildItemWithType:TypeItemTime Index:2 Detail:[self.time stringFromDate:self.item.lastUseTime]];
    [self buildItemWithType:TypeItemDetail Index:0 Detail:self.item.itemInfo];
}

#pragma mark Inner interface

- (void)buildItemWithType:(NSUInteger)type Index:(NSUInteger)index Detail:(NSString *)detail{
    ItemDetailViewCell *cell = nil;
    switch (type) {
        case TypeItemName:
        case TypeItemType:
        case TypeItemTime:
            cell = [self.generalArray objectAtIndex:index];
            [cell setContentText:detail];
            break;
        case TypeItemDetail:
            cell = [self.detailArray objectAtIndex:index];
            [cell setContentText:detail];
            break;
    }
}

- (void)saveDataToModelWithType:(ItemType)type Index:(NSUInteger)index {
    ItemDetailViewCell *cell = nil;
    switch (type) {
        case TypeItemName:
            cell = [self.generalArray objectAtIndex:index];
            self.item.itemName = [cell contentText];
            break;
        case TypeItemType:
            cell = [self.generalArray objectAtIndex:index];
            self.item.itemType = [cell contentText];
            break;
        case TypeItemTime:
            cell = [self.generalArray objectAtIndex:index];
            self.item.lastUseTime = [self.time dateFromString:[cell contentText]];
            break;
        case TypeItemDetail:
            cell = [self.detailArray objectAtIndex:index];
            self.item.itemInfo = [cell contentText];
            break;
    }
}

- (void)initDatePick {
    if (self.datePickViewController == nil) {
        self.datePickViewController = [[ItemDatePickerViewController alloc] init];
    }
}

#pragma mark Navigation bar

- (void)buildNavigationBar {
    self.navigationItem.rightBarButtonItem = self.editButton;
    self.navigationItem.title = NSLocalizedString(@"detailTitle", nil);
}

- (void)pushEditButton {
    for (ItemDetailViewCell *i in self.generalArray) {
        [i enterEditMode];
    }
    for (ItemDetailViewCell *i in self.detailArray) {
        [i enterEditMode];
    }
//    [((ItemDetailViewCell *)[self.generalArray objectAtIndex:0]) getFocus];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    self.tableView.allowsSelection = YES;
    self.canEdit = YES;
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (void)pushDoneButton {
    for (ItemDetailViewCell *i in self.generalArray) {
        [i exitEditMode];
    }
    for (ItemDetailViewCell *i in self.detailArray) {
        [i exitEditMode];
    }
    [self saveDataToModelWithType:TypeItemName Index:0];
    [self saveDataToModelWithType:TypeItemType Index:1];
    [self saveDataToModelWithType:TypeItemTime Index:2];
    [self saveDataToModelWithType:TypeItemDetail Index:0];
    
    self.navigationItem.rightBarButtonItem = self.editButton;
    self.tableView.allowsSelection = NO;
    self.canEdit = NO;
    [self.navigationItem setHidesBackButton:NO animated:YES];
}

#pragma mark Table view

- (void)buildTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.tableView.allowsSelectionDuringEditing = NO;
    self.tableView.allowsSelection = NO;
    self.canEdit = NO;
}

- (void)buildDataSource {
    self.dataSource = [[NSMutableArray alloc] init];
    self.generalArray = [[NSMutableArray alloc] init];
    self.detailArray = [[NSMutableArray alloc] init];
    
    ItemDetailViewCell *itemNameCell = [[ItemDetailViewCell alloc] init];
    [itemNameCell setTitleText:NSLocalizedString(@"itemName", nil)];
    [itemNameCell setContentText:@""];
    [self.generalArray addObject:itemNameCell];
    
    ItemDetailViewCell *itemTypeCell = [[ItemDetailViewCell alloc] init];
    [itemTypeCell setTitleText:NSLocalizedString(@"itemType", nil)];
    [itemTypeCell setContentText:@""];
    [self.generalArray addObject:itemTypeCell];
    
    ItemDetailViewCell *itemTimeCell = [[ItemDetailViewCell alloc] init];
    [itemTimeCell setTitleText:NSLocalizedString(@"itemTime", nil)];
    [itemTimeCell setContentText:@""];
    [self.generalArray addObject:itemTimeCell];
    
    ItemDetailViewCell *itemInfoCell = [[ItemDetailViewCell alloc] init];
    [itemInfoCell setTitleText:NSLocalizedString(@"itemInfo", nil)];
    [itemInfoCell setContentText:@""];
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
    if (self.canEdit == NO) {
        return;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemDetailViewCell *cell = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.row == 2) {
        [self initDatePick];
        [self presentViewController:self.datePickViewController
                           animated:YES
                         completion:^{
                             NSLog(@"Setting date!");
                         }];
    }
    else {
        [cell getFocus];
    }
}

@end
