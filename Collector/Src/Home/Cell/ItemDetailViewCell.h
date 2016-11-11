//
//  ItemDetailViewCell.h
//  Collector
//
//  Created by Yeehok on 2016/11/11.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "UIBase.h"

@class DataItem;

@interface ItemDetailViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UITextField *currentText;

- (void)enterEditMode;

- (void)exitEditMode;

@end
