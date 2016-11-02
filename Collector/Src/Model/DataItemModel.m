//
//  DataItemModel.m
//  Collector
//
//  Created by Yeehok on 2016/10/31.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "DataItemModel.h"

@interface DataItemModel ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation DataItemModel

static DataItemModel *instance;

+ (instancetype)getInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[self alloc] initPrivate];
    });
    return instance;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        self.groups = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)insertGroupWithInitialiseItem:(DataItem *)item atIndex:(NSUInteger)index {
    DataItemGroup *group = [[DataItemGroup alloc] init];
    [group addObject:item];
    [self.groups insertObject:group atIndex:index];
}

- (void)createGroupWithInitialiseItem:(DataItem *)item {
    DataItemGroup *group = [[DataItemGroup alloc] init];
    [group addObject:item];
    [self.groups addObject:group];
}

- (NSArray *)allGroups {
    [self checkEmptyGroup];
    return [self.groups copy];
}

- (void)checkEmptyGroup {
    for (NSUInteger i = 0; i < [self.groups count]; i++) {
        if ([((DataItemGroup *)self.groups[i]).allItems count] == 0) {
            [self.groups removeObjectAtIndex:i];
            i--;
        }
    }
}

@end
