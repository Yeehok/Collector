//
//  ItemDetailViewCell.m
//  Collector
//
//  Created by Yeehok on 2016/11/11.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "ItemDetailViewCell.h"
#import "Masonry.h"

#import "DataItem.h"

@interface ItemDetailViewCell ()

@property (nonatomic, assign) BOOL canEdit;

@end

@implementation ItemDetailViewCell

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self buildLabel];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(15);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.equalTo(@90);
        }];
        
        [self.currentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.equalTo(@200);
        }];
    }
    
    return self;
}

#pragma mark Interface

- (void)enterEditMode {
    self.title.textColor = [UIColor blackColor];
    self.canEdit = YES;
}

- (void)exitEditMode {
    self.title.textColor = [UIColor darkGrayColor];
    [self.currentText resignFirstResponder];
    self.canEdit = NO;
}

#pragma mark Label

- (void)buildLabel {
    self.title = [[UILabel alloc] init];
    self.currentText = [[UITextField alloc] init];
    self.currentText.delegate = self;
    self.currentText.returnKeyType = UIReturnKeyDone;
    
    [self exitEditMode];
    
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.currentText];
}

#pragma mark TextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.canEdit;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.currentText resignFirstResponder];
    return YES;
}

@end
