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
                        itemType:(NSString *)type
                       itemImage:(UIImage *)image
                     lastUseTime:(NSDate *)time
                      infomation:(NSString *)info {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _itemType = type;
        _itemImage = image;
        _lastUseTime = time;
        _itemInfo = info;
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
                        itemType:(NSString *)type
                      infomation:(NSString *)info {
    return [self initWithItemName:name
                         itemType:type
                        itemImage:[UIImage imageNamed:@"testimg.png"]
                      lastUseTime:[NSDate date]
                       infomation:info];
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name
                         itemType:ITEMTYPENONE
                       infomation:@""];
}

- (NSDictionary *)modelData {
    return [NSDictionary dictionaryWithObjects:@[self.itemName, self.itemType, self.itemImage, self.lastUseTime, self.itemInfo] forKeys:@[@"itemName" ,@"itemType" ,@"itemImage" ,@"lastUseTime" ,@"itemInfo"]];
}

+ (DataItem *)randomItem {
    DataItem *item = [[self alloc] initWithItemName:@"item"
                                           itemType:ITEMTYPENONE
                                          itemImage:[UIImage imageNamed:@"testimg.png"]
                                        lastUseTime:[NSDate date]
                                         infomation:@"info"];
    return item;
}

@end
