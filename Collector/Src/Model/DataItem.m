//
//  DataItem.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "DataItem.h"

@implementation DataItem

- (instancetype)initWithItemName:(NSString *)name
                       itemImage:(UIImage *)image
                     lastUseTime:(NSDate *)time
                      infomation:(NSString *)info {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _itemImage = image;
        _lastUseTime = time;
        _itemInfo = info;
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
                      infomation:(NSString *)info {
    return [self initWithItemName:name
                        itemImage:nil
                      lastUseTime:[NSDate date]
                       infomation:info];
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name
                       infomation:@""];
}

+ (DataItem *)randomItem {
    DataItem *item = [[self alloc] initWithItemName:@"item"
                                          itemImage:nil
                                        lastUseTime:[NSDate date]
                                         infomation:@"info"];
    return item;
}

@end
