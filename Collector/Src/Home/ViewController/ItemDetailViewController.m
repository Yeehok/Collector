//
//  ItemDetailViewController.m
//  Collector
//
//  Created by Yeehok on 2016/11/1.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemDetailViewController.h"

#import <Masonry.h>

@interface ItemDetailViewController ()

@property (nonatomic, strong) UITextField *itemName;
@property (nonatomic, strong) UITextField *itemInfo;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemName = [[UITextField alloc] init];
    self.itemInfo = [[UITextField alloc] init];
    
    self.itemName.backgroundColor = [UIColor grayColor];
    self.itemInfo.backgroundColor = [UIColor grayColor];
    
    self.itemName.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.itemName];
    [self.view addSubview:self.itemInfo];
    
    /*
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn addTarget:self action:@selector(pushbutton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    */
    
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

@end
