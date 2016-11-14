//
//  ItemListViewController.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemListViewController.h"
#import "Masonry.h"

#import "DataItemModel.h"
#import "ItemDetailViewController.h"

@interface ItemListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataItemModel *model;
@property (nonatomic, strong) UIBarButtonItem *searchButton;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) ItemDetailViewController *detailViewController;
@property (nonatomic, assign) NSIndexPath* reloadIndexPath;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self buildNavigationBar];
    
    [self buildTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.reloadIndexPath != nil) {
        [self.tableView reloadRowsAtIndexPaths:@[self.reloadIndexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        self.reloadIndexPath = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark Table view (delegate/data sources)

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
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((DataItemGroup *)self.model.allGroups[section]).type;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    return @"the same FOOTER!";
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DataItemGroup *group = [[self.model allGroups] objectAtIndex:indexPath.section];
        [group removeObjectAtIndex:indexPath.row];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([[group allItems] count] == 0) {
            [self.model removeGroup:group];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                          withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataItem *currentItem = [[((DataItemGroup *)[[self.model allGroups] objectAtIndex:indexPath.section]) allItems] objectAtIndex:indexPath.row];
    [self buildDetailViewController];
    [self.detailViewController setCurrentItem:currentItem];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.reloadIndexPath = indexPath;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

#pragma mark Navigation bar

- (void)buildNavigationBar {
    self.navigationItem.title = NSLocalizedString(@"softwareName", nil);
    
    self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                      target:self
                                                                      action:@selector(pushSearchButton)];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                    target:self
                                                                    action:@selector(pushEditButton)];
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:self
                                                                   action:@selector(pushAddButton)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(pushDoneButton)];
    
    self.navigationItem.leftBarButtonItem = self.searchButton;
    self.navigationItem.rightBarButtonItem = self.editButton;
}

- (void)pushSearchButton {
}

- (void)pushEditButton {
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.leftBarButtonItem = self.addButton;
    self.navigationItem.rightBarButtonItem = self.doneButton;
}

- (void)pushAddButton {
    [self buildDetailViewController];
    [self.detailViewController setCurrentItem:nil];
    
    [self pushDoneButton];
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)pushDoneButton {
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.leftBarButtonItem = self.searchButton;
    self.navigationItem.rightBarButtonItem = self.editButton;
}

- (void)buildDetailViewController {
    if (self.detailViewController == nil) {
        self.detailViewController = [[ItemDetailViewController alloc] init];
    }
}

#pragma mark Table view build

- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.reloadIndexPath = nil;
}

#pragma mark test

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
}

@end
