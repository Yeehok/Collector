//
//  DataItemStore.m
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "DataItemStore.h"

@interface DataItemStore ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation DataItemStore

static DataItemStore *instance = nil;

+ (instancetype)getInstance {
    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] initPrivate];
        }
    }
    return instance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"This is singleton class"
                                   reason:@"Use +[DataItemStore getInstance];"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self != nil) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems {
    return [self.items copy];
}

- (DataItem *)createItem {
    DataItem *item = [DataItem randomItem];
    [self.items addObject:item];
    return item;
}

@end
