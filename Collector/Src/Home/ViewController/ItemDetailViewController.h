//
//  ItemDetailViewController.h
//  Collector
//
//  Created by Yeehok on 2016/11/1.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "UIBase.h"

@class DataItem;

@interface ItemDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (void)setCurrentItem:(DataItem *)item;

@end
