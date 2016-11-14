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

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UITextField *content;
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
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.equalTo(@200);
        }];
    }
    
    return self;
}

#pragma mark Interface

- (void)getFocus {
    [self.content becomeFirstResponder];
}

- (void)enterEditMode {
    self.content.textColor = [UIColor blackColor];
    self.canEdit = YES;
}

- (void)exitEditMode {
    self.content.textColor = [UIColor grayColor];
    [self.content resignFirstResponder];
    self.canEdit = NO;
}

#pragma mark Label

- (void)buildLabel {
    self.title = [[UILabel alloc] init];
    self.content = [[UITextField alloc] init];
    self.content.delegate = self;
    self.content.returnKeyType = UIReturnKeyDone;
    
    [self exitEditMode];
    
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.content];
}

#pragma mark TextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.canEdit;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.content resignFirstResponder];
    return YES;
}

- (void)setTitleText:(NSString *)text {
    self.title.text = text;
}

- (void)setContentText:(NSString *)text {
    self.content.text = text;
}

- (NSString *)titleText {
    return self.title.text;
}

- (NSString *)contentText {
    return self.content.text;
}

@end
