//
//  ItemDatePickerViewController.m
//  Collector
//
//  Created by Yeehok on 2016/11/15.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemDatePickerViewController.h"

#import "masonry.h"

@interface ItemDatePickerViewController ()

@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) NSArray *barItems;

@end

@implementation ItemDatePickerViewController

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.picker = [[UIDatePicker alloc] init];
        
        self.toolbar = [[UIToolbar alloc] init];
        
        self.tableView = [[UITableView alloc] init];
        
        self.barItems = [[NSArray alloc] initWithObjects:
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                       target:nil
                                                                       action:nil],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                       target:self
                                                                       action:@selector(pushDoneButton)],
                         nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildToolbar];
    
    [self buildDatePicker];
    
    [self buildTableView];
}

#pragma mark Table view

- (void)buildTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolbar.mas_bottom);
        make.bottom.equalTo(self.picker.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

#pragma mark Data picker

- (void)buildDatePicker {
    [self.view addSubview:self.picker];
    
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@300);
    }];
}

#pragma mark Tool bar

- (void)buildToolbar {
    [self.view addSubview:self.toolbar];
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(STATUSBARHEIGHT + HEADERVIEWHEIGHT));
    }];
    self.toolbar.items = self.barItems;
}

- (void)pushDoneButton {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Finish setting!");
    }];
}

@end
