//
//  DataItem.h
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, strong) NSDate *lastUseTime;
@property (nonatomic, copy) NSString *itemInfo;

- (instancetype)initWithItemName:(NSString *)name
                       itemImage:(UIImage *)image
                     lastUseTime:(NSDate *)time
                      infomation:(NSString *)info;

- (instancetype)initWithItemName:(NSString *)name
                      infomation:(NSString *)info;

- (instancetype)initWithItemName:(NSString *)name;

+ (DataItem *)randomItem;

@end
