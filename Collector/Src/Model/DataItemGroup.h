//
//  DataItemModel.h
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "UIBase.h"

#import "DataItem.h"

@interface DataItemGroup : NSObject

@property (nonatomic, strong, readonly, getter=allItems) NSArray *allItems;
@property (nonatomic, copy, readonly, getter=currentType) NSString *type;

- (void)addObject:(DataItem *)item;

- (void)insertObject:(DataItem *)item atIndex:(NSUInteger)index;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)moveDataItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
