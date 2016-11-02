//
//  DataItem.h
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "UIBase.h"

@interface DataItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemType;
@property (nonatomic, strong) NSDate *lastUseTime;
@property (nonatomic, copy) NSString *itemInfo;

- (instancetype)initWithItemName:(NSString *)name
                        itemType:(NSString *)type
                     lastUseTime:(NSDate *)time
                      infomation:(NSString *)info;

- (instancetype)initWithItemName:(NSString *)name
                        itemType:(NSString *)type
                      infomation:(NSString *)info;

- (instancetype)initWithItemName:(NSString *)name;

@end
