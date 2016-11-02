//
//  DataItemModel.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "DataItemGroup.h"

@interface DataItemGroup ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation DataItemGroup

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems {
    return [self.items copy];
}

- (void)addObject:(DataItem *)item {
    [self.items addObject:item];
}

- (void)insertObject:(DataItem *)item atIndex:(NSUInteger)index {
    [self.items insertObject:item atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.items removeObjectAtIndex:index];
}

- (DataItem *)createItem {
    DataItem *item = [DataItem randomItem];
    [self.items addObject:item];
    return item;
}

- (NSString *)currentType {
    if ([self.items count]) {
        NSString *type = ((DataItem *)[self.items firstObject]).itemType;
        return type;
    }
    return @"no type!";
}

@end
