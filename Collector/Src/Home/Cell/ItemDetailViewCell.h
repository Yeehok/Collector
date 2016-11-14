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

- (void)getFocus;

- (void)enterEditMode;

- (void)exitEditMode;

- (void)setTitleText:(NSString *)text;

- (void)setContentText:(NSString *)text;

- (NSString *)titleText;

- (NSString *)contentText;

@end
