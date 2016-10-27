//
//  ItemListViewController.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemListViewController.h"
#import "DataItemStore.h"

@interface ItemListViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 5; i++) {
        [[DataItemStore getInstance] createItem];
    }
    CGRect headerRect = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    
    UIView *headerView = [[UIView alloc] initWithFrame:headerRect];
    headerView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:headerView];
    
    CGRect tableect = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:tableect
                                                  style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataItemStore getInstance] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [[[[DataItemStore getInstance] allItems] objectAtIndex:indexPath.row] itemName];
    
    return cell;
}

@end