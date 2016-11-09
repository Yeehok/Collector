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

@property (nonatomic, strong) UITextField *itemName;
@property (nonatomic, strong) UITextField *itemInfo;
@property (nonatomic, strong) DataItem *item;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation ItemDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"New";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNavigationBar];
    
    self.itemName = [[UITextField alloc] init];
    self.itemInfo = [[UITextField alloc] init];
    
    self.itemName.backgroundColor = [UIColor grayColor];
    self.itemInfo.backgroundColor = [UIColor grayColor];
    
    self.itemName.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.itemName];
    [self.view addSubview:self.itemInfo];
    
    [self.itemName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(20);
    }];
    
    [self.itemInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-20);
    }];
    
}

#pragma mark Interface

- (void)setCurrentItem:(DataItem *)item {
    self.item = item;
    self.navigationItem.title = (self.item == nil ? @"New" : [NSString stringWithFormat:@"%@ %@", self.item.itemName, self.item.itemType]);
}

#pragma mark Navigation bar

- (void)buildNavigationBar {
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(pushDoneButton)];
    self.navigationItem.rightBarButtonItem = self.doneButton;
}

- (void)pushDoneButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
